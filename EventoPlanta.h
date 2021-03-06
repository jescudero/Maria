//
//  EventoPlanta.h
//  Maria
//
//  Created by Juan Escudero on 10/27/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CicloVida, Fertilizante, Planta, Riego;

@interface EventoPlanta : NSManagedObject

@property (nonatomic, retain) NSDate * fecha;
@property (nonatomic, retain) NSData * foto1;
@property (nonatomic, retain) NSData * foto2;
@property (nonatomic, retain) NSDecimalNumber * cambioAltura;
@property (nonatomic, retain) CicloVida *cambioCicloVida;
@property (nonatomic, retain) Fertilizante *fertilizante;
@property (nonatomic, retain) Planta *planta;
@property (nonatomic, retain) Riego *riego;

@end
