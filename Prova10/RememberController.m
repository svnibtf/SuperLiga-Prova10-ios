//
//  RememberController.m
//  Heey
//
//  Created by Karolina França on 03/10/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "RememberController.h"
#import "AppController.h"
@interface RememberController (){
    NSMutableData *dataResponse;
    NSURL *urlRemember;
    NSURL *urlRememberTip;
    BOOL initialized;
    CGRect frameRect;
}
@end

@implementation RememberController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AppController instance] presetNavBarConfig:self];
    
    [AppController addBorderToEdge:UIRectEdgeBottom withColor:[UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.0] withDimension:(self.view.frame.size.width - 48) adThickness:1.0f toView:_LoginView];
    
    [AppController addBorderToEdge:UIRectEdgeBottom withColor:[UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.0] withDimension:(self.view.frame.size.width - 48) adThickness:1.0f toView:_TipField];
    
    [_Loader setHidden:YES];
    [_LoaderTip setHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    _LoginField.delegate =self;
    _TipField.delegate = self;

    urlRemember = [NSURL URLWithString:[NSString stringWithFormat:@"%@/login-ems.php", [AppController instance].DomainLogin]];
    urlRememberTip = [NSURL URLWithString:[NSString stringWithFormat:@"%@/login-ems.php", [AppController instance].DomainLogin]];
    
    NSAttributedString *strLogin = [[NSAttributedString alloc] initWithString:@"E-mai" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    _LoginField.attributedPlaceholder = strLogin;
    
    NSAttributedString *strPass = [[NSAttributedString alloc] initWithString:@"Nome e Sobrenome" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    _TipField.attributedPlaceholder = strPass;
    
    initialized = false;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[AppController instance] RegisterCurrentView:self];
    [[AppController instance] setCurrentStoryBoardId:@"idRememberController"];
    [[AppController instance].Navigation SetTitleBar:@"Esqueci minha senha"];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    initialized = true;
    frameRect = self.view.frame;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
- (void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary* keyboardInfo = [aNotification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [keyboardFrameBegin CGRectValue];
    [UIView animateWithDuration:1.0f animations:^{
        [self.view setFrame:CGRectMake(0, 0, frameRect.size.width, (frameRect.size.height - keyboardFrame.size.height + 60))];
    }completion:^(BOOL finished) {
        
    }];
    
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:1.0f animations:^{
        [self.view setFrame:CGRectMake(0, 0, frameRect.size.width, frameRect.size.height)];
    }completion:^(BOOL finished) {
        
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)dismissKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(void)RequestTipForName: (NSString *) name{
    
    [_LoaderTip setHidden:NO];
    [_LoaderTip startAnimating];
    [_SubmitTip setHidden:YES];
    [_SubmitButton setUserInteractionEnabled:NO];
    
    NSMutableURLRequest *requisicao = [NSMutableURLRequest requestWithURL:urlRememberTip];
    
    [requisicao setHTTPMethod:@"POST"];
    
    NSString *parametros;
    parametros = [NSString stringWithFormat:@"dados=%@&tp_=dica", name];
    
    
    NSData *data = [parametros dataUsingEncoding:NSUTF8StringEncoding];
    
    [requisicao setHTTPBody:data];
    [requisicao setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection connectionWithRequest:requisicao delegate:self];
}
-(void)RememberPasswordWithUser: (NSString *) user{
    
    [_Loader setHidden:NO];
    [_Loader startAnimating];
    [_SubmitButton setHidden:YES];
    [_SubmitTip setUserInteractionEnabled:NO];
    
    NSMutableURLRequest *requisicao = [NSMutableURLRequest requestWithURL:urlRemember];
    
    [requisicao setHTTPMethod:@"POST"];
    
    NSString *parametros;
    parametros = [NSString stringWithFormat:@"dados=%@&tp_=email", user];
    
    
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
    [_LoaderTip setHidden:YES];
    [_SubmitTip setHidden:NO];
    [_SubmitTip setUserInteractionEnabled:YES];
    [_SubmitButton setUserInteractionEnabled:YES];
    
    if(connection.currentRequest.URL == urlRemember){
        if(dataResponse == nil){[[AppController instance] noResponseError]; return;}
        id json = [NSJSONSerialization JSONObjectWithData:dataResponse options:NSJSONReadingAllowFragments error:nil];
        
        
        if ([json isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dict = json;
            NSLog(@"%@", dict);
            NSString *response = [NSString stringWithFormat:@"%@",[dict objectForKey:@"ems"]];
            if([response isEqual:@"0"]){
                [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"Ocorreu um erro tente novamente" whenSucess:NO];
            }else if([response isEqual:@"1"]){
                [AppController showAlertNotificationWithTitle:@"Sucesso" andMessage:@"Lembrete enviado com sucesso" whenSucess:YES];
                _LoginField.text = @"";
                _TipField.text = @"";
                
            }else if([response isEqual:@"2"]){
                [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"E-mail nao cadastrado" whenSucess:NO];
                
            }else{
                [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"Erro ao conectar." whenSucess:NO];
            }
            
        }else{
            [[AppController instance] DoActionForDataErrorResponse];
            
        }
    }else if(connection.currentRequest.URL == urlRememberTip){
        if(dataResponse == nil){[[AppController instance] noResponseError]; return;}
        id json = [NSJSONSerialization JSONObjectWithData:dataResponse options:NSJSONReadingAllowFragments error:nil];
        
        
        if ([json isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dict = json;
            NSString *response = [NSString stringWithFormat:@"%@",[dict objectForKey:@"ems"]];
            NSString *email = [NSString stringWithFormat:@"%@",[dict objectForKey:@"email"]];
            if(email.length > 0){
                if([response isEqual:@"1"]){
                    [AppController showAlertNotificationWithTitle:@"Erro" andMessage:email whenSucess:YES];
                }else{
                    [AppController showAlertNotificationWithTitle:@"Erro" andMessage:email whenSucess:NO];
                }
            }else{
                [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"Não foi possivel encontrar um email relacionado aos dados apresentados." whenSucess:NO];
            }
            
        }else{
            [[AppController instance] DoActionForDataErrorResponse];
            
        }
    }
}

- (IBAction)Remember:(id)sender {
    if ([_LoginField.text length] != 0)
    {
        [self RememberPasswordWithUser:_LoginField.text];
        
    }else{
        [AppController showAlertNotificationWithTitle:@"Campos vazios" andMessage:@"Preencha os campos de e-mail!" whenSucess:NO];
    }
}

- (IBAction)RequestTip:(id)sender {
    if ([_TipField.text length] != 0)
    {
        [self RequestTipForName:_TipField.text];
        
    }else{
        [AppController showAlertNotificationWithTitle:@"Campos vazios" andMessage:@"Preencha o campo nome e sobrenome!" whenSucess:NO];
        
    }
}

@end
