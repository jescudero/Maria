//
//  EventoPlantaViewController.m
//  Maria
//
//  Created by Juan Escudero on 10/23/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "EventoPlantaViewController.h"

@interface EventoPlantaViewController ()
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

@end

@implementation EventoPlantaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Evento Planta";
    
    self.widthView.constant = self.view.frameWidth;
    
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

@end
