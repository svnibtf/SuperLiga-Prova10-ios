//
//  AppController.h
//  Heey
//
//  Created by Karolina França on 03/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ISMessages/ISMessages.h>
#import "NavigationController.h"
#import "Reachability.h"
#import "MenuBarController.h"
#import "PickerViewPopUp.h"
#import "BackBar.h"
#import "MainController.h"
@interface AppController : NSObject
@property(nonatomic) NSString *Domain;
@property(nonatomic) NSString *DomainLogin;
@property(nonatomic) NSString *App;
@property(nonatomic) NSString *Version;
@property(nonatomic) NSString *MainUrl;
@property(nonatomic) NSString *AppStoreLink;
@property(nonatomic) UIViewController *CurrentView;
@property(nonatomic) UIColor* NavBarBackgroundColor;
@property(nonatomic) NavigationController *Navigation;
@property(nonatomic) MainController *Main;
@property(nonatomic) UIStoryboard *StoryBoard;
@property(nonatomic) NSString *CurrentStoryBoardId;
@property(nonatomic) NSString *_lastPass;
@property(nonatomic) NSString *_lastUser;
@property (nonatomic) UIImage *profilePhoto;

+ (AppController *)instance;
+ (CALayer *)addBorderToEdge:(UIRectEdge)edge withColor:(UIColor *)color withDimension:(CGFloat) dimension adThickness:(CGFloat)thickness toView:(UIView *) view;
+ (UIImage *)imageFromColor:(UIColor *)color;
+(void)showAlertNotificationWithTitle:(NSString *) title andMessage:(NSString *) message whenSucess:(BOOL)sucess;
+(void)showNotificationWithTitle:(NSString *) title andMessage:(NSString *) message;
+ (NSData *)datafromImage:(UIImage *)image;

-(void)ShowLoader:(BOOL) active;
-(void)ShowLoaderLight:(BOOL) active;
-(void)RegisterCurrentView:(UIViewController *) view;
-(void)RegisterMainView:(MainController *)view;
-(BOOL)hasConnection;
-(UIView *)presetNavBarConfig: (UIViewController *) controller;
-(void)OpenMenu;
-(void)CloseMenu;
-(void)OpenMain;
-(void)Logout;
-(void)SetSection:(NSString *) section;
-(void)ShowAlertWithTitle: (NSString *)title AndText: (NSString *) text;
-(void)DoActionForJsonResponse:(NSDictionary *)json AllowDialog:(BOOL) dialog;
-(void)DoActionForDataErrorResponse;
-(void)doActionforError:(NSError *)error;
-(PickerViewPopUp *)ShowPickerViewWithOptions:(NSArray * )options AndSelectIndex:(int) index;
-(void)HidePickerView;
-(void)noResponseError;
@end
