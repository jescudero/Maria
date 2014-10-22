//
//  RepetirPlantaViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/22/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "RepetirPlantaViewController.h"

@interface RepetirPlantaViewController ()
@property (weak, nonatomic) IBOutlet UIButton *repetirButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *nroPlantasText;
@property (weak, nonatomic) IBOutlet UIStepper *plantasSteper;

@end

@implementation RepetirPlantaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nroPlantasText.text = @"1";
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

- (IBAction)RepetirPlantaViewController:(id)sender {
    
    NSInteger num = self.nroPlantasText.text.integerValue;
    
    [self.delegate repetirPlanta:num];
}

- (IBAction)cancelarTapped:(id)sender {

    [self.delegate repetirPlanta:1];
}

- (IBAction)plantasStepperTapped:(UIStepper*)sender {
    
    double value = [sender value];

    self.nroPlantasText.text = [NSString stringWithFormat:@"%d", (int)value];
    
}

@end
