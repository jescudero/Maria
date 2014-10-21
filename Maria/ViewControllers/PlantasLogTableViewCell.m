//
//  PlantasLogTableViewCell.m
//  Maria
//
//  Created by Juan Escudero on 10/21/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "PlantasLogTableViewCell.h"
#import "Planta.h"
#import "TipoPlanta.h"

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
    
    if (planta.foto)
        self.foto.image = [UIImage imageWithData:planta.foto];
    else
        self.foto.image = [UIImage imageNamed:@"purple"];

    
    self.titulo.text = [NSString stringWithFormat:@"%@, ciclo de vida:%@", planta.tipoPlanta.tipoPlanta, @"PONER CICLO"];
    self.subtitulo.text = [NSString stringWithFormat:@"%@, %@", planta.genetica, planta.altura];
    
}

@end
