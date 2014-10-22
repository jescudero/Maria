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

@interface EventoArmarioViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *iluminacionTable;
@property (weak, nonatomic) IBOutlet UITextField *horasLuzText;
@property (weak, nonatomic) IBOutlet UITextField *horasOscuridadText;
@property (weak, nonatomic) IBOutlet UIStepper *horasLuzStepper;
@property (weak, nonatomic) IBOutlet UIStepper *horasOscuridadStepper;
@property (weak, nonatomic) IBOutlet UIButton *cambiarButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelarButton;


@property (nonatomic, strong) NSArray *iluminacionList;
@property (nonatomic, strong) NSIndexPath *selectedIndex;

@property (nonatomic) NSInteger horasLuz;
@property (nonatomic) NSInteger horasOscuridad;

@end

@implementation EventoArmarioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.iluminacionList = [Luces all];
    
    
    self.horasLuz = 12.0;
    self.horasOscuridad = 12.0;
    
    self.horasLuzStepper.value = self.horasLuz;
    self.horasOscuridadStepper.value = self.horasOscuridad;
    
    self.horasLuzText.text = [NSString stringWithFormat:@"%d", (int)self.horasLuzStepper.value];
    
    self.horasOscuridadText.text = [NSString stringWithFormat:@"%d", (int)self.horasOscuridadStepper.value];
    
    [self.iluminacionTable reloadData];
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

    [self.delegate eventoArmarioClosed];
}

- (IBAction)cancelarTapped:(id)sender {
    
    [self.delegate eventoArmarioClosed];
}

@end
