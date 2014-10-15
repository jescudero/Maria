//
//  LoginViewController.m
//  Maria
//
//  Created by Juan Escudero on 9/26/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "LoginViewController.h"
#import <CoreData/CoreData.h>
#import "Usuario.h"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MariaCultivo's";
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    if ([Usuario isLoggedIn])
        [self performSegueWithIdentifier:@"login" sender:self];
    
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

- (IBAction)login:(id)sender {
    
 
    Usuario *usuario = [Usuario find:@"(email = %@) AND (password = %@)", self.emailText.text, self.passwordText.text];
    
    if (usuario)
    {
        [Usuario login];
        [usuario saveDataToDefault];
        
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Maria Grow" message:@"Usuario no encontrado" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
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
