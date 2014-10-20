//
//  CultivoLogHeaderView.m
//  Maria
//
//  Created by Juan Escudero on 10/20/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "CultivoLogHeaderView.h"
#import "Cultivo.h"
#import "Planta.h"
#import "Armario.h"

@implementation CultivoLogHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)configureView:(Cultivo*)cultivo
{
    Planta *planta = [((Armario*)[cultivo.armarios allObjects][0]).plantas allObjects][0];

    if (planta.foto)
        self.foto.image = [UIImage imageWithData:planta.foto];
    else
        self.foto.image = [UIImage imageNamed:@"purple"];
    
    
    self.foto.layer.cornerRadius =  self.foto.frame.size.height /2;
    self.foto.layer.masksToBounds = YES;
    self.foto.layer.borderWidth = 0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];

    NSString *fechaIni = [formatter stringFromDate:cultivo.fechaInicio];
    NSString *fechaFin = [formatter stringFromDate:cultivo.fechaFin];

    self.cultivoLabel.text = [NSString stringWithFormat:@"%@ : %@ - %@", cultivo.nombre, fechaIni, fechaFin];
    
}

@end
