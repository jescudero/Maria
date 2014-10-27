//
//  ArmarioLogViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/20/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "ArmarioLogViewController.h"
#import "Armario.h"
#import "PeriodoLuz.h"
#import "Luces.h"
#import "Planta.h"
#import "PlantasLogTableViewCell.h"
#import "EventoArmarioViewController.h"
#import "EventoPlantaViewController.h"
#import "EventoArmario.h"

@interface ArmarioLogViewController ()<UITableViewDataSource, UITableViewDelegate, EventoArmarioProtocol>

@property (weak, nonatomic) IBOutlet UILabel *armarioLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodoLuzLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodoOscuridadLabel;
@property (weak, nonatomic) IBOutlet UILabel *iluminacionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dimensionLAbel;
@property (weak, nonatomic) IBOutlet UITableView *plantasTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@property (weak, nonatomic) IBOutlet UIButton *cambiosArmarioButton;
@property (strong, nonatomic) EventoArmarioViewController *eventoArmarioVC;
@property (strong, nonatomic) EventoPlantaViewController *eventoPlantaVC;

@property (nonatomic, strong) UIView *overlayView;

@property (nonatomic, strong) EventoArmario *eventoArmario;
@property (nonatomic, strong) EventoPlanta *eventoPlanta;

@end

@implementation ArmarioLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Log Armario";
    
    
    self.widthConstraint.constant =self.view.frameWidth;
    
    self.armarioLabel.text = [NSString stringWithFormat:@"Armario: %@", self.armario.nombre];
    
    
    self.dimensionLAbel.text = [NSString stringWithFormat:@"(alto:%@, largo: %@, ancho: %@)", self.armario.alto, self.armario.largo, self.armario.ancho];
    
    self.periodoLuzLabel.text =  [NSString stringWithFormat:@"Periodo de Luz: %@", self.armario.fotoPeriodo.horasLuz];

    self.periodoOscuridadLabel.text = [NSString stringWithFormat:@"Periodo de Oscuridad: %@", self.armario.fotoPeriodo.horasOscuridad];
    
    
    self.iluminacionLabel.text = [NSString stringWithFormat:@"Tipo Iluminacion: %@ %@", self.armario.iluminacion.tipo, self.armario.iluminacion.watts];
    
    
    self.plantasTable.delegate = self;
    self.plantasTable.dataSource = self;
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.armario.plantas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlantasLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plantasLogCell" forIndexPath:indexPath];
    
    Planta *planta = [self.armario.plantas allObjects][indexPath.row];
    // Configure the cell...
    [cell configureCell:planta];
    
    return cell;
}

- (IBAction)cambiosArmarioTapped:(id)sender {
    
    if ([self.cambiosArmarioButton.titleLabel.text isEqualToString:@"Remover Cambios"])
    {
        self.eventoArmario = nil;
        
        [self.cambiosArmarioButton setTitleColor:[UIColor colorWithRed:79.0/255.0 green:236.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.cambiosArmarioButton setTitle:@"Cambios a armario" forState:UIControlStateNormal];
        
        [self.periodoLuzLabel setTextColor:[UIColor blackColor]];
        [self.periodoOscuridadLabel setTextColor:[UIColor blackColor]];
        [self.iluminacionLabel setTextColor:[UIColor blackColor]];
    }
    else
    {
        self.eventoArmarioVC = [[UIStoryboard storyboardWithName:@"Logs" bundle:nil]instantiateViewControllerWithIdentifier:@"eventoArmarioVC"];
        self.eventoArmarioVC.delegate = self;
        self.eventoArmarioVC.armario = self.armario;
        
        [self.navigationController pushViewController:self.eventoArmarioVC animated:YES];
    }
}

-(void)eventoArmarioGrbado:(EventoArmario*)evento{

    self.eventoArmario = evento;
    
    
    self.periodoLuzLabel.text =  [NSString stringWithFormat:@"Periodo de Luz: %@", self.eventoArmario.cambioFotoPeriodo.horasLuz];
    
    self.periodoOscuridadLabel.text = [NSString stringWithFormat:@"Periodo de Oscuridad: %@", self.eventoArmario.cambioFotoPeriodo.horasOscuridad];
    
    self.iluminacionLabel.text = [NSString stringWithFormat:@"Tipo Iluminacion: %@ %@", self.eventoArmario.cambioTipoIluminacion.tipo, self.eventoArmario.cambioTipoIluminacion.watts];
    
    [self.periodoLuzLabel setTextColor:[UIColor redColor]];
    [self.periodoOscuridadLabel setTextColor:[UIColor redColor]];
    [self.iluminacionLabel setTextColor:[UIColor redColor]];
    
    [self.cambiosArmarioButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.cambiosArmarioButton setTitle:@"Remover Cambios" forState:UIControlStateNormal];
}

-(void)eventoArmarioClosed{
   
}

- (IBAction)cambioPlantasTapped:(id)sender {
    
    self.eventoPlantaVC = [[UIStoryboard storyboardWithName:@"Logs" bundle:nil]instantiateViewControllerWithIdentifier:@"EventoPlantaVC"];
    
    [self.navigationController pushViewController:self.eventoPlantaVC animated:YES];
}



@end
