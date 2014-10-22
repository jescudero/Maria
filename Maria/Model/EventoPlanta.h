//
//  EventoPlanta.h
//  Pods
//
//  Created by Juan Escudero on 10/22/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fertilizante, Planta, Riego;

@interface EventoPlanta : NSManagedObject

@property (nonatomic, retain) NSDate * fecha;
@property (nonatomic, retain) NSData * foto;
@property (nonatomic, retain) Planta *planta;
@property (nonatomic, retain) Riego *riego;
@property (nonatomic, retain) Fertilizante *fertilizante;

@end
