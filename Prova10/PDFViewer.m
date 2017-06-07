//
//  PDFViewer.m
//  Agenda Digital
//
//  Created by Karolina França on 22/06/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "PDFViewer.h"
#import "AppController.h"
#import <Foundation/NSTextCheckingResult.h>
@interface PDFViewer ()

@end

@implementation PDFViewer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self presetNavBarConfig];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[AppController instance] RegisterCurrentView:self];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_target];
    if([self isImageType]){
        NSMutableString *html = [NSMutableString stringWithString: @"<html><head><title></title><style>img{max-width:100%; height:auto;}</style></head><body style=\"background:transparent; font-family: Helvetica, Arial, Sans-Serif; padding:0px; marging:0px; color:#333;\">"];
        
        [html appendString:[NSString stringWithFormat:@"<img src='%@'>", _target.absoluteString]];
        [html appendString:@"</body></html>"];
        [_webView loadHTMLString:[html description] baseURL:nil];
    }else{
        [_webView loadRequest:request];
    }
    
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [[AppController instance] ShowLoader:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presetNavBarConfig{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton=YES;
    UIView *addStatusBar = [[UIView alloc] init];
    addStatusBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    addStatusBar.backgroundColor = [AppController instance].NavBarBackgroundColor;
    [self.view addSubview:addStatusBar];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}
- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
   [[AppController instance] ShowLoader:false];
}
-(BOOL)isImageType{
    NSArray *imageExtensions = @[@"png", @"jpg", @"gif"]; //...
    
    for(int i = 0; i < imageExtensions.count; i++){
        if([[_target.absoluteString pathExtension] hasPrefix:[imageExtensions objectAtIndex:i]]){
            return YES;
        }
    }
    return NO;
}

@end
