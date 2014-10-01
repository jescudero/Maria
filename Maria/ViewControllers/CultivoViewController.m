//
//  CultivoViewController.m
//  Maria
//
//  Created by Juan Escudero on 9/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "CultivoViewController.h"
#import <CoreData/CoreData.h>
#import "Cultivo.h"
#import "CoreDataHelper.h"
#import "ArmarioViewController.h"

@interface CultivoViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nombreLabel;
@property (weak, nonatomic) IBOutlet UILabel *fechaLabel;
@property (weak, nonatomic) IBOutlet UILabel *armariosLabel;
@property (weak, nonatomic) IBOutlet UILabel *cantidadLabel;
@property (weak, nonatomic) IBOutlet UILabel *notasLabel;
@property (weak, nonatomic) IBOutlet UITextField *nombreText;
@property (weak, nonatomic) IBOutlet UITextField *fechaText;
@property (weak, nonatomic) IBOutlet UITextView *notasText;
@property (weak, nonatomic) IBOutlet UIButton *addArmarioButton;
@property (weak, nonatomic) IBOutlet UIButton *grabarCultivoArmario;

@property (nonatomic, strong) Cultivo *currentCulvio;

@end

@implementation CultivoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    
    self.fechaText.text =stringFromDate;
    
    self.notasText.text = NSLocalizedString(@"Agregue sus notas al cultivo", nil);
    self.notasText.textColor = [UIColor lightGrayColor];
    self.notasText.delegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
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

- (IBAction)addArmarioTapped:(id)sender {
    
}

- (IBAction)grabarCultivoTapped:(id)sender {
    
    [self saveCultivo];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self saveCultivo];
    
    if ([segue.identifier isEqualToString:@"agregarArmario"]) {
        ((ArmarioViewController*)segue.destinationViewController).currentCultivo = self.currentCulvio;
    }
}


-(void)saveCultivo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    
    NSManagedObjectContext *context = [[CoreDataHelper sharedInstance]managedObjectContext];
    
    // Create a new managed object
    self.currentCulvio = [NSEntityDescription insertNewObjectForEntityForName:@"Cultivo" inManagedObjectContext:context];
    self.currentCulvio.nombre = self.nombreText.text;
    self.currentCulvio.notas = self.notasText.text;
    self.currentCulvio.fechaInicio = dateFromString;
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

}

- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView
{
    aTextView.text = @"";
    
    return YES;
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
