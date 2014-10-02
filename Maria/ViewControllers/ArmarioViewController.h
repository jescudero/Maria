//
//  ArmarioViewController.h
//  Maria
//
//  Created by Juan Escudero on 9/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Armario;

@protocol AgregarArmarioProtocol <NSObject>

-(void)cancelAgregarArmario;

-(void)armarioAgregado:(Armario*)armario;

@end

@interface ArmarioViewController : UIViewController

@property (nonatomic, strong) id<AgregarArmarioProtocol> delegate;

@end
