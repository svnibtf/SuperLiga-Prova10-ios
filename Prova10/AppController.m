//
//  AppController.m
//  Heey
//
//  Created by Karolina França on 03/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//
#import "AppController.h"
@interface AppController(){
    Reachability *reach;
    UIActivityIndicatorView * loader;
    NSUserDefaults *defaults;
    MenuBarController * Menu;
    PickerViewPopUp *PickerView;
    NSURLConnection *tokenConnection;
    BackBar *backBar;
}
@end
@implementation AppController
+ (AppController *)instance
{
    static AppController *instance;
    
    @synchronized(self)
    {
        if (!instance)
            instance = [[AppController alloc] initWithDefaultConfigurations];
        return instance;
    }
}
-(id)initWithDefaultConfigurations{
    if (self = [super init]) {
        _App = @"ios";
        _Version = @"1.0";
        _DomainLogin = @"http://prova10.com.br";
        _Domain = @"http://prova10.com.br";
        _AppStoreLink = @"https://itunes.apple.com/us/app/superliga-prova-10/id1225578779?ls=1&mt=8";
        _MainUrl = @"http://prova10.com.br/page-inicial-app-ios.html";
        _StoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _NavBarBackgroundColor = [UIColor colorWithRed:0.00 green:0.46 blue:0.59 alpha:1.0];
        defaults = [NSUserDefaults standardUserDefaults];
        __lastPass = [defaults stringForKey:@"lastpass"];
        __lastUser = [defaults stringForKey:@"lastuser"];
    }
    return self;
}
-(void)Logout{
    __lastPass = nil;
    __lastUser = nil;
    _profilePhoto = nil;
    
    [defaults removeObjectForKey:@"lastpass"];
    [defaults removeObjectForKey:@"lastuser"];
    [defaults synchronize];
    
    [_Navigation popToRootViewControllerAnimated:YES];
    
}
-(void)OpenMain{
    UIViewController *vw = [_StoryBoard instantiateViewControllerWithIdentifier:@"idMainController"];
    [_Navigation pushViewController:vw animated:YES];
}

-(void)ShowLoader:(BOOL) active{
    if(loader == nil){
        loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }else{
        [loader setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
    if(active){
        loader.frame = CGRectMake((_CurrentView.view.frame.size.width/2) - 12, (_CurrentView.view.frame.size.height/2) - 12, 24, 24);
        [_CurrentView.view addSubview:loader];
        [loader startAnimating];
    }else{
        [loader removeFromSuperview];
    }
}
-(void)ShowLoaderLight:(BOOL) active{
    if(loader == nil){
        loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }else{
        [loader setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    }
    if(active){
        loader.frame = CGRectMake((_CurrentView.view.frame.size.width/2) - 12, (_CurrentView.view.frame.size.height/2) - 12, 24, 24);
        UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow addSubview:loader];
        [loader startAnimating];
    }else{
        [loader removeFromSuperview];
    }
}
-(PickerViewPopUp *)ShowPickerViewWithOptions:(NSArray * )options AndSelectIndex:(int) index{
    if(PickerView == nil){
        PickerView = [[PickerViewPopUp alloc] init];
    }
    
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:PickerView];
    PickerView.frame = CGRectMake(0, 0, _CurrentView.view.frame.size.width, _CurrentView.view.frame.size.height);
    PickerView.center = CGPointMake(PickerView.view.frame.size.width/2, ((PickerView.view.frame.size.height/2) + (_CurrentView.view.frame.size.height - PickerView.view.frame.size.height)));
    
    [PickerView InitWithOptions:options AndSelectedIndex:index];
    [UIView animateWithDuration:0.3f animations:^{
        [PickerView.view setAlpha:1.0F];
    }completion:^(BOOL finished) {
        
    }];
    return PickerView;
    
}
-(void)HidePickerView{
    if(PickerView != nil){
        [PickerView removeFromSuperview];
        PickerView = nil;
    }
}
-(void)RegisterCurrentView: (UIViewController *) view{
    _CurrentView = view;
    _Navigation.bar.view.backgroundColor = _NavBarBackgroundColor;
}
-(void)RegisterMainView:(MainController *)view{
    _Main = view;
}
-(void)CallBackForInvalidToken{
    UIViewController *vw = [_StoryBoard instantiateViewControllerWithIdentifier:@"idLoginViewController"];
    [vw setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [_CurrentView presentViewController:vw animated:YES completion:nil];
    [self performSelector:@selector(ShowTokenAlert) withObject:nil afterDelay:1];
}
-(void)ShowTokenAlert{
    [self ShowAlertWithTitle:@"Erro" AndText:@"Sua sessão expirou! Faça o login novamente."];
}
-(BOOL)hasConnection{
    
    reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    __block BOOL con;
    
    reach.reachableBlock = ^(Reachability *reachability)
    {
        con = YES;
    };
    
    reach.unreachableBlock = ^(Reachability *reachability)
    {
        con = NO;
    };
    
    [reach startNotifier];
    
    return con;
}

-(void)DoActionForJsonResponse:(NSDictionary *)json AllowDialog:(BOOL) dialog{
    NSString *acao = [NSString stringWithFormat:@"%@",[json objectForKey:@"acao"]];
    NSString *msg= [NSString stringWithFormat:@"%@",[json objectForKey:@"msg"]];
    if([msg length] > 0){
        if(dialog){
            [self ShowAlertWithTitle:@"Erro" AndText:msg];
        }else{
            NSLog(@"%@",msg);
        }
    }
    
    if([acao isEqual:@"2"]){
        [_Navigation popViewControllerAnimated:YES];
    }else if([acao isEqual:@"3"]){
        [_Navigation popToRootViewControllerAnimated:YES];
    }
}
-(void)DoActionForDataErrorResponse{
    [self ShowAlertWithTitle:@"Erro" AndText:@"Houve um erro no recebimento de dados!"];
}
-(void)doActionforError:(NSError *)error
{
    if (error.code == -1009)
    {
        [self ShowAlertWithTitle:@"Erro" AndText:@"Erro ao conectar"];
    }
    else if (error.code == -1003)
    {
        [self ShowAlertWithTitle:@"Erro" AndText:@"Servidor não encontrado"];
    }else{
        
        [self ShowAlertWithTitle:@"Erro" AndText:@"Erro ao conectar"];
    }
    
}
-(void)OpenMenu{
    if(Menu == nil){
        Menu = [[MenuBarController alloc] init];
    }
    
    [_CurrentView.view addSubview:Menu];

    Menu.frame = CGRectMake(0, 0, _CurrentView.view.frame.size.width, _CurrentView.view.frame.size.height - 70);
    Menu.view.frame = CGRectMake(0, 0, _CurrentView.view.frame.size.width, _CurrentView.view.frame.size.height - 70);
    Menu.center = CGPointMake(_CurrentView.view.frame.size.width/2, (_CurrentView.view.frame.size.height/2) + 35);
    
    [Menu setUpMenuWithFrame];
    
}
-(void)SetSection:(NSString *) section{
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"sessao_id" forKey:NSHTTPCookieName];
    [cookieProperties setObject:section forKey:NSHTTPCookieValue];
    [cookieProperties setObject:_Domain forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:_Domain forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:60 * 60 * 24] forKey:NSHTTPCookieExpires];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}
