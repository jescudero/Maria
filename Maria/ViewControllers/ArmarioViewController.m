//
//  ArmarioViewController.m
//  Maria
//
//  Created by Juan Escudero on 9/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "ArmarioViewController.h"
#import "HorasLuzSelectorViewController.h"

@interface ArmarioViewController ()<HorasSelectorDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nombreLabel;
@property (weak, nonatomic) IBOutlet UILabel *anchoLabel;
@property (weak, nonatomic) IBOutlet UILabel *largoLabel;
@property (weak, nonatomic) IBOutlet UILabel *altoLabel;
@property (weak, nonatomic) IBOutlet UILabel *fotoPeriodoLabel;
@property (weak, nonatomic) IBOutlet UILabel *fotoPeriodoTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *iluminacionLabel;
@property (weak, nonatomic) IBOutlet UILabel *iluminacionTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *plantasLabel;
@property (weak, nonatomic) IBOutlet UITextField *nombreText;
@property (weak, nonatomic) IBOutlet UITextField *anchoText;
@property (weak, nonatomic) IBOutlet UITextField *largoText;
@property (weak, nonatomic) IBOutlet UITextField *altoText;
@property (weak, nonatomic) IBOutlet UIButton *FotoPeriodoButton;
@property (weak, nonatomic) IBOutlet UIButton *iluminacionButton;
@property (weak, nonatomic) IBOutlet UIButton *addPlantaButton;
@property (weak, nonatomic) IBOutlet UIButton *grabarPlantaButton;
@property (weak, nonatomic) IBOutlet UIStepper *anchoStepper;
@property (weak, nonatomic) IBOutlet UIStepper *largoStepper;
@property (weak, nonatomic) IBOutlet UIStepper *altoStepper;

@property (nonatomic, strong) HorasLuzSelectorViewController *horasLuzVC;
@property (nonatomic, strong) UIView *overlayView;

@end

@implementation ArmarioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.anchoText.text = @"1.0";
    self.largoText.text = @"1.0";
    self.altoText.text = @"1.0";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectFotoPeriodoTapped:(id)sender {
    
    self.overlayView = [[UIView alloc]initWithFrame:self.view.frame];
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayView.alpha = 0.5;
    [self.view addSubview:self.overlayView];
    
    self.horasLuzVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"HorasLuzVC"];
    self.horasLuzVC.view.frame = CGRectMake(self.view.frame.size.width/2 - 220/2, 100, 220, 260);
    self.horasLuzVC.delegate = self;
    
    [self addChildViewController:self.horasLuzVC];
    [self.view addSubview:self.horasLuzVC.view];
    
}

-(void)cancelSeleccion
{
    [self.overlayView removeFromSuperview];
    
    [self.horasLuzVC removeFromParentViewController];
    [self.horasLuzVC.view removeFromSuperview];
}

-(void)selectionLuz:(NSInteger)luz oscuridad:(NSInteger)oscuridad{

    [self.overlayView removeFromSuperview];
    
    self.fotoPeriodoTextLabel.text = [NSString stringWithFormat:@"%ld horas de luz / %ld horas de oscuridad", luz, oscuridad];
    
    [self.horasLuzVC removeFromParentViewController];
    [self.horasLuzVC.view removeFromSuperview];
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
