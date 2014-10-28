//
//  EventoPlantaViewController.h
//  Maria
//
//  Created by Juan Escudero on 10/23/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Planta;
@class EventoPlanta;

@protocol EventoPlantaProtocol <NSObject>

-(void)eventoPlantaCreado:(NSArray*)eventos;

@end

@interface EventoPlantaViewController : UIViewController

@property (nonatomic, strong) Planta *planta;
@property (nonatomic, strong) NSArray *listaPlantas;

@property (nonatomic, strong) id<EventoPlantaProtocol> delegate;


@end
