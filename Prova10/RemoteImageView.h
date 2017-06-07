//
//  RemoteImageView.h
//  Heey
//
//  Created by Karolina França on 28/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RemoteImageView : UIImageView
-(void)loadUrl:(NSString *) url With:(UIActivityIndicatorViewStyle) style;
@end
