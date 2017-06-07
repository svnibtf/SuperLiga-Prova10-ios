//
//  NavigationBar.h
//  Heey
//
//  Created by Karolina França on 03/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationLabel.h"
@interface NavigationBar : UINavigationBar
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
- (IBAction)GoBack:(id)sender;
@end
