//
//  Armario.h
//  Maria
//
//  Created by Juan Escudero on 9/29/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Luces, PeriodoLuz, Planta;

@interface Armario : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * alto;
@property (nonatomic, retain) NSDecimalNumber * ancho;
@property (nonatomic, retain) NSDecimalNumber * largo;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSSet *plantas;
@property (nonatomic, retain) Luces *iluminacion;
@property (nonatomic, retain) PeriodoLuz *fotoPeriodo;
@end

@interface Armario (CoreDataGeneratedAccessors)

- (void)addPlantasObject:(Planta *)value;
- (void)removePlantasObject:(Planta *)value;
- (void)addPlantas:(NSSet *)values;
- (void)removePlantas:(NSSet *)values;

@end
