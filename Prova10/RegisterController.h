//
//  RegisterController.h
//  Heey
//
//  Created by Karolina França on 04/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabelHtml.h"
@interface RegisterController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *BottomLineViews;
@property (weak, nonatomic) IBOutlet UITextField *NameField;
@property (weak, nonatomic) IBOutlet UITextField *NickNameField;
@property (weak, nonatomic) IBOutlet UITextField *EmailField;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmEmailField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordField;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPasswordField;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *RequiredFields;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Loader;
@property (weak, nonatomic) IBOutlet UIButton *SubmitButton;

- (IBAction)Register:(id)sender;
@end
