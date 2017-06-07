//
//  NavigationController.m
//  Heey
//
//  Created by Karolina França on 03/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "NavigationController.h"
#import "AppController.h"
@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bar.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
    _bar.center = CGPointMake(_bar.view.frame.size.width/2, _bar.view.frame.size.height/2);
    [[AppController instance] setNavigation:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SetTitleBar:(NSString *) title{
    _bar.TitleLabel.text = title;
}

@end
