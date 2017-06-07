//
//  LoginController.h
//  Heey
//
//  Created by Karolina França on 03/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <CommonCrypto/CommonDigest.h>
#import "RemoteImageView.h"
@interface LoginController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *BottomLineViews;
@property (weak, nonatomic) IBOutlet UIView *StatusView;
@property (weak, nonatomic) IBOutlet UITextField *LoginField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordField;
@property (weak, nonatomic) IBOutlet UIButton *SubmitButton;
@property (weak, nonatomic) IBOutlet UIButton *RememberButton;
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Loader;
@property (weak, nonatomic) IBOutlet UIView *viewForm;

- (IBAction)Remember:(id)sender;
- (IBAction)Login:(id)sender;
- (IBAction)Register:(id)sender;
@end
