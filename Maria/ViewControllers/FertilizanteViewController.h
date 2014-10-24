//
//  FertilizanteViewController.h
//  Maria
//
//  Created by Juan Escudero on 10/24/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Fertilizante;

@protocol FertilizanteProtocol <NSObject>

-(void)fertilizanteGuardado:(Fertilizante*)fertilizante;
-(void)fertilizanteCancelado;
-(void)keybaoarShow:(NSNotification *)note;
-(void)keybaoarHide:(NSNotification *)note;

@end

@interface FertilizanteViewController : UIViewController

@property (nonatomic, strong) id<FertilizanteProtocol> delegate;

@end
