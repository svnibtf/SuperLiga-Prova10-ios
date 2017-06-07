//
//  UploadFile.m
//  Car4Sale
//
//  Created by Karolina França on 09/10/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "UploadFile.h"

@implementation UploadFile
-(void)uploadFileOfPath:(NSString *) path withData:(NSData *)data withParams:(NSDictionary *)params toUrl:(NSString *) url andFieldName:(NSString *) fieldName{
    NSString *boundary = [self generateBoundaryString];
    
    NSURL * nsurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:nsurl];
    [request setHTTPMethod:@"POST"];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];

    NSData *httpBody = [self createBodyWithBoundary:boundary parameters:params data:data path:path fieldname:fieldName];
    request.HTTPBody = httpBody;
    
    _isBusy = true;

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            [_delegate errorUpload];
            _isBusy = false;
            return;
        }
        [_delegate sucessUpload:data];
        _isBusy = false;
    }];
    
    
}
- (NSData *)createBodyWithBoundary:(NSString *)boundary
                        parameters:(NSDictionary *)parameters
                             data:(NSData *)data
                          path:(NSString *)path
                         fieldname:(NSString *)fieldname
{
    NSMutableData *httpBody = [NSMutableData data];
    
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
    }];

    
    NSString *filename  = [[path lastPathComponent] lowercaseString];
    if(path == nil){
        filename = @"asset.jpg";
    }
    NSArray *stringArray = [filename componentsSeparatedByString:@"?"];
    if(stringArray.count > 1){
        filename = [stringArray objectAtIndex:0];
    }
    NSString *mimetype;
    if ([filename containsString:@".png"]) {
        mimetype = @"image/png";
            
    }else{
        mimetype = @"image/jpeg";
    }
    
    NSData *compressData = [self resizeImage:[UIImage imageWithData:data]];
    
        
    [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fieldname, filename] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", mimetype] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:compressData];
    [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [httpBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return httpBody;
}
- (NSString *)generateBoundaryString
{
    return [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];

}
-(NSData *)resizeImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 1000.0;
    float maxWidth = 1000.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return imageData;
    
}
@end
