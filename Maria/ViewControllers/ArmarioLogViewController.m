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

@interface ArmarioLogViewController ()
@property (weak, nonatomic) IBOutlet UILabel *periodoLuzLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodoOscuridadLabel;

@end

@implementation ArmarioLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Log Armario";
    
    self.periodoLuzLabel.text =  [NSString stringWithFormat:@"Periodo de Luz: %@", self.armario.fotoPeriodo.horasLuz];

    self.periodoOscuridadLabel.text = [NSString stringWithFormat:@"Periodo de Oscuridad: %@", self.armario.fotoPeriodo.horasOscuridad];
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

@end
