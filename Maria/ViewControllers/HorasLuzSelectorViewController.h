//
//  HorasLuzSelectorViewController.h
//  Maria
//
//  Created by Juan Escudero on 9/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HorasSelectorDelegate <NSObject>

-(void)cancelSeleccion;
-(void)selectionLuz:(NSInteger)luz oscuridad:(NSInteger)oscuridad;

@end

@interface HorasLuzSelectorViewController : UIViewController

@property (nonatomic, strong) id<HorasSelectorDelegate> delegate;

@end
