//
//  DataManager.m
//  Maria
//
//  Created by Juan Escudero on 10/1/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "DataManager.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

#import "Luces.h"
#import "CicloVida.h"
#import "TipoPlanta.h"

@implementation DataManager



-(void)createApplicationObjects{

    if (![self isDataSaved])
        [self createInitialObjects];
    
}

-(BOOL)isDataSaved;
{
    return [Luces all].count > 0;
}

-(void)createInitialObjects
{

    Luces *luz1 = [Luces create];
    luz1.tipo = @"Halogeno";
    luz1.watts = [NSDecimalNumber decimalNumberWithString:@"250.0"];
    [luz1 save];
    
    Luces *luz2 = [Luces create];
    luz2.tipo = @"Halogeno";
    luz2.watts = [NSDecimalNumber decimalNumberWithString:@"400.0"];
    [luz2 save];

    Luces *luz3 = [Luces create];
    luz3.tipo = @"Halogeno";
    luz3.watts = [NSDecimalNumber decimalNumberWithString:@"150.0"];
    [luz3 save];

    Luces *luz4 = [Luces create];
    luz4.tipo = @"Sodio";
    luz4.watts = [NSDecimalNumber decimalNumberWithString:@"150.0"];
    [luz4 save];

    Luces *luz5 = [Luces create];
    luz5.tipo = @"Sodio";
    luz5.watts = [NSDecimalNumber decimalNumberWithString:@"250.0"];
    [luz5 save];

    Luces *luz6 = [Luces create];
    luz6.tipo = @"Sodio";
    luz6.watts = [NSDecimalNumber decimalNumberWithString:@"400.0"];
    [luz6 save];
    
    
    CicloVida *ciclo1 = [CicloVida create];
    ciclo1.nombre = @"Germinacion";
    [ciclo1 save];

    CicloVida *ciclo2 = [CicloVida create];
    ciclo2.nombre = @"Planton";
    [ciclo2 save];
    
    CicloVida *ciclo3 = [CicloVida create];
    ciclo3.nombre = @"Vegetacion";
    [ciclo3 save];
    
    CicloVida *ciclo4 = [CicloVida create];
    ciclo4.nombre = @"Pre-Floracion";
    [ciclo4 save];
    
    CicloVida *ciclo5 = [CicloVida create];
    ciclo5.nombre = @"Floracion";
    [ciclo5 save];
    
    
    TipoPlanta *tipoPlanta1 = [TipoPlanta create];
    tipoPlanta1.tipoPlanta = @"Sativa";
    [tipoPlanta1 save];
    
    TipoPlanta *tipoPlanta2 = [TipoPlanta create];
    tipoPlanta2.tipoPlanta = @"Indica";
    [tipoPlanta2 save];
    
    TipoPlanta *tipoPlanta3 = [TipoPlanta create];
    tipoPlanta3.tipoPlanta = @"Ruderalis";
    [tipoPlanta3 save];
    
    TipoPlanta *tipoPlanta4 = [TipoPlanta create];
    tipoPlanta4.tipoPlanta = @"Sativa-Indica";
    [tipoPlanta4 save];
    
}



@end
