//
//  EventoArmarioViewController.h
//  Maria
//
//  Created by Juan Escudero on 10/22/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Armario;
@class EventoArmario;

@protocol EventoArmarioProtocol <NSObject>

-(void)eventoArmarioGrbado:(EventoArmario*)evento;
-(void)eventoArmarioClosed;

@end

@interface EventoArmarioViewController : UIViewController

@property (nonatomic, strong) id<EventoArmarioProtocol> delegate;
@property (nonatomic, strong) Armario *armario;

@end
