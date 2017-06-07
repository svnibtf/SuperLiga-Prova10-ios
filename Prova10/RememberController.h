//
//  RememberController.h
//  Heey
//
//  Created by Karolina França on 03/10/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RememberController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *TipField;
@property (weak, nonatomic) IBOutlet UITextField *LoginField;
@property (weak, nonatomic) IBOutlet UIView *LoginView;
@property (weak, nonatomic) IBOutlet UIView *TipView;
@property (weak, nonatomic) IBOutlet UIButton *SubmitButton;
@property (weak, nonatomic) IBOutlet UIButton *SubmitTip;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Loader;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *LoaderTip;
- (IBAction)Remember:(id)sender;
- (IBAction)RequestTip:(id)sender;
@end
