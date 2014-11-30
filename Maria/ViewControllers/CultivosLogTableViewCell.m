//
//  CultivosLogTableViewCell.m
//  Maria
//
//  Created by Juan Escudero on 10/20/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "CultivosLogTableViewCell.h"
#import "Cultivo.h"
#import "Armario.h"
#import "Planta.h"
#import "EventoPlanta.h"
#import "EventoArmario.h"


@implementation CultivosLogTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureView:(Armario*)armario
{
    self.armarioLabel.text = [NSString stringWithFormat:@"Armario: %@ - Plantas: %@", armario.nombre, @(armario.plantas.count)];
    
    
    NSString *ultimoEventoArmario = @"-";
    
    NSArray *eventoArmario = [armario.eventos allObjects];
    
    if (eventoArmario.count > 0)
    {
        NSArray *sortArray = [eventoArmario sortedArrayUsingComparator: ^(EventoArmario *obj1, EventoArmario *obj2) {
        return [obj2.fecha compare:obj1.fecha];
        }];
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        [formatter setLocale:[NSLocale currentLocale]];
    
        ultimoEventoArmario = [formatter stringFromDate:((EventoArmario*)sortArray[0]).fecha];
    }
    
    self.eventosArmarioLabel.text = [NSString stringWithFormat:@"Ultima modificacion armario: %@", ultimoEventoArmario];
    
    
    NSString *ultimoEventoPlanta = @"-";
    
    NSArray *plantas = [armario.plantas allObjects];
    
    NSMutableArray *eventosPlantas = [[NSMutableArray alloc]init];
    
    for (Planta *planta in plantas) {
    
        if (planta.eventos.count > 0)
            [eventosPlantas addObjectsFromArray:[planta.eventos allObjects]];
    }
    
    if (eventosPlantas.count > 0)
    {
        NSArray *sortArrayPlantas = [eventosPlantas sortedArrayUsingComparator: ^(EventoPlanta *obj1, EventoPlanta *obj2) {
            return [obj2.fecha compare:obj1.fecha];
        }];
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        [formatter setLocale:[NSLocale currentLocale]];
        
        ultimoEventoPlanta = [formatter stringFromDate:((EventoPlanta*)sortArrayPlantas[0]).fecha];
    }
             
    self.eventosPlantaLabel.text = [NSString stringWithFormat:@"Ultima modificacion plantas: %@", ultimoEventoPlanta];
    
}

@end
