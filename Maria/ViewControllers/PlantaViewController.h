//
//  PlantaViewController.h
//  Maria
//
//  Created by Juan Escudero on 10/2/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Planta;

@protocol PlantaViewControllerDelegate <NSObject>

-(void)plantaAgregada:(Planta*)planta;
-(void)cancelAgregarPlanta;

@end

@interface PlantaViewController : UIViewController

@property (nonatomic,strong) id<PlantaViewControllerDelegate> delegate;

@end
