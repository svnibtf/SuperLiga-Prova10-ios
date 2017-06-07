//
//  UploadFile.h
//  Car4Sale
//
//  Created by Karolina França on 09/10/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol UploadFileDelegate <NSObject>

@required
-(void)errorUpload;
-(void)sucessUpload:(NSData *)response;
@end
@interface UploadFile : NSObject
@property (weak, nonatomic) id <UploadFileDelegate> delegate;
@property (nonatomic) BOOL isBusy;
-(void)uploadFileOfPath:(NSString *) path withData:(NSData *)data withParams:(NSDictionary *)params toUrl:(NSString *) url andFieldName:(NSString *) fieldName;
@end
