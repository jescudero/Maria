//
//  EventoArmarioViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/22/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "EventoArmarioViewController.h"
#import "Armario.h"
#import "PeriodoLuz.h"
#import "Luces.h"
#import "FechaSelectorViewController.h"
#import "EventoArmario.h"

@interface EventoArmarioViewController ()<UITableViewDelegate, UITableViewDataSource, FechaSelectorProtocol>

@property (weak, nonatomic) IBOutlet UITableView *iluminacionTable;
@property (weak, nonatomic) IBOutlet UITextField *horasLuzText;
@property (weak, nonatomic) IBOutlet UITextField *horasOscuridadText;
@property (weak, nonatomic) IBOutlet UIStepper *horasLuzStepper;
@property (weak, nonatomic) IBOutlet UIStepper *horasOscuridadStepper;
@property (weak, nonatomic) IBOutlet UIButton *cambiarButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelarButton;
@property (weak, nonatomic) IBOutlet UIButton *calendarioButton;
@property (weak, nonatomic) IBOutlet UITextField *fechaText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthView;

@property (nonatomic, strong) NSArray *iluminacionList;
@property (nonatomic, strong) NSIndexPath *selectedIndex;

@property (nonatomic) NSInteger horasLuz;
@property (nonatomic) NSInteger horasOscuridad;

@property (nonatomic, strong) FechaSelectorViewController *fechaVC;
@end

@implementation EventoArmarioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.widthView.constant = self.view.frameWidth;
    
    self.title = @"Cambio en el Armario";
    
    self.iluminacionList = [Luces all];
    
    self.horasLuz = [self.armario.fotoPeriodo.horasLuz integerValue];
    self.horasOscuridad = [self.armario.fotoPeriodo.horasOscuridad integerValue];
    
    self.horasLuzStepper.value = self.horasLuz;
    self.horasOscuridadStepper.value = self.horasOscuridad;
    
    self.horasLuzText.text = [NSString stringWithFormat:@"%d", (int)self.horasLuzStepper.value];
    
    self.horasOscuridadText.text = [NSString stringWithFormat:@"%d", (int)self.horasOscuridadStepper.value];
    
    [self.iluminacionTable reloadData];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    
    self.fechaText.text =stringFromDate;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.iluminacionTable selectRowAtIndexPath:self.selectedIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
    
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
- (IBAction)luzStepperTapped:(UIStepper*)sender {
    
    if (self.horasLuz > 0 || self.horasLuz < 24)
    {
        self.horasLuz = [sender value];
        self.horasOscuridad = 24 - self.horasLuz;
        self.horasLuzText.text = [NSString stringWithFormat:@"%d", (int)self.horasLuz];
        self.horasOscuridadText.text = [NSString stringWithFormat:@"%d", (int)self.horasOscuridad];
    }

    
}

- (IBAction)oscuridadStepperTapped:(UIStepper*)sender {
    
    if (self.horasOscuridad > 0 || self.horasLuz < 24)
    {
        self.horasOscuridad = [sender value];
        self.horasLuz = 24 - self.horasOscuridad;
        self.horasLuzText.text = [NSString stringWithFormat:@"%d", (int)self.horasLuz];
        self.horasOscuridadText.text = [NSString stringWithFormat:@"%d", (int)self.horasOscuridad];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.iluminacionList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipoLuzCell" forIndexPath:indexPath];
    
    Luces *element = self.iluminacionList[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", element.tipo, element.watts];
    
    if ([element.tipo isEqualToString:self.armario.iluminacion.tipo] & [element.watts isEqualToValue:self.armario.iluminacion.watts])
    {
        self.selectedIndex = indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    if ((indexPath.row % 2) == 0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:244/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cellUnselect = [tableView cellForRowAtIndexPath:self.selectedIndex];
    cellUnselect.accessoryType = UITableViewCellAccessoryNone;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    self.selectedIndex = indexPath;

}

- (IBAction)cambiarTapped:(id)sender {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    PeriodoLuz *periodo = [PeriodoLuz create];
    periodo.horasLuz = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",self.horasLuz]];
    periodo.horasOscuridad = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",self.horasOscuridad]];
    
    EventoArmario *eventoArmario = [EventoArmario create];
    eventoArmario.fecha = [dateFormatter dateFromString:self.fechaText.text];
    eventoArmario.cambioFotoPeriodo = periodo;
    eventoArmario.cambioTipoIluminacion = (Luces*)self.iluminacionList[[self.iluminacionTable indexPathForSelectedRow].row];
    eventoArmario.armario = self.armario;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate eventoArmarioGrbado:eventoArmario];
}

- (IBAction)cancelarTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)calendarioTApped:(id)sender {

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

@end
