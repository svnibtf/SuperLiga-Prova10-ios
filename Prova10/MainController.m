//
//  MainController.m
//  Heey
//
//  Created by Karolina França on 04/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "MainController.h"
#import "AppController.h"
@interface MainController (){
}
@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _StatusView.backgroundColor = [UIColor colorWithRed:0.00 green:0.35 blue:0.45 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[AppController instance] RegisterCurrentView:self];
    [[AppController instance] RegisterMainView:self];
    [[AppController instance] setCurrentStoryBoardId:@"idMainController"];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    [self loadUrl:[AppController instance].MainUrl];
}
-(void)loadUrl:(NSString *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [[AppController instance] ShowLoaderLight:YES];
    [_WebView setHidden:YES];
    [_WebView loadRequest:request];
}

- (IBAction)OpenMenu:(id)sender {
    [[AppController instance] OpenMenu];
}

- (IBAction)Share:(id)sender {
    NSArray *activityItems = @[[AppController instance].AppStoreLink];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = @[];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        activityViewControntroller.popoverPresentationController.sourceView = self.view;
        activityViewControntroller.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4, 0, 0);
    }
    [self presentViewController:activityViewControntroller animated:true completion:nil];
}

- (IBAction)GoHome:(id)sender {
    [self loadUrl:[AppController instance].MainUrl];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    [[AppController instance] ShowLoader:false];
    [_WebView setHidden:NO];
}
@end
