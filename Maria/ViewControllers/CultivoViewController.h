//
//  CultivoViewController.h
//  Maria
//
//  Created by Juan Escudero on 9/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cultivo;

@protocol CultivoViewControllerProtocol <NSObject>

-(void)cultivoGrabado:(Cultivo*)cultivo;

@end

@interface CultivoViewController : UIViewController

@property (nonatomic, strong) Cultivo *cultivo;

@property (nonatomic, strong) id<CultivoViewControllerProtocol> delegate;

@end
