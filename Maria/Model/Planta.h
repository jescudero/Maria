//
//  Planta.h
//  Pods
//
//  Created by Juan Escudero on 10/22/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CicloVida, EventoPlanta, TipoPlanta;

@interface Planta : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * altura;
@property (nonatomic, retain) NSData * foto;
@property (nonatomic, retain) NSString * genetica;
@property (nonatomic, retain) CicloVida *inicioCicloVida;
@property (nonatomic, retain) TipoPlanta *tipoPlanta;
@property (nonatomic, retain) NSSet *eventos;
@end

@interface Planta (CoreDataGeneratedAccessors)

- (void)addEventosObject:(EventoPlanta *)value;
- (void)removeEventosObject:(EventoPlanta *)value;
- (void)addEventos:(NSSet *)values;
- (void)removeEventos:(NSSet *)values;

@end
