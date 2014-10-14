//
//  ErrorViewController.h
//  Maria
//
//  Created by Juan Francisco on 11/10/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErrorViewDelegate <NSObject>

-(void)dismissErrorView:(UIView*)view;

@end

@interface ErrorViewController : UIViewController

@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) id<ErrorViewDelegate> delegate;

-(void)showInView:(UIView*)view;

@end
