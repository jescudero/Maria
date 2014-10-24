//
//  RiegoViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/24/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "RiegoViewController.h"
#import "Riego.h"
#import <QuartzCore/QuartzCore.h>

@interface RiegoViewController ()<UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ecText;
@property (weak, nonatomic) IBOutlet UITextField *phText;
@property (weak, nonatomic) IBOutlet UITextField *temperaturaText;
@property (weak, nonatomic) IBOutlet UITextField *litrosText;
@property (weak, nonatomic) IBOutlet UITextView *notasText;

@end

@implementation RiegoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[self.notasText layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.notasText layer] setBorderWidth:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
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

- (IBAction)guardarTapped:(id)sender {
    
    Riego *riego = [Riego create];
    
    riego.ec = [NSDecimalNumber decimalNumberWithString:self.ecText.text];
    riego.litros = [NSDecimalNumber decimalNumberWithString:self.litrosText.text];
    riego.ph = [NSDecimalNumber decimalNumberWithString:self.phText.text];
    riego.temperatura = [NSDecimalNumber decimalNumberWithString:self.temperaturaText.text];
    riego.nota = self.notasText.text;
    
    [self.delegate riegoGrabado:riego];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return true;
}

- (IBAction)cancelarTapped:(id)sender {

    [self.delegate riegoCancelado];
}


-(void)keyboardWillShow:(NSNotification *)note {
    
    [self.delegate keybaoarShow:note];
    
}

-(void)keyboardWillHide:(NSNotification *)note  {

    [self.delegate keybaoarHide:note];
}

@end
