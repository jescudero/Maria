//
//  FertilizanteViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/24/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "FertilizanteViewController.h"
#import "Fertilizante.h"

@interface FertilizanteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nombreText;
@property (weak, nonatomic) IBOutlet UITextField *marcaText;
@property (weak, nonatomic) IBOutlet UITextField *tipoText;
@property (weak, nonatomic) IBOutlet UITextView *caracteristicasText;

@end

@implementation FertilizanteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Fertilizante";
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
- (IBAction)guardarTapped:(id)sender {
    
    Fertilizante *fertilizante = [Fertilizante create];
    fertilizante.nombre = self.nombreText.text;
    fertilizante.caracteristicas = self.caracteristicasText.text;
    fertilizante.marca = self.marcaText.text;
    fertilizante.tipo = self.tipoText.text;
    
    [self.delegate fertilizanteGuardado:fertilizante];
    
}

- (IBAction)cancelarTapped:(id)sender {
    
    [self.delegate fertilizanteCancelado];
}
@end
