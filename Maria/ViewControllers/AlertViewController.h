//
//  AlertViewController.h
//  Maria
//
//  Created by Juan Escudero on 10/28/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *alertText;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end
