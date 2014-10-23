//
//  NewUserViewController.m
//  Maria
//
//  Created by Juan Escudero on 9/26/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "NewUserViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ErrorViewController.h"
#import "Usuario.h"

@interface NewUserViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nombreLabel;
@property (weak, nonatomic) IBOutlet UILabel *apellidoLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *retypeLabel;
@property (weak, nonatomic) IBOutlet UITextField *nombreText;
@property (weak, nonatomic) IBOutlet UITextField *apellidoText;
@property (weak, nonatomic) IBOutlet UITextField *nickText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passText;
@property (weak, nonatomic) IBOutlet UITextField *retypePassText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;

@property (nonatomic, strong) ErrorViewController *errorView;


@property (nonatomic) CGFloat yPosition;

@end

@implementation NewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Nuevo Usuario";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    self.errorView = [[UIStoryboard storyboardWithName:@"Help" bundle:nil]instantiateViewControllerWithIdentifier:@"ErrorVC"];
    [self addChildViewController:self.errorView];
    
    self.widthView.constant = self.view.frameWidth;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)save:(id)sender {
    
    [sender resignFirstResponder];
    
    if ([self validarCamposUsuario])
    {
        if ([self validarPassword])
        {
            Usuario *usuario = [Usuario create];
            usuario.nombre = self.nombreText.text;
            usuario.apellido = self.apellidoText.text;
            usuario.nickName = self.nickText.text;
            usuario.email = self.emailText.text;
            usuario.password = self.passText.text;
            
            [usuario save];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

-(BOOL)validarCamposUsuario
{
    BOOL result = [self validarText:self.nombreText] & [self validarText:self.apellidoText] & [self validarText:self.nickText] & [self validarText:self.emailText] & [self validarText:self.passText] & [self validarText:self.retypePassText];
    
    if (!result)
    {
        self.errorView.text = @"Hay campos que son obligatorios.";
        self.errorView.backColor = [UIColor redColor];
        [self.errorView showInView:self.view];
    }

    return result;
    
}


-(BOOL)validarPassword
{
    BOOL result = YES;
    
    if (![self.passText.text isEqualToString:self.retypePassText.text])
    {
        self.errorView.text = @"El password debe ser igual";
        self.errorView.backColor = [UIColor redColor];
        [self.errorView showInView:self.view];
        result = NO;
    }
    
    return result;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
  //
    
    return true;
}

-(void)keyboardWillShow:(NSNotification *)note {
    
    
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
    
    self.bottomHeight.constant = self.bottomHeight.constant + keyboardBounds.size.height;
 
}

-(void)keyboardWillHide:(NSNotification *)note  {
    // Animate the current view back to its original position
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
    
    self.bottomHeight.constant = self.bottomHeight.constant - keyboardBounds.size.height;
}

@end
