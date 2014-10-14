//
//  CultivoViewController.h
//  Maria
//
//  Created by Juan Escudero on 9/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cultivo;

<<<<<<< HEAD
@protocol CultivoGrabadoDelegate <NSObject>
=======
@protocol CultivoViewControllerProtocol <NSObject>
>>>>>>> 4288a64056a4ec807c9e58c9f5bbfbd2f4bd7517

-(void)cultivoGrabado:(Cultivo*)cultivo;

@end

@interface CultivoViewController : UIViewController

@property (nonatomic, strong) Cultivo *cultivo;
@property (nonatomic, strong) id<CultivoGrabadoDelegate> delegate;

@property (nonatomic, strong) id<CultivoViewControllerProtocol> delegate;

@end
