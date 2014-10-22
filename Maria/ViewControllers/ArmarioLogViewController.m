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

@interface ArmarioLogViewController ()<UITableViewDataSource, UITableViewDelegate, EventoArmarioProtocol>

@property (weak, nonatomic) IBOutlet UILabel *armarioLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodoLuzLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodoOscuridadLabel;
@property (weak, nonatomic) IBOutlet UILabel *iluminacionLabel;

@property (weak, nonatomic) IBOutlet UILabel *dimensionLAbel;
@property (weak, nonatomic) IBOutlet UITableView *plantasTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@property (strong, nonatomic) EventoArmarioViewController *eventoArmarioVC;

@property (nonatomic, strong) UIView *overlayView;

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
    
    self.overlayView = [[UIView alloc]initWithFrame:self.view.frame];
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayView.alpha = 0.5;
    [self.view addSubview:self.overlayView];
    
    self.eventoArmarioVC = [[UIStoryboard storyboardWithName:@"Logs" bundle:nil]instantiateViewControllerWithIdentifier:@"eventoArmarioVC"];
    self.eventoArmarioVC.view.frame = CGRectMake(self.view.frame.size.width/2 - 300/2, 50, 300, 480);
    self.eventoArmarioVC.delegate = self;
    self.eventoArmarioVC.armario = self.armario;
    
    [self addChildViewController:self.eventoArmarioVC];
    [self.view addSubview:self.eventoArmarioVC.view];
    
}

-(void)eventoArmarioGrbado:(EventoArmario*)evento{

    
}

-(void)eventoArmarioClosed{

    [self.overlayView removeFromSuperview];

    [self.eventoArmarioVC removeFromParentViewController];
    [self.eventoArmarioVC.view removeFromSuperview];
    
}

- (IBAction)cambioPlantasTapped:(id)sender {
    
}

@end
