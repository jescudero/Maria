//
//  RiegoViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/24/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "RiegoViewController.h"
#import "Riego.h"

@interface RiegoViewController ()
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
    
    self.title = @"Riego";
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
- (IBAction)cancelarTapped:(id)sender {

    [self.delegate riegoCancelado];

}

@end
