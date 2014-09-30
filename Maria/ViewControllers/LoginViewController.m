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
    
    if (![Usuario loggedIn])
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

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)login:(id)sender {
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Usuario" inManagedObjectContext:context];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];

    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(email = %@) AND (password = %@)", self.emailText.text, self.passwordText.text];
    [request setPredicate:predicate];
    NSError *error;

    NSArray *array = [context executeFetchRequest:request error:&error];

 
    if (array.count > 0)
    {
        Usuario *usuario = array[0];
        [usuario saveDataToDefault];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Maria Grow" message:@"Usuario no encontrado" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
}
@end
