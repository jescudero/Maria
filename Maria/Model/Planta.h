//
//  Planta.h
//  Pods
//
//  Created by Juan Escudero on 10/2/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CicloVida, TipoPlanta;

@interface Planta : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * altura;
@property (nonatomic, retain) NSString * genetica;
@property (nonatomic, retain) CicloVida *inicioCicloVida;
@property (nonatomic, retain) TipoPlanta *tipoPlanta;

@end
