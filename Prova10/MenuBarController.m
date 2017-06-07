//
//  MenuController.m
//  Heey
//
//  Created by Karolina França on 03/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "MenuBarController.h"
@interface MenuBarController(){
    loadAsyncData *loaderPhoto;
    loadAsyncData *loaderBanner;
    UIImage *banner;
    NSURL *bannerUrl;
    NSURL *photoUrl;
    BOOL isOpen;
}
@end
@implementation MenuBarController
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"MenuBarController" owner:self options:nil];
        self.bounds = self.view.bounds;
        _view.bounds = self.bounds;
        [self addSubview:self.view];
        [self initData];
    }
    return self;
}
-(void)buttonTouched{
    
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"MenuBarController" owner:self options:nil];
        self.bounds = self.view.bounds;
        _view.bounds = self.bounds;
        [self addSubview:self.view];
        [self initData];
    }
    return self;
}
-(void)initData{
    
    for(UIView *view in _BottomLineBorder){
        [AppController addBorderToEdge:UIRectEdgeBottom withColor:[UIColor whiteColor] withDimension:view.frame.size.width adThickness:1.0f toView:view];
    }
    
    _view.alpha = 0;
}

-(void)setUpMenuWithFrame{
    if(isOpen){
        [self hideMenu];
        return;
    }
    [_ScrollView setContentSize:CGSizeMake(self.frame.size.width * 2, self.frame.size.height)];
    [_ScrollView scrollRectToVisible:CGRectMake(_ScrollView.frame.size.width, 0, _ScrollView.frame.size.width, _ScrollView.frame.size.height) animated:NO];
    _view.alpha = 1;
    
    [_ScrollView scrollRectToVisible:CGRectMake(0, 0, _ScrollView.frame.size.width, _ScrollView.frame.size.height) animated:YES];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        _ContrainWidth.constant = self.frame.size.width * 2;
        _ContrainWidthMenu.constant = self.frame.size.width;
    }else{
        _ContrainWidth.constant = self.frame.size.width * 2;
        _ContrainWidthMenu.constant = self.frame.size.width;
    }
    
    isOpen = true;
    
}
-(void)hideMenu{
    [_ScrollView scrollRectToVisible:CGRectMake(_ScrollView.frame.size.width, 0, _ScrollView.frame.size.width, _ScrollView.frame.size.height) animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat viewWidth = scrollView.frame.size.width;
    
    int pageNumber = floor(scrollView.contentOffset.x /viewWidth);
    
    if(pageNumber == 1){
        if([self superview]!=nil){
            [self removeFromSuperview];
        }
         isOpen = false;
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    CGFloat viewWidth = scrollView.frame.size.width;
    
    int pageNumber = floor(scrollView.contentOffset.x /viewWidth);
    
    if(pageNumber == 1){
        if([self superview]!=nil){
            [self removeFromSuperview];
        }
        isOpen = false;
    }
    
}
- (IBAction)Actions:(id)sender {
    UIButton *btn = sender;
    switch (btn.tag) {
        case 0:
            [[AppController instance].Main loadUrl:[AppController instance].MainUrl];
            break;
        case 1:
            [[AppController instance].Main loadUrl:@"http://prova10.com.br/page-org-config.html"];
            break;
        case 2:
            [[AppController instance].Main loadUrl:@"http://prova10.com.br/page-estrategia-inicial.html"];
            break;
        case 3:
            [[AppController instance].Main loadUrl:@"http://prova10.com.br/page-estudos-inicial.html"];
            break;
        case 4:
            [[AppController instance].Main loadUrl:@"http://prova10.com.br/page-batalha-inicial.html"];
            break;
        case 5:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/channel/UCAdIUKWPYRq3TMrbc7Ixq1Q/"]];
            break;
        case 6:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/colegiosesi/?fref=ts"]];
        case 7:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/colegiosesi/?fref=ts"]];
            break;
        case 8:
            [[AppController instance].Main loadUrl:@"http://prova10.com.br/page-servicos-inicial.html"];
            break;
        case 9:
            [[AppController instance].Main loadUrl:@"http://prova10.com.br/page-ajudenos-inicial.html"];
            break;
        case 10:
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/colegiosesi/?fref=ts"]];
            break;
        case 11:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[AppController instance].AppStoreLink]];
            break;
        default:
            break;
    }
    [self hideMenu];
}

- (IBAction)Logout:(id)sender {
    [[AppController instance] Logout];
}


@end
