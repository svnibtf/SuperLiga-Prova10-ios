//
//  RegisterController.m
//  Heey
//
//  Created by Karolina França on 04/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "RegisterController.h"
#import "AppController.h"
@interface RegisterController (){
    NSMutableData *dataResponse;
    NSURL *urlRequest;
    BOOL initialized;
    CGRect frameRect;
}
@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AppController instance] presetNavBarConfig:self];
    
    
    NSAttributedString *strName = [[NSAttributedString alloc] initWithString:@"Nome" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    _NameField.attributedPlaceholder = strName;
    _NameField.delegate = self;
    
    NSAttributedString *strNickName = [[NSAttributedString alloc] initWithString:@"Sobrenome" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    _NickNameField.attributedPlaceholder = strNickName;
    _NickNameField.delegate = self;
    
    NSAttributedString *strUser = [[NSAttributedString alloc] initWithString:@"Nome de Usuário" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    _ConfirmEmailField.attributedPlaceholder = strUser;
    _ConfirmEmailField.delegate = self;
    
    NSAttributedString *strPass = [[NSAttributedString alloc] initWithString:@"Senha" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    _PasswordField.attributedPlaceholder = strPass;
    _PasswordField.delegate = self;
    
    NSAttributedString *strConfirmPass = [[NSAttributedString alloc] initWithString:@"Confirmar Senha" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    _ConfirmPasswordField.attributedPlaceholder = strConfirmPass;
    _ConfirmPasswordField.delegate = self;
    
    NSAttributedString *strEmail = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    _EmailField.attributedPlaceholder = strEmail;
    _EmailField.delegate = self;
    
    NSAttributedString *strConfirmEmail = [[NSAttributedString alloc] initWithString:@"Confirmar e-mail" attributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }];
    _ConfirmEmailField.attributedPlaceholder = strConfirmEmail;
    _ConfirmEmailField.delegate = self;
    
    for(UIView *view in _BottomLineViews){
        [AppController addBorderToEdge:UIRectEdgeBottom withColor:[UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.0] withDimension:(self.view.frame.size.width - 48) adThickness:1.0f toView:view];
    }
    
    [_Loader setHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [_ScrollView addGestureRecognizer:tap];
    
    
    urlRequest = [NSURL URLWithString:[NSString stringWithFormat:@"%@/consulta-adm-cadastro.php", [AppController instance].Domain]];
 
    
    
    initialized = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[AppController instance] RegisterCurrentView:self];
    [[AppController instance] setCurrentStoryBoardId:@"idRegisterController"];
    [[AppController instance].Navigation SetTitleBar:@"Meu Cadastro"];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    frameRect = self.view.frame;
    initialized = true;
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
    if(textField == _NameField){
        [_NickNameField becomeFirstResponder];
    }else if(textField == _NickNameField){
        [_EmailField becomeFirstResponder];
    }else if(textField == _EmailField){
        [_ConfirmEmailField becomeFirstResponder];
    }else if(textField == _ConfirmEmailField){
        [_PasswordField becomeFirstResponder];
    }else if(textField == _PasswordField){
        [_ConfirmPasswordField becomeFirstResponder];
    }else{
       [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {

}
-(void)dismissKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)requestData{
    
    [_Loader setHidden:NO];
    [_Loader startAnimating];
    [_SubmitButton setHidden:YES];
    
    NSMutableURLRequest *requisicao = [NSMutableURLRequest requestWithURL:urlRequest];
    
    [requisicao setHTTPMethod:@"POST"];
    
    NSString *parametros;
    parametros = [NSString stringWithFormat:@"nome=%@&sbnome=%@&email=%@&senha=%@&origem_cadastro=prova10", _NameField.text,_NickNameField.text, _EmailField.text, _PasswordField.text];
    
    
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
    
    
    if(connection.currentRequest.URL == urlRequest){
        if(dataResponse == nil){[[AppController instance] noResponseError]; return;}
        id json = [NSJSONSerialization JSONObjectWithData:dataResponse options:NSJSONReadingAllowFragments error:nil];
        
        
        
        if ([json isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dict = json;
            NSString *response = [NSString stringWithFormat:@"%@",[dict objectForKey:@"retorno_app"]];
            
            NSLog(@"%@", dict);
            if([response isEqual:@"sucesso"]){
                [AppController showAlertNotificationWithTitle:@"Sucesso" andMessage:@"Cadastro realizado com sucesso" whenSucess:YES];
                for(UITextField *field in _RequiredFields){
                    field.text = @"";
                }
                
            }else if([response isEqual:@"erro_email_cadastrado"]){
                [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"Esse e-mail já possui cadastro" whenSucess:NO];
                
            }else if([response isEqual:@"erro"]){
                [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"Ocorreu um erro inesperado" whenSucess:NO];
                
                
            }else{
                [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"Erro ao conectar." whenSucess:NO];
            }
            
        }else{
            [[AppController instance] DoActionForDataErrorResponse];
            
        }
    }
}

-(BOOL)checkRequiredFields{
    for(UITextField *field in _RequiredFields){
        if(field.text.length == 0){
            return NO;
        }
    }
    
    return YES;
}
- (IBAction)Register:(id)sender {
    if([self checkRequiredFields] == YES){
        if(![_EmailField.text isEqualToString:_ConfirmEmailField.text]){
          [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"Seu e-mail não é o mesmo de confirmação!" whenSucess:NO];
        }else if(![_PasswordField.text isEqualToString:_ConfirmPasswordField.text]){
            [AppController showAlertNotificationWithTitle:@"Erro" andMessage:@"Sua senha não é a mesma de confirmação!" whenSucess:NO];
        }else{
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            [self requestData];
        }
        

    }else{
        [AppController showAlertNotificationWithTitle:@"Campos obrigatórios" andMessage:@"Todos os campos são obrigatórios!" whenSucess:NO];
    }
}
@end
