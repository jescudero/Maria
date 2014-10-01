//
//  Armario.m
//  Maria
//
//  Created by Juan Escudero on 9/29/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "Armario.h"
#import "Luces.h"
#import "PeriodoLuz.h"
#import "Planta.h"


@implementation Armario

@dynamic alto;
@dynamic ancho;
@dynamic largo;
@dynamic nombre;
@dynamic plantas;
@dynamic iluminacion;
@dynamic fotoPeriodo;

+ (NSString *)entityName
{
    return @"Armario";
}

+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                         inManagedObjectContext:context];
}

-(void)save:(NSManagedObjectContext *)context
{
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

}

@end
