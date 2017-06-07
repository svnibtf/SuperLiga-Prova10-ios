//
//  LoginController.m
//  Heey
//
//  Created by Karolina França on 03/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "LoginController.h"
#import "AppController.h"
@interface LoginController (){
    NSMutableData *dataResponse;
    NSURL *urlLogin;
    NSString *tokenData;
    NSUserDefaults *defaults;
    BOOL initialized;
    BOOL autoLogin;
}

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _StatusView.backgroundColor = [UIColor colorWithRed:0.00 green:0.35 blue:0.45 alpha:1.0];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSAttributedString *strLogin = [[NSAttributedString alloc] initWithString:@"Insira seu e-mail ou usuário" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    _LoginField.attributedPlaceholder = strLogin;
    
    NSAttributedString *strPass = [[NSAttributedString alloc] initWithString:@"Insira sua senha" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    _PasswordField.attributedPlaceholder = strPass;
    
    
    for(UIView *view in _BottomLineViews){
        [AppController addBorderToEdge:UIRectEdgeBottom withColor:[UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.0] withDimension:(self.view.frame.size.width - 48) adThickness:1.0f toView:view];
    }
    
    [_Loader setHidden:YES];
    
     defaults = [NSUserDefaults standardUserDefaults];
    
    urlLogin = [NSURL URLWithString:@"http://prova10.com.br/consulta-login-verifica-usuario.php"];
    
    initialized = false;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[AppController instance].Navigation SetTitleBar:@"Login"];
    [[AppController instance] RegisterCurrentView:self];
    [[AppController instance] setCurrentStoryBoardId:@"idLoginController"];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    if([AppController instance]._lastPass != nil && [AppController instance]._lastUser != nil){
        autoLogin = true;
        [self RequestLoginWithUser:[AppController instance]._lastUser AndPassword:[AppController instance]._lastPass];
        [_viewForm setHidden:YES];
        [[AppController instance] ShowLoaderLight:YES];
    }else{
        [_viewForm setHidden:NO];
        autoLogin = false;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    initialized = true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField == _LoginField){
        [_PasswordField becomeFirstResponder];
    }
    return YES;
}
-(void)dismissKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(void)RequestLoginWithUser: (NSString *) user AndPassword: (NSString *) password{
    
    [_Loader setHidden:NO];
    [_Loader startAnimating];
    [_SubmitButton setHidden:YES];
    
    NSMutableURLRequest *requisicao = [NSMutableURLRequest requestWithURL:urlLogin];
    
    [requisicao setHTTPMethod:@"POST"];
    
    tokenData = [defaults stringForKey:@"pushtoken"];
    
    NSString *parametros = [NSString stringWithFormat:@"email=%@&senha=%@", user, password];
    
    NSLog(@"ESSES SAO PARAMETROS %@", parametros);
    
    NSData *data = [parametros dataUsingEncoding:NSUTF8StringEncoding];
    
    [requisicao setHTTPBody:data];
    [requisicao setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:requisicao delegate:self];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    dataResponse = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dataResponse appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (error.code == -1009)
    {
        [[AppController instance] ShowAlertWithTitle:@"Erro" AndText:@"Erro ao conectar"];
    }
    else if (error.code == -1003)
    {
        [[AppController instance] ShowAlertWithTitle:@"Erro" AndText:@"Servidor não encontrado"];
    }else{
        
        [[AppController instance] ShowAlertWithTitle:@"Erro" AndText:@"Erro ao conectar"];
    }
    
    [_Loader setHidden:YES];
    [_SubmitButton setHidden:NO];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_Loader setHidden:YES];
    [_SubmitButton setHidden:NO];
    
    
    if(connection.currentRequest.URL == urlLogin){
        if(dataResponse == nil){[[AppController instance] noResponseError]; return;}
        id json = [NSJSONSerialization JSONObjectWithData:dataResponse options:NSJSONReadingAllowFragments error:nil];
        if ([json isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dict = json;
            NSString *response = [NSString stringWithFormat:@"%@",[dict objectForKey:@"login"]];
            NSLog(@"%@", dict);
            if([response  isEqual:@"1"]){
                NSString *session = [NSString stringWithFormat:@"%@",[dict objectForKey:@"session_id"]];
                [[AppController instance] SetSection:session];
                [[AppController instance] OpenMain];
                if(autoLogin == false){
                    [defaults setObject:_PasswordField.text forKey:@"lastpass"];
                    [defaults setObject:_LoginField.text forKey:@"lastuser"];
                }
                [defaults synchronize];
                _LoginField.text = @"";
                _PasswordField.text = @"";
            }else{
                autoLogin = false;
                [AppController instance]._lastPass = nil;
                [AppController instance]._lastUser = nil;
                if ([_viewForm isHidden]) {
                    _viewForm.alpha = 0;
                    [_viewForm setHidden:NO];
                    [UIView animateWithDuration:0.5f animations:^{
                        [_viewForm setAlpha:1];
                    }completion:^(BOOL finished) {
                    }];
                    [[AppController instance] ShowLoaderLight:NO];
                }
                if([response  isEqual:@"0"]){
                    [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"Erro na página" whenSucess:NO];
                }else if([response  isEqual:@"2"]){
                    [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"O e-mail fornecido esta incorreto" whenSucess:NO];
                }else if([response  isEqual:@"3"]){
                    [AppController showAlertNotificationWithTitle:@"Dados incorretos" andMessage:@"Senha incorreta" whenSucess:NO];
                }else if([response  isEqual:@"100"]){
                    [[AppController instance] ShowAlertWithTitle:@"Atualizar aplicativo!" AndText:@"Para logar é necessário atualizar seu aplicativo"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[AppController instance].AppStoreLink]];
                    
                }else if([response  isEqual:@"101"]){
                    [[NSURLCache sharedURLCache] removeAllCachedResponses];
                    [[AppController instance] OpenMain];
                    
                }else if([response  isEqual:@"102"]){
                    [[NSURLCache sharedURLCache] removeAllCachedResponses];
                    [[AppController instance] OpenMain];
                    
                }else{
                    [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"Erro ao conectar." whenSucess:NO];
                }
            }
                
            
            
        }else{
            [[AppController instance] DoActionForDataErrorResponse];
            
        }
    }
}

-(void)OpenMain{
    UIViewController *vw = [self.storyboard instantiateViewControllerWithIdentifier:@"idMainController"];
    [self.navigationController pushViewController:vw animated:YES];
}

- (IBAction)Remember:(id)sender {
    UIViewController *vw = [self.storyboard instantiateViewControllerWithIdentifier:@"idRememberController"];
    [self.navigationController pushViewController:vw animated:YES];
}

- (IBAction)Login:(id)sender {
    if ([_LoginField.text length] != 0 && [_PasswordField.text length] != 0)
    {
        
        [self RequestLoginWithUser:_LoginField.text AndPassword:_PasswordField.text];
        
    }else{
        [AppController showAlertNotificationWithTitle:@"Campos vazios" andMessage:@"Preencha os campos de usuário e senha!" whenSucess:NO];
        
    }
}

- (IBAction)Register:(id)sender {
    UIViewController *vw = [self.storyboard instantiateViewControllerWithIdentifier:@"idRegisterController"];
    [self.navigationController pushViewController:vw animated:YES];
}
@end
