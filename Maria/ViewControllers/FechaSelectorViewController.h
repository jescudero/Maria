//
//  FechaSelectorViewController.h
//  Maria
//
//  Created by Juan Escudero on 10/3/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FechaSelectorProtocol <NSObject>

-(void)cancelFecha;
-(void)selectFecha:(NSDate*)fecha;


@end

@interface FechaSelectorViewController : UIViewController

@property (nonatomic, strong) id<FechaSelectorProtocol> delegate;

@end
