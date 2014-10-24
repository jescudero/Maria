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

@interface EventoPlantaViewController ()<RiegoProtocol, FertilizanteProtocol, FechaSelectorProtocol>

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

@property (nonatomic, strong) UIView *overlayView;


@property (nonatomic, strong) EventoPlanta *eventoPlanta;
@property (nonatomic, strong) Fertilizante *fertilizante;
@property (nonatomic, strong) Riego *riego;


@end

@implementation EventoPlantaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Evento Planta";
    
    self.widthView.constant = self.view.frameWidth;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    
    self.fechaText.text =stringFromDate;
    self.alturaText.text = [NSString stringWithFormat:@"%@",self.planta.altura.stringValue];
    
    NSString *ciclo = self.planta.inicioCicloVida.nombre;

    self.eventoPlanta = nil;
    
    if (self.planta.eventos.count > 0)
    {
        NSArray *eventos = [self.planta.eventos allObjects];
        
        NSArray *sortArray = [eventos sortedArrayUsingComparator: ^(EventoPlanta *obj1, EventoPlanta *obj2) {
            return [obj1.fecha compare:obj2.fecha];
        }];
        
        ciclo = ((EventoPlanta*)sortArray[0]).cambioCicloVida.nombre;
        
        self.eventoPlanta = (EventoPlanta*)sortArray[0];
    }
    
    self.cicloVidaLabel.text = ciclo;
    
    
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
    [formatter setDateFormat:@"dd -MM-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:fecha];
    
    self.fechaText.text =stringFromDate;
    
}

- (IBAction)fertilizanteTapped:(id)sender {
    
    self.overlayView = [[UIView alloc]initWithFrame:self.view.frame];
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayView.alpha = 0.5;
    [self.view addSubview:self.overlayView];
    
    
    self.fertilizanteVC = [[UIStoryboard storyboardWithName:@"Logs" bundle:nil]instantiateViewControllerWithIdentifier:@"FertilizanteVC"];
    self.fertilizanteVC.delegate = self;
    self.fertilizanteVC.view.frame = CGRectMake(self.view.frameWidth/ 2 - 250/2, self.view.frameHeight/ 2 - 400/2, 250, 400);
    
    [self addChildViewController:self.fertilizanteVC];
    [self.view addSubview:self.fertilizanteVC.view];
    
}

-(void)fertilizanteGuardado:(Fertilizante *)fertilizante
{
    [self.overlayView removeFromSuperview];
    
    [self.riegoVC removeFromParentViewController];
    [self.riegoVC.view removeFromSuperview];
    
}

-(void)fertilizanteCancelado{

    [self.overlayView removeFromSuperview];
    
    [self.riegoVC removeFromParentViewController];
    [self.riegoVC.view removeFromSuperview];
}

- (IBAction)riegoTapped:(id)sender {
    
    self.overlayView = [[UIView alloc]initWithFrame:self.view.frame];
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayView.alpha = 0.5;
    [self.view addSubview:self.overlayView];
    
    
    self.riegoVC = [[UIStoryboard storyboardWithName:@"Logs" bundle:nil]instantiateViewControllerWithIdentifier:@"RiegoVC"];
    self.riegoVC.delegate = self;
    self.riegoVC.view.frame = CGRectMake(self.view.frameWidth/ 2 - 250/2, self.view.frameHeight/ 2 - 400/2, 250, 400);
    
    [self addChildViewController:self.riegoVC];
    [self.view addSubview:self.riegoVC.view];
}

-(void)riegoGrabado:(Riego *)riego
{
    [self.overlayView removeFromSuperview];
    
    [self.riegoVC removeFromParentViewController];
    [self.riegoVC.view removeFromSuperview];
}

-(void)riegoCancelado
{
    [self.overlayView removeFromSuperview];
    
    [self.riegoVC removeFromParentViewController];
    [self.riegoVC.view removeFromSuperview];
    
}

@end
