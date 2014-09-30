//
//  Evento.h
//  Maria
//
//  Created by Juan Escudero on 9/29/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fertilizante, Luces, PeriodoLuz, Riego;

@interface Evento : NSManagedObject

@property (nonatomic, retain) NSDate * fecha;
@property (nonatomic, retain) Riego *riego;
@property (nonatomic, retain) PeriodoLuz *cambioFotoPeriodo;
@property (nonatomic, retain) Luces *cambioTipoIluminacion;
@property (nonatomic, retain) Fertilizante *fertilizante;

@end
