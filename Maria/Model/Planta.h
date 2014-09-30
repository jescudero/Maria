//
//  Planta.h
//  Maria
//
//  Created by Juan Escudero on 9/29/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CicloVida;

@interface Planta : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * altura;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) CicloVida *inicioCicloVida;

@end