-(void)CloseMenu{
    [Menu hideMenu];
}
-(UIView *)presetNavBarConfig: (UIViewController *) controller{
    controller.automaticallyAdjustsScrollViewInsets = NO;
    [[controller navigationController] setNavigationBarHidden:NO animated:YES];
    controller.navigationItem.leftBarButtonItem=nil;
    controller.navigationItem.hidesBackButton=YES;
    UIView * StatusBar = [[UIView alloc] init];
    StatusBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    StatusBar.backgroundColor = [UIColor colorWithRed:0.00 green:0.35 blue:0.45 alpha:1.0];
    [controller.view addSubview:StatusBar];
    [controller.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    controller.navigationController.navigationBar.shadowImage = [UIImage new];
    controller.navigationController.navigationBar.translucent = YES;
    controller.navigationController.view.backgroundColor = [UIColor clearColor];
    controller.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    return StatusBar;
}

-(void)noResponseError{
    [self ShowAlertWithTitle:@"Erro" AndText:@"O aplicativo não obteve resposta do servidor"];
}
+(void)showNotificationWithTitle:(NSString *) title andMessage:(NSString *) message{
    
    ISMessages *alert = [ISMessages cardAlertWithTitle:title message:message iconImage:[UIImage imageNamed:@"brand-icon.png"] duration:3.f hideOnSwipe:YES hideOnTap:YES alertType:ISAlertTypeSuccess alertPosition:ISAlertPositionTop];
    
    
    alert.alertViewBackgroundColor = [UIColor blackColor];
    
    [alert show:nil didHide:nil];
}
+(void)showAlertNotificationWithTitle:(NSString *) title andMessage:(NSString *) message whenSucess:(BOOL)sucess{
    if(sucess){
        [ISMessages showCardAlertWithTitle:title message:message duration:3.f hideOnSwipe:YES hideOnTap:YES alertType:ISAlertTypeSuccess alertPosition:@(0).integerValue didHide:nil];
    }else{
        [ISMessages showCardAlertWithTitle:title message:message duration:3.f hideOnSwipe:YES hideOnTap:YES alertType:ISAlertTypeError alertPosition:@(0).integerValue didHide:nil];
    }
}
+ (CALayer *)addBorderToEdge:(UIRectEdge)edge withColor:(UIColor *)color withDimension:(CGFloat) dimension adThickness:(CGFloat)thickness toView:(UIView *) view
{
    CALayer *border = [CALayer layer];
    
    switch (edge) {
        case UIRectEdgeTop:
            border.frame = CGRectMake(0, 0, dimension, thickness);
            break;
        case UIRectEdgeBottom:
            border.frame = CGRectMake(0, CGRectGetHeight(view.frame) - thickness, dimension, thickness);
            break;
        case UIRectEdgeLeft:
            border.frame = CGRectMake(0, 0, thickness, dimension);
            break;
        case UIRectEdgeRight:
            border.frame = CGRectMake(CGRectGetWidth(view.frame) - thickness, 0, thickness, dimension);
            break;
        default:
            break;
    }
    
    border.backgroundColor = color.CGColor;
    
    [view.layer addSublayer:border];
    
    return border;
}
+ (NSData *)datafromImage:(UIImage *)image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if ([self hasAlpha:image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 1.0);
        mimeType = @"image/jpeg";
    }
    
    return imageData;
}
+ (BOOL)hasAlpha:(UIImage *)image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}
+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)ShowAlertWithTitle: (NSString *)title AndText: (NSString *) text{
    text = [text stringByReplacingOccurrencesOfString:@"|" withString:@"\n"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end
