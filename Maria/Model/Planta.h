//
//  Planta.h
//  Maria
//
//  Created by Juan Escudero on 10/15/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CicloVida, TipoPlanta;

@interface Planta : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * altura;
@property (nonatomic, retain) NSString * genetica;
@property (nonatomic, retain) NSData * foto;
@property (nonatomic, retain) CicloVida *inicioCicloVida;
@property (nonatomic, retain) TipoPlanta *tipoPlanta;

@end
