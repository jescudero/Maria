//
//  Cultivo.h
//  Maria
//
//  Created by Juan Escudero on 9/29/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Armario;

@interface Cultivo : NSManagedObject

@property (nonatomic, retain) NSDate * fechaFin;
@property (nonatomic, retain) NSDate * fechaInicio;
@property (nonatomic, retain) NSString * notas;
@property (nonatomic, retain) NSNumber * tipo;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSSet *armarios;
@end

@interface Cultivo (CoreDataGeneratedAccessors)

- (void)addArmariosObject:(Armario *)value;
- (void)removeArmariosObject:(Armario *)value;
- (void)addArmarios:(NSSet *)values;
- (void)removeArmarios:(NSSet *)values;

-(void)saveCultivo;

@end
