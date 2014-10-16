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
#import "PlantaViewController.h"
#import "PlantasTableViewController.h"
#import "ErrorViewController.h"

#import "Luces.h"
#import "Armario.h"
#import "PeriodoLuz.h"
#import "Cultivo.h"
#import "Planta.h"
#import "TipoPlanta.h"

@interface ArmarioViewController ()<HorasSelectorDelegate, SelectorProtocol, PlantaViewControllerDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nombreLabel;
@property (weak, nonatomic) IBOutlet UILabel *anchoLabel;
@property (weak, nonatomic) IBOutlet UILabel *largoLabel;
@property (weak, nonatomic) IBOutlet UILabel *altoLabel;
@property (weak, nonatomic) IBOutlet UILabel *horasLuz;
@property (weak, nonatomic) IBOutlet UILabel *horasOscuridad;
@property (weak, nonatomic) IBOutlet UILabel *fotoPeriodoLabel;
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
@property (weak, nonatomic) IBOutlet UITableView *plantasTable;

@property (nonatomic, strong) HorasLuzSelectorViewController *horasLuzVC;
@property (nonatomic, strong) SelectorViewController *tipoLuzVC;
@property (nonatomic, strong) PlantasTableViewController *plantasListVC;
@property (nonatomic, strong) ErrorViewController *errorView;

@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) Luces *luz;
@property (nonatomic, strong) PeriodoLuz *periodo;
@property (nonatomic, strong) NSMutableArray *plantas;

@end

@implementation ArmarioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Nuevo Armario";
    
    self.anchoText.text = [NSString stringWithFormat:@"%0.0f cm", self.anchoStepper.value];
    self.largoText.text = [NSString stringWithFormat:@"%0.0f cm", self.largoStepper.value];
    self.altoText.text = [NSString stringWithFormat:@"%0.0f cm", self.altoStepper.value];
    self.iluminacionTextLabel.text = @"-";
    self.horasLuz.text = @"horas luz: -";
    self.horasOscuridad.text = @"horas oscuridad: -";
    self.plantas = [NSMutableArray array];
    
    
    self.errorView = [[UIStoryboard storyboardWithName:@"Help" bundle:nil]instantiateViewControllerWithIdentifier:@"ErrorVC"];
    [self addChildViewController:self.errorView];

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
    self.horasLuzVC.view.frame = CGRectMake(self.view.frame.size.width/2 - 250/2, 100, 250, 260);
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
    self.tipoLuzVC.view.frame = CGRectMake(self.view.frameWidth/2 - 300/2, 100, 300, 300);
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
    
    self.horasLuz.text = [NSString stringWithFormat:@"%d horas de luz", luz];
    self.horasOscuridad.text = [NSString stringWithFormat:@"%d horas de oscuridad", oscuridad];

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
    
    [self grabaArmario];
    
}

-(void)grabaArmario
{
    
    if ([self validaCamposArmario])
    {
        if ([self validaIluminacion ])
        {
            Armario *armario = [Armario create];
            armario.nombre = self.nombreText.text;
            armario.ancho = [NSDecimalNumber decimalNumberWithString:self.anchoText.text];
            armario.alto = [NSDecimalNumber decimalNumberWithString:self.altoText.text];
            armario.largo = [NSDecimalNumber decimalNumberWithString:self.largoText.text];
            armario.iluminacion = self.luz;
            armario.fotoPeriodo = self.periodo;
            [armario addPlantas:[NSSet setWithArray:self.plantas]];
            
            [self.delegate armarioAgregado:armario];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }

}

-(BOOL)validaCamposArmario
{
    BOOL result = YES;
    
    if (![self validarText:self.nombreText])
    {
        self.errorView.text = @"Hay campos que son obligatorios.";
        self.errorView.backColor = [UIColor redColor];
        [self.errorView showInView:self.view];
        
        result = NO;
    }
    
    return result;
}


-(BOOL)validaIluminacion
{
    BOOL result = YES;
    
    if (!self.luz && !self.periodo)
    {
        self.errorView.text = @"Seleccione Foto-Periodo y Tipo de Iluminacion.";
        self.errorView.backColor = [UIColor redColor];
        [self.errorView showInView:self.view];
        
        result = NO;
    }
    
    return result;
}

-(BOOL)validaArmario:(Armario*)armario
{
    BOOL result = YES;
    
    if (!armario.plantas.count == 0)
    {
        self.errorView.text = @"Debe agrear al menos una planta.";
        self.errorView.backColor = [UIColor redColor];
        [self.errorView showInView:self.view];
        
        result = NO;
    }
    
    return result;
}

- (IBAction)cancelarTapped:(id)sender{
    
    [self.delegate cancelAgregarArmario];
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)anchoStepper:(UIStepper*)sender {
    
    self.anchoText.text = [NSString stringWithFormat:@"%0.0f cm", sender.value];
}

- (IBAction)largoStepper:(UIStepper*)sender {
    
    self.largoText.text = [NSString stringWithFormat:@"%0.0f cm", sender.value];
}


- (IBAction)altoStepper:(UIStepper*)sender {
    
    self.altoText.text = [NSString stringWithFormat:@"%0.0f cm", sender.value];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    if ([segue.identifier isEqualToString:@"agregarPlantas"]) {
        ((PlantaViewController*)segue.destinationViewController).delegate = self;
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return true;
}

-(void)plantaAgregada:(Planta*)planta{
    
    [self.plantas addObject:planta];
    self.plantasListVC.plantasList = self.plantas;
    [self.plantasTable reloadData];

}

-(void)cancelAgregarPlanta{

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.plantas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plantasCell" forIndexPath:indexPath];
    
    Planta *planta = self.plantas[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", planta.tipoPlanta.tipoPlanta, planta.genetica];
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:15];

    return cell;
}


@end
