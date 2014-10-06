//
//  ArmarioViewController.m
//  Maria
//
//  Created by Juan Escudero on 9/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "ArmarioViewController.h"
#import "HorasLuzSelectorViewController.h"
#import "SelectorViewController.h"
#import "Luces.h"
#import "Armario.h"
#import "PeriodoLuz.h"
#import "Cultivo.h"
#import "PlantaViewController.h"
#import "PlantasTableViewController.h"

@interface ArmarioViewController ()<HorasSelectorDelegate, SelectorProtocol, PlantaViewControllerDelegate>

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

@property (nonatomic, strong) SelectorViewController *tipoLuzVC;

@property (nonatomic, strong) PlantasTableViewController *plantasListVC;

@property (nonatomic, strong) UIView *overlayView;

@property (nonatomic, strong) Luces *luz;
@property (nonatomic, strong) PeriodoLuz *periodo;
@property (nonatomic, strong) NSMutableArray *plantas;


@end

@implementation ArmarioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.anchoText.text = [NSString stringWithFormat:@"%0.0f", self.anchoStepper.value];
    self.largoText.text = [NSString stringWithFormat:@"%0.0f", self.largoStepper.value];
    self.altoText.text = [NSString stringWithFormat:@"%0.0f", self.altoStepper.value];
    self.iluminacionTextLabel.text = @"-";
    self.fotoPeriodoTextLabel.text = @"-";
    self.plantas = [NSMutableArray array];
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

- (IBAction)selectTipoLuzTapped:(id)sender {
    
    self.overlayView = [[UIView alloc]initWithFrame:self.view.frame];
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayView.alpha = 0.5;
    [self.view addSubview:self.overlayView];
    
    self.tipoLuzVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TipoLuzVC"];
    self.tipoLuzVC.view.frame = CGRectMake(self.view.frame.size.width/2 - 220/2, 100, 220, 260);
    self.tipoLuzVC.delegate = self;
    self.tipoLuzVC.titleVC.text = @"Tipo de Luz";
    self.tipoLuzVC.property_first = @"tipo";
    self.tipoLuzVC.property_second = @"watts";
    self.tipoLuzVC.datasource = [Luces all];
    
    [self addChildViewController:self.tipoLuzVC];
    [self.view addSubview:self.tipoLuzVC.view];
    
}

-(void)cancelHorasSeleccion
{
    [self.overlayView removeFromSuperview];
    
    [self.horasLuzVC removeFromParentViewController];
    [self.horasLuzVC.view removeFromSuperview];
 }

-(void)selectionLuz:(NSInteger)luz oscuridad:(NSInteger)oscuridad{

    
    NSNumber * luzNum = [NSNumber numberWithInteger:luz];
    NSNumber * oscuridadNum = [NSNumber numberWithInteger:oscuridad];

    self.periodo = [PeriodoLuz create];
    self.periodo.horasLuz = [NSDecimalNumber decimalNumberWithDecimal:[luzNum decimalValue]];
    self.periodo.horasOscuridad = [NSDecimalNumber decimalNumberWithDecimal:[oscuridadNum decimalValue]];
    
    [self.overlayView removeFromSuperview];
    
    self.fotoPeriodoTextLabel.text = [NSString stringWithFormat:@"%d horas de luz / %d horas de oscuridad", luz, oscuridad];
    
    [self.horasLuzVC removeFromParentViewController];
    [self.horasLuzVC.view removeFromSuperview];
}

-(void)selectElement:(id)element{

    self.luz = (Luces*)element;
    
    [self.overlayView removeFromSuperview];
    
    self.iluminacionTextLabel.text = [NSString stringWithFormat:@"%@ - %@", self.luz.tipo, self.luz.watts];
    
    [self.tipoLuzVC removeFromParentViewController];
    [self.tipoLuzVC.view removeFromSuperview];
}

-(void)cancelSeleccion
{
    [self.overlayView removeFromSuperview];
    
    [self.tipoLuzVC removeFromParentViewController];
    [self.tipoLuzVC.view removeFromSuperview];
}

- (IBAction)grabarArmarioTapped:(id)sender {
    
    Armario *armario = [Armario create];
    armario.nombre = self.nombreText.text;
    armario.ancho = [NSDecimalNumber decimalNumberWithString:self.anchoText.text];
    armario.alto = [NSDecimalNumber decimalNumberWithString:self.altoText.text];
    armario.largo = [NSDecimalNumber decimalNumberWithString:self.largoText.text];
    armario.iluminacion = self.luz;
    armario.fotoPeriodo = self.periodo;
    
    [self.delegate armarioAgregado:armario];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)cancelarTapped:(id)sender{
    
    [self.delegate cancelAgregarArmario];
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)anchoStepper:(UIStepper*)sender {
    
    self.anchoText.text = [NSString stringWithFormat:@"%0.0f", sender.value];
}

- (IBAction)largoStepper:(UIStepper*)sender {
    
    self.largoText.text = [NSString stringWithFormat:@"%0.0f", sender.value];
}


- (IBAction)altoStepper:(UIStepper*)sender {
    
    self.altoText.text = [NSString stringWithFormat:@"%0.0f", sender.value];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    if ([segue.identifier isEqualToString:@"agregarPlantas"]) {
        ((PlantaViewController*)segue.destinationViewController).delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"plantasList"]) {
        self.plantasListVC = ((PlantasTableViewController*)segue.destinationViewController);
    }

}

-(void)plantaAgregada:(Planta*)planta{
    
    [self.plantas addObject:planta];
    self.plantasListVC.plantasList = self.plantas;
    [self.plantasListVC.tableView reloadData];

}

-(void)cancelAgregarPlanta{

}

@end
