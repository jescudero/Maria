//
//  EventoPlantaViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/23/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "EventoPlantaViewController.h"
#import "Planta.h"
#import "EventoPlanta.h"
#import "CicloVida.h"
#import "Fertilizante.h"
#import "Riego.h"

#import "RiegoViewController.h"
#import "FertilizanteViewController.h"
#import "FechaSelectorViewController.h"
#import "SelectorViewController.h"

@interface EventoPlantaViewController ()<RiegoProtocol, FertilizanteProtocol, FechaSelectorProtocol, SelectorProtocol>

@property (weak, nonatomic) IBOutlet UITextField *fechaText;

@property (weak, nonatomic) IBOutlet UIButton *calendarioButton;
@property (weak, nonatomic) IBOutlet UILabel *cicloVidaLabel;
@property (weak, nonatomic) IBOutlet UITextField *alturaText;
@property (weak, nonatomic) IBOutlet UIButton *cicloVidaButton;
@property (weak, nonatomic) IBOutlet UIButton *riegoButton;
@property (weak, nonatomic) IBOutlet UILabel *riegoLabel;
@property (weak, nonatomic) IBOutlet UIButton *fertilizanteButton;
@property (weak, nonatomic) IBOutlet UILabel *fertilizanteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *foto1;
@property (weak, nonatomic) IBOutlet UIImageView *foto2;
@property (weak, nonatomic) IBOutlet UIButton *cancelarButton;
@property (weak, nonatomic) IBOutlet UIButton *cambiarButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthView;


@property (nonatomic, strong) RiegoViewController *riegoVC;
@property (nonatomic, strong) FertilizanteViewController *fertilizanteVC;
@property (nonatomic, strong) FechaSelectorViewController *fechaVC;
@property (nonatomic, strong) SelectorViewController *selector;

@property (nonatomic, strong) UIView *overlayView;


@property (nonatomic, strong) Fertilizante *fertilizante;
@property (nonatomic, strong) Riego *riego;
@property (nonatomic, strong) CicloVida *ciclo;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation EventoPlantaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Evento Planta";
    
    self.widthView.constant = self.view.frameWidth;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    
    self.fechaText.text =stringFromDate;
    
    if (self.planta)
    {
        if (self.planta.altura)
            self.alturaText.text = [NSString stringWithFormat:@"%@",self.planta.altura.stringValue];
        else
            self.alturaText.text = @"-";
        
        NSString *ciclo = self.planta.inicioCicloVida.nombre;
        
        if (self.planta.eventos.count > 0)
        {
            NSArray *eventos = [self.planta.eventos allObjects];
            
            NSArray *sortArray = [eventos sortedArrayUsingComparator: ^(EventoPlanta *obj1, EventoPlanta *obj2) {
                return [obj1.fecha compare:obj2.fecha];
            }];
            
            ciclo = ((EventoPlanta*)sortArray[0]).cambioCicloVida.nombre;
            
        }
        
        self.cicloVidaLabel.text = ciclo;
        
    }
    
    // Do any additional setup after loading the view.
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
- (IBAction)cicloVidaTapped:(id)sender {
    
    self.overlayView = [[UIView alloc]initWithFrame:self.view.frame];
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayView.alpha = 0.5;
    [self.view addSubview:self.overlayView];
    
    self.selector = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TipoLuzVC"];
    self.selector.view.frame = CGRectMake(self.view.frame.size.width/2 - 300/2, 100, 300, 260);
    self.selector.delegate = self;
    self.selector.titleVC.text = @"Ciclo de Vida";
    self.selector.property_first = @"nombre";
    self.selector.datasource = [CicloVida all];
    
    [self addChildViewController:self.selector];
    [self.view addSubview:self.selector.view];
}

-(void)cancelSeleccion{
    
    [self.overlayView removeFromSuperview];
    
    [self.selector removeFromParentViewController];
    [self.selector.view removeFromSuperview];
}


-(void)selectElement:(id)element{
    
    self.ciclo = (CicloVida*)element;
    self.cicloVidaLabel.text = [NSString stringWithFormat:@"%@", self.ciclo.nombre];
    
    [self.overlayView removeFromSuperview];
    
    [self.selector removeFromParentViewController];
    [self.selector.view removeFromSuperview];
}

- (IBAction)calendarioTapped:(id)sender {
    
    [self showPicker];

}


-(void)showPicker
{
    self.fechaVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"fechaPicker"];
    self.fechaVC.delegate = self;
    
    [self addChildViewController:self.fechaVC];
    [self.view addSubview:self.fechaVC.view];
    
    self.fechaVC.view.frameX = 0;
    self.fechaVC.view.frameHeight = 260;
    self.fechaVC.view.frameY = self.view.frameHeight -  self.fechaVC.view.frameHeight;
}

-(void)cancelFecha{
    
    [self.fechaVC removeFromParentViewController];
    [self.fechaVC.view removeFromSuperview];
    
}

-(void)selectFecha:(NSDate*)fecha{
    
    [self.fechaVC removeFromParentViewController];
    [self.fechaVC.view removeFromSuperview];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:fecha];
    
    self.fechaText.text =stringFromDate;
    
}

