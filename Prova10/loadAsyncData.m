//
//  loadAsyncData.m
//  Agenda Digital
//
//  Created by Karolina França on 01/08/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "loadAsyncData.h"
@interface loadAsyncData(){
    NSMutableData *responseData;
    NSURL *urlData;
    NSURLConnection *connection;
    BOOL loading;
}
@end
@implementation loadAsyncData
-(void)loadAsyncImageForUrl:(NSURL *) url{
    loading = true;
    urlData = url;
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:60.0];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void)stopLoading{
    if(connection != nil && loading == true){
        [connection cancel];
    }
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    NSLog(@"oi");
    NSURLResponse *response = cachedResponse.response;
    if ([response isKindOfClass:NSHTTPURLResponse.class]) return cachedResponse;
    
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse*)response;
    NSDictionary *headers = HTTPResponse.allHeaderFields;
    if (headers[@"Cache-Control"]) return cachedResponse;
    
    NSMutableDictionary *modifiedHeaders = headers.mutableCopy;
    modifiedHeaders[@"Cache-Control"] = @"max-age=60";
    NSHTTPURLResponse *modifiedResponse = [[NSHTTPURLResponse alloc]
                                           initWithURL:HTTPResponse.URL
                                           statusCode:HTTPResponse.statusCode
                                           HTTPVersion:@"HTTP/1.1"
                                           headerFields:modifiedHeaders];
    
    cachedResponse = [[NSCachedURLResponse alloc]
                      initWithResponse:modifiedResponse
                      data:cachedResponse.data
                      userInfo:cachedResponse.userInfo
                      storagePolicy:cachedResponse.storagePolicy];
    
    return cachedResponse;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    loading = false;
    [_delegate errorOnloadedAsyncImageFromUrl:urlData];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    loading = false;
    [_delegate loadedAsyncImage:responseData FromUrl:urlData];
}
@end
