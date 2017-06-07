//
//  loadAsyncData.h
//  Agenda Digital
//
//  Created by Karolina França on 01/08/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol loadAsyncDataDelegate <NSObject>

@required
-(void)loadedAsyncImage:(NSData *) data FromUrl:(NSURL *) url;
-(void)errorOnloadedAsyncImageFromUrl:(NSURL *) url;
@end
@interface loadAsyncData : NSObject<NSURLConnectionDelegate>
-(void)loadAsyncImageForUrl:(NSURL *) url;
-(void)stopLoading;
@property (weak, nonatomic) id <loadAsyncDataDelegate> delegate;
@end
