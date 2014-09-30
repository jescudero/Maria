//
//  PeriodoLuz.h
//  Maria
//
//  Created by Juan Escudero on 9/29/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PeriodoLuz : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * horasLuz;
@property (nonatomic, retain) NSDecimalNumber * horasOscuridad;

@end
