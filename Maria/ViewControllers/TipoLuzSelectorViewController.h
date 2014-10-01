//
//  TipoLuzSelectorViewController.h
//  Maria
//
//  Created by Juan Escudero on 10/1/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Luces;

@protocol TipoLuzSelectorDelegate <NSObject>

-(void)cancelLuzSeleccion;
-(void)seleccionTipoIluminacion:(Luces*)luz;

@end

@interface TipoLuzSelectorViewController : UIViewController

@property (nonatomic, strong) id<TipoLuzSelectorDelegate> delegate;

@end