- (IBAction)fertilizanteTapped:(id)sender {
    
    self.overlayView = [[UIView alloc]initWithFrame:self.containerView.frame];
    self.overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.containerView addSubview:self.overlayView];
    
    
    self.fertilizanteVC = [[UIStoryboard storyboardWithName:@"Logs" bundle:nil]instantiateViewControllerWithIdentifier:@"FertilizanteVC"];
    self.fertilizanteVC.delegate = self;
    self.fertilizanteVC.view.frame = CGRectMake(self.view.frameWidth/ 2 - 250/2, 50, 250, 400);
    self.fertilizanteVC.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    self.fertilizanteVC.view.alpha = 1.0;

    [self addChildViewController:self.fertilizanteVC];
    [self.overlayView addSubview:self.fertilizanteVC.view];
    
}

-(void)fertilizanteGuardado:(Fertilizante *)fertilizante
{
    
    NSString *nombre = [fertilizante.nombre isEqualToString:@""] ? @"Generico" : fertilizante.nombre;
    NSString *tipo = [fertilizante.tipo isEqualToString:@""] ? @"" : fertilizante.tipo;
    NSString *marca = [fertilizante.marca isEqualToString:@""] ? @"NN" : fertilizante.marca;
    
    self.fertilizanteLabel.text = [NSString stringWithFormat:@"%@, %@ (%@)", nombre, tipo, marca];
    
    self.fertilizante = fertilizante;
    
    [self.overlayView removeFromSuperview];
    
    [self.fertilizanteVC removeFromParentViewController];
    [self.fertilizanteVC.view removeFromSuperview];
    
}

-(void)fertilizanteCancelado{

    [self.overlayView removeFromSuperview];
    
    [self.fertilizanteVC removeFromParentViewController];
    [self.fertilizanteVC.view removeFromSuperview];
}

- (IBAction)riegoTapped:(id)sender {
    
    self.overlayView = [[UIView alloc]initWithFrame:self.containerView.frame];
    self.overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.containerView addSubview:self.overlayView];

    
    self.riegoVC = [[UIStoryboard storyboardWithName:@"Logs" bundle:nil]instantiateViewControllerWithIdentifier:@"RiegoVC"];
    self.riegoVC.delegate = self;
    self.riegoVC.view.frame = CGRectMake(self.view.frameWidth/ 2 - 250/2, 50, 250, 400);
    self.riegoVC.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    self.riegoVC.view.alpha = 1.0;
    


    [self addChildViewController:self.riegoVC];
    [self.overlayView addSubview:self.riegoVC.view];
    
    
}

-(void)riegoGrabado:(Riego *)riego
{
    
    self.riego = riego;
    
    NSString *litros = [riego.litros isEqualToNumber:[NSNumber numberWithInt:0]] ? @"Riego indeterminado" : riego.litros.stringValue;
    
    NSString *ec = [riego.ec isEqualToNumber:[NSNumber numberWithInt:0]] ? @"NN" : riego.ec.stringValue;

    NSString *ph = [riego.ph isEqualToNumber:[NSNumber numberWithInt:0]] ? @"NN" : riego.ph.stringValue;
    
    NSString *temperatura = [riego.temperatura isEqualToNumber:[NSNumber numberWithInt:0]] ? @"NN" : riego.temperatura.stringValue;

    if ([litros isEqualToString:@"Riego indeterminado"])
        self.riegoLabel.text = litros;
    else
        self.riegoLabel.text = [NSString stringWithFormat:@" %@ lts (ec: %@ - ph: %@ - temp: %@)", litros, ec, ph, temperatura];

    
    [self.overlayView removeFromSuperview];
    
    [self.riegoVC removeFromParentViewController];
    [self.riegoVC.view removeFromSuperview];
}

-(void)keybaoarShow:(NSNotification *)note{

    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
    
    self.heightConstraint.constant = self.heightConstraint.constant + keyboardBounds.size.height;
    
}

-(void)keybaoarHide:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
    
    self.heightConstraint.constant = self.heightConstraint.constant - keyboardBounds.size.height;
}

-(void)riegoCancelado
{
    [self.overlayView removeFromSuperview];
    
    [self.riegoVC removeFromParentViewController];
    [self.riegoVC.view removeFromSuperview];
    
}

- (IBAction)guardarEventoPlantaTapped:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd/MM/yyyy"];

    EventoPlanta *eventoPlanta = [EventoPlanta create];
    eventoPlanta.fecha = [formatter dateFromString:self.fechaText.text];
    eventoPlanta.fertilizante = self.fertilizante;
    eventoPlanta.cambioCicloVida = self.ciclo;
    eventoPlanta.cambioAltura = [NSDecimalNumber decimalNumberWithString:self.alturaText.text];
    eventoPlanta.riego = self.riego;
    eventoPlanta.planta = self.planta;
    
    
    [self.delegate eventoPlantaCreado:eventoPlanta];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)cancelarEventoPlantaTapped:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

@end
