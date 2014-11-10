//
//  PlantasLogTableViewCell.m
//  Maria
//
//  Created by Juan Escudero on 10/21/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "PlantasLogTableViewCell.h"
#import "Planta.h"
#import "Planta+ViewManagement.h"
#import "TipoPlanta.h"
#import "CicloVida.h"
#import "EventoPlanta.h"

#import "UIImageHelper.h"

@implementation PlantasLogTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(Planta*)planta
{
    self.planta = planta;
    
    if (planta.foto)
        self.foto.image = [UIImage imageWithData:planta.foto];
    else
    {
        UIImageHelper *helper = [[UIImageHelper alloc]init];
        self.foto.image = [helper getRandomFlowerImage];
    }
    
    NSString *ciclo = planta.inicioCicloVida.nombre;
    
    if (planta.eventos.count > 0)
    {
        NSArray *eventos = [planta.eventos allObjects];
        
        NSArray *sortArray = [eventos sortedArrayUsingComparator: ^(EventoPlanta *obj1, EventoPlanta *obj2) {
            return [obj1.fecha compare:obj2.fecha];
        }];
        
        if (((EventoPlanta*)sortArray[0]).cambioCicloVida)
            ciclo = ((EventoPlanta*)sortArray[0]).cambioCicloVida.nombre;
    }
    
    self.tipo.text = [NSString stringWithFormat:@"Tipo:%@", planta.tipoPlanta.tipoPlanta];
    self.ciclo.text = [NSString stringWithFormat:@"Ciclo vida:%@", ciclo];
    self.genetica.text = [NSString stringWithFormat:@"Genetica:%@", planta.genetica];
    
    if (self.planta.tieneCambios)
        if (self.planta.tieneCambios.boolValue == YES)
            [self.cambioButton setTitle:@"Eliminar" forState:UIControlStateNormal];
    
}

- (IBAction)cambioButtonTapped:(id)sender {

    if ([self.cambioButton.titleLabel.text isEqualToString:@"Cambio"])
    {
       // self.planta.tieneCambios = [NSNumber numberWithBool:YES];
        [self.delegate cambioButtonTapped:self.planta];
    }
    else
    {
        self.planta.tieneCambios = [NSNumber numberWithBool:NO];
        [self.delegate eliminarCambioButtonTapped:self.planta];
    }
}


@end
