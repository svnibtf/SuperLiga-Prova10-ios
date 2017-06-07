//
//  MenuController.h
//  Heey
//
//  Created by Karolina França on 03/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppController.h"
#import "loadAsyncData.h"
#import "RemoteImageView.h"
@interface MenuBarController : UIView<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIView *ContentView;
@property (weak, nonatomic) IBOutlet UIView *MenuView;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *BottomLineBorder;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ContrainWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ContrainWidthMenu;

-(void)setUpMenuWithFrame;
-(void)hideMenu;

- (IBAction)Actions:(id)sender;
- (IBAction)Logout:(id)sender;



@end
