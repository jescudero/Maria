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

@interface NewUserViewController ()

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

@property (nonatomic, strong) ErrorViewController *errorView;

@end

@implementation NewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    self.errorView = [[UIStoryboard storyboardWithName:@"Help" bundle:nil]instantiateViewControllerWithIdentifier:@"ErrorVC"];
    [self addChildViewController:self.errorView];

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
    
    Usuario *usuario = [Usuario create];
    usuario.nombre = self.nombreText.text;
    usuario.apellido = self.apellidoText.text;
    usuario.nickName = self.nickText.text;
    usuario.email = self.emailText.text;
    usuario.password = self.passText.text;

    if ([self validarUsuario:usuario])
    {
        [usuario save];
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}

-(BOOL)validarUsuario:(Usuario*)usuario
{
    BOOL result = [self validarText:self.nombreText] || [self validarText:self.apellidoText]|| [self validarText:self.nickText];
    
    if (!result)
    {
        
        self.errorView.text = @"Hubo un error, por favor valide los fields";
        self.errorView.backColor = [UIColor orangeColor];
        [self.errorView showInView:self.view];
    }
    
    return result;
    
}


-(BOOL)validarText:(UITextField*)field
{
    if ([field.text isEqualToString:@""])
    {
        field.layer.borderColor=[[UIColor redColor]CGColor];
        field.layer.borderWidth= 1.0f;
        return false;
    }
    
    return true;
        
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return true;
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    [UIView animateWithDuration:0.3f animations:^ {
        self.view.frame = CGRectMake(0, -120, 320, self.view.frame.size.height);
    }];
}

-(void)keyboardWillHide {
    // Animate the current view back to its original position
    [UIView animateWithDuration:0.3f animations:^ {
        self.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }];
}

@end
