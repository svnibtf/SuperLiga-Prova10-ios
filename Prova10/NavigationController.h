//
//  NavigationController.h
//  Heey
//
//  Created by Karolina França on 03/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationBar.h"


@interface NavigationController : UINavigationController
@property (weak, nonatomic) IBOutlet NavigationBar *bar;
-(void)SetTitleBar:(NSString *) title;
@end
