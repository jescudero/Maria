//
//  Fertilizante.h
//  Maria
//
//  Created by Juan Escudero on 9/29/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Fertilizante : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSString * caracteristicas;
@property (nonatomic, retain) NSString * marca;

@end
