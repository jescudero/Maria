//
//  LogTableViewCell.m
//  Maria
//
//  Created by Juan Escudero on 11/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "LogTableViewCell.h"
#import "EventoArmario.h"
#import "EventoPlanta.h"
#import "CicloVida.h"
#import "Fertilizante.h"
#import "Riego.h"


@implementation LogTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellEventoArmario:(EventoArmario*)eventoArmario{

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [formatter setLocale:[NSLocale currentLocale]];
    
    
    self.fechaLabel.text = [formatter stringFromDate:eventoArmario.fecha];
    
}

-(void)configureCellEventoPlanta:(EventoPlanta*)eventoPlanta{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [formatter setLocale:[NSLocale currentLocale]];
    
    
    self.fechaLabel.text = [formatter stringFromDate:eventoPlanta.fecha];

    NSString *cambioAltura = @"";
    NSString *cambioCiclo = @"";
    NSString *cambioRiego = @"";
    NSString *cambioFetr = @"";

    
    if (eventoPlanta.cambioAltura != [NSDecimalNumber numberWithInt:0])
        cambioAltura = [NSString stringWithFormat:@"Nueva altura: %@ \n", eventoPlanta.cambioAltura];
    
    if (eventoPlanta.cambioCicloVida != nil)
        cambioCiclo = [NSString stringWithFormat:@"Ciclo de vida: %@ \n", eventoPlanta.cambioCicloVida.nombre];
    
    if (eventoPlanta.riego != nil)
    {
        
        NSString *litros = [eventoPlanta.riego.litros isEqualToNumber:[NSNumber numberWithInt:0]] ? @"Riego indeterminado" : eventoPlanta.riego.litros.stringValue;
        
        NSString *ec = [eventoPlanta.riego.ec isEqualToNumber:[NSNumber numberWithInt:0]] ? @"NN" : eventoPlanta.riego.ec.stringValue;
        
        NSString *ph = [eventoPlanta.riego.ph isEqualToNumber:[NSNumber numberWithInt:0]] ? @"NN" : eventoPlanta.riego.ph.stringValue;
        
        NSString *temperatura = [eventoPlanta.riego.temperatura isEqualToNumber:[NSNumber numberWithInt:0]] ? @"NN" : eventoPlanta.riego.temperatura.stringValue;
        
        if ([litros isEqualToString:@"Riego indeterminado"])
            cambioRiego = litros;
        else
            cambioRiego = [NSString stringWithFormat:@" %@ lts (ec: %@ - ph: %@ - temp: %@) \n", litros, ec, ph, temperatura];
        

    }
    
    if (eventoPlanta.fertilizante != nil)
    {
        NSString *nombre = [eventoPlanta.fertilizante.nombre isEqualToString:@""] ? @"Generico" : eventoPlanta.fertilizante.nombre;
        NSString *tipo = [eventoPlanta.fertilizante.tipo isEqualToString:@""] ? @"" : eventoPlanta.fertilizante.tipo;
        NSString *marca = [eventoPlanta.fertilizante.marca isEqualToString:@""] ? @"NN" : eventoPlanta.fertilizante.marca;
        
        cambioFetr = [NSString stringWithFormat:@"%@, %@ (%@) \n", nombre, tipo, marca];
        
    }
    
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@ %@", cambioAltura, cambioCiclo, cambioRiego, cambioFetr];
    
    self.detailLabel.text = [text substringToIndex:[text length]-2];
    
}


@end
