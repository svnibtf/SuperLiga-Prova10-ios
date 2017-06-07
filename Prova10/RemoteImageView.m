//
//  RemoteImageView.m
//  Heey
//
//  Created by Karolina França on 28/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "RemoteImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface RemoteImageView(){
    UIActivityIndicatorView * loader;
    
}
@end
@implementation RemoteImageView

-(void)loadUrl:(NSString *) url With:(UIActivityIndicatorViewStyle) style{
    self.image = nil;
    
    if(loader == nil){
        loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    }else{
        [loader setActivityIndicatorViewStyle:style];
    }

    loader.frame = CGRectMake((self.frame.size.width/2) - 12, (self.frame.size.height/2) - 12, 24, 24);
    
    NSURL *urlPath = [[NSURL alloc] initWithString:url];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:urlPath
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                if(receivedSize == 0){
                                    [self addSubview:loader];
                                    [loader startAnimating];
                                }
                            }
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                               if(image){
                                   [loader setHidden:YES];
                                   [self setImage:image];
                                   [loader removeFromSuperview];
                               }else{
                                   self.image = [UIImage imageNamed:@"noimage.png"];
                                   [loader removeFromSuperview];
                               }
                           }];

}

@end
