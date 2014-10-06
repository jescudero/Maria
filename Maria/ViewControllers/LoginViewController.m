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
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
@end
