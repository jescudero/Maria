//
//  PeriodoLuz.m
//  Maria
//
//  Created by Juan Escudero on 9/29/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "PeriodoLuz.h"


@implementation PeriodoLuz

@dynamic horasLuz;
@dynamic horasOscuridad;


+ (NSString *)entityName
{
    return @"PeriodoLuz";
}

+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                         inManagedObjectContext:context];
}

@end
