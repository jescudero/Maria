//
//  HorasLuzSelectorViewController.m
//  Maria
//
//  Created by Juan Escudero on 9/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "HorasLuzSelectorViewController.h"

@interface HorasLuzSelectorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *horasLuzLabel;
@property (weak, nonatomic) IBOutlet UILabel *horasOscuridadLabel;
@property (weak, nonatomic) IBOutlet UITextField *horasLuzText;
@property (weak, nonatomic) IBOutlet UITextField *horasOscuridadText;
@property (weak, nonatomic) IBOutlet UIStepper *horasLuzStepper;
@property (weak, nonatomic) IBOutlet UIStepper *horasOscuridadStepper;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic) NSInteger horasLuz;
@property (nonatomic) NSInteger horasOscuridad;

@end

@implementation HorasLuzSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.horasLuz = 12.0;
    self.horasOscuridad = 12.0;
    
    self.horasLuzStepper.value = self.horasLuz;
    self.horasOscuridadStepper.value = self.horasOscuridad;
    
    self.horasLuzText.text = [NSString stringWithFormat:@"%d", (int)self.horasLuz];
    self.horasOscuridadText.text = [NSString stringWithFormat:@"%d", (int)self.horasOscuridad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)horaLuzStepperTap:(UIStepper*)sender {
    
    if (self.horasLuz > 0 || self.horasLuz < 24)
    {
        self.horasLuz = [sender value];
        self.horasOscuridad = 24 - self.horasLuz;
        self.horasLuzText.text = [NSString stringWithFormat:@"%d", (int)self.horasLuz];
        self.horasOscuridadText.text = [NSString stringWithFormat:@"%d", (int)self.horasOscuridad];
    }
    
    
}
- (IBAction)horasOscuridadStepperTap:(UIStepper*)sender {
    
    if (self.horasOscuridad > 0 || self.horasLuz < 24)
    {
        self.horasOscuridad = [sender value];
        self.horasLuz = 24 - self.horasOscuridad;
        self.horasLuzText.text = [NSString stringWithFormat:@"%d", (int)self.horasLuz];
        self.horasOscuridadText.text = [NSString stringWithFormat:@"%d", (int)self.horasOscuridad];
    }
}

- (IBAction)selectButtonTapped:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectionLuz:oscuridad:)])
        [self.delegate selectionLuz:self.horasLuz oscuridad:self.horasOscuridad];
    
}
- (IBAction)canceButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cancelHorasSeleccion)])
        [self.delegate cancelHorasSeleccion];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
