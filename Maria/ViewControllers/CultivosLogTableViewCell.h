//
//  CultivosLogTableViewCell.h
//  Maria
//
//  Created by Juan Escudero on 10/20/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Armario;

@interface CultivosLogTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *armarioLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventosArmarioLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventosPlantaLabel;


-(void)configureView:(Armario*)armario;

@end
