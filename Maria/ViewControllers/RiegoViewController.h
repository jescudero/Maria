//
//  RiegoViewController.h
//  Maria
//
//  Created by Juan Escudero on 10/24/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Riego;

@protocol RiegoProtocol <NSObject>

-(void)riegoGrabado:(Riego*)riego;
-(void)riegoCancelado;
-(void)keybaoarShow:(NSNotification *)note;
-(void)keybaoarHide:(NSNotification *)note;

@end

@interface RiegoViewController : UIViewController

@property (nonatomic, strong) id<RiegoProtocol> delegate;

@end
