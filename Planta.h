//
//  Planta.h
//  Maria
//
//  Created by Juan Escudero on 11/2/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CicloVida, EventoPlanta, TipoPlanta;

@interface Planta : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * altura;
@property (nonatomic, retain) NSData * foto;
@property (nonatomic, retain) NSString * genetica;
@property (nonatomic, retain) NSSet *eventos;
@property (nonatomic, retain) CicloVida *inicioCicloVida;
@property (nonatomic, retain) TipoPlanta *tipoPlanta;
@end

@interface Planta (CoreDataGeneratedAccessors)

- (void)addEventosObject:(EventoPlanta *)value;
- (void)removeEventosObject:(EventoPlanta *)value;
- (void)addEventos:(NSSet *)values;
- (void)removeEventos:(NSSet *)values;

@end
