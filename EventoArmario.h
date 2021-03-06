//
//  EventoArmario.h
//  Maria
//
//  Created by Juan Escudero on 10/27/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Armario, Luces, PeriodoLuz;

@interface EventoArmario : NSManagedObject

@property (nonatomic, retain) NSDate * fecha;
@property (nonatomic, retain) Armario *armario;
@property (nonatomic, retain) PeriodoLuz *cambioFotoPeriodo;
@property (nonatomic, retain) Luces *cambioTipoIluminacion;

@end
