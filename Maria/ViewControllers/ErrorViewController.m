//
//  ErrorViewController.m
//  Maria
//
//  Created by Juan Francisco on 11/10/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "ErrorViewController.h"

@interface ErrorViewController ()

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation ErrorViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frameHeight = 70;
    self.view.frameY = -self.view.frameHeight;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissError:(UITapGestureRecognizer*)gesture
{
    
    if ([self.delegate respondsToSelector:@selector(dismissError:)])
        [self.delegate dismissErrorView:self.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frameY = -self.view.frameHeight;
    }];
}

-(void)showInView:(UIView*)view{
    
    [view addSubview:self.view];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissError:)];
    gesture.numberOfTapsRequired = 1;
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:gesture];

    
    self.view.frameWidth = view.frameWidth;
    
    self.view.backgroundColor = self.backColor;
    self.errorLabel.text = self.text;

    [UIView animateWithDuration:0.5 animations:^{
        self.view.frameY = 0;
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                   selector:@selector(dismissError:)
                                   userInfo:nil
                                    repeats:NO];
}


@end
