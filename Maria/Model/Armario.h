//
//  Armario.h
//  Pods
//
//  Created by Juan Escudero on 10/22/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Evento, Luces, PeriodoLuz, Planta;

@interface Armario : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * alto;
@property (nonatomic, retain) NSDecimalNumber * ancho;
@property (nonatomic, retain) NSDecimalNumber * largo;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) PeriodoLuz *fotoPeriodo;
@property (nonatomic, retain) Luces *iluminacion;
@property (nonatomic, retain) NSSet *plantas;
@property (nonatomic, retain) NSSet *eventos;
@end

@interface Armario (CoreDataGeneratedAccessors)

- (void)addPlantasObject:(Planta *)value;
- (void)removePlantasObject:(Planta *)value;
- (void)addPlantas:(NSSet *)values;
- (void)removePlantas:(NSSet *)values;

- (void)addEventosObject:(Evento *)value;
- (void)removeEventosObject:(Evento *)value;
- (void)addEventos:(NSSet *)values;
- (void)removeEventos:(NSSet *)values;

@end
