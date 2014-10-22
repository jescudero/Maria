//
//  RepetirPlantaViewController.h
//  Maria
//
//  Created by Juan Escudero on 10/22/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RepetirPlantaDelegate <NSObject>

-(void)repetirPlanta:(NSInteger)num;

@end

@interface RepetirPlantaViewController : UIViewController

@property (nonatomic, strong) id<RepetirPlantaDelegate> delegate;

@end
