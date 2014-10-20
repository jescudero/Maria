//
//  CultivoLogHeaderView.h
//  Maria
//
//  Created by Juan Escudero on 10/20/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Cultivo;

@interface CultivoLogHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *foto;
@property (weak, nonatomic) IBOutlet UILabel *cultivoLabel;

-(void)configureView:(Cultivo*)cultivo;

@end
