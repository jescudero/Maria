//
//  CultivoTableViewCell.h
//  Maria
//
//  Created by Juan Escudero on 10/15/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cultivo;

@interface CultivoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foto;
@property (weak, nonatomic) IBOutlet UILabel *cultivoLabel;
@property (weak, nonatomic) IBOutlet UILabel *armarioLabel;
@property (weak, nonatomic) IBOutlet UILabel *plantasLabel;

-(void)configureCell:(Cultivo*)cultivo;

@end
