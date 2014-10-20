//
//  CultivosLogTableViewCell.m
//  Maria
//
//  Created by Juan Escudero on 10/20/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "CultivosLogTableViewCell.h"
#import "Cultivo.h"
#import "Armario.h"
#import "Planta.h"

@implementation CultivosLogTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureView:(Armario*)armario
{
    self.armarioLabel.text = [NSString stringWithFormat:@"Armario: %@ - Plantas: %d", armario.nombre, armario.plantas.count];
}

@end
