//
//  MainController.h
//  Heey
//
//  Created by Karolina França on 04/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MainController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
-(void)loadUrl:(NSString *)url;
@property (weak, nonatomic) IBOutlet UIView *StatusView;
- (IBAction)OpenMenu:(id)sender;
- (IBAction)Share:(id)sender;
- (IBAction)GoHome:(id)sender;


@end
