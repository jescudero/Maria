//
//  CultivoTableViewCell.m
//  Maria
//
//  Created by Juan Escudero on 10/15/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "CultivoTableViewCell.h"
#import "Cultivo.h"
#import "Armario.h"
#import "Planta.h"
#import <QuartzCore/QuartzCore.h>

#import "UIImageHelper.h"

@implementation CultivoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(Cultivo*)cultivo{

    Planta *planta = [((Armario*)[cultivo.armarios allObjects][0]).plantas allObjects][0];
    
    if (planta.foto)
        self.foto.image = [UIImage imageWithData:planta.foto];
    else
    {
        UIImageHelper *helper = [[UIImageHelper alloc]init];
        self.foto.image = [helper getRandomFlowerImage];
    }
    
    self.foto.layer.cornerRadius =  self.foto.frame.size.height /2;
    self.foto.layer.masksToBounds = YES;
    self.foto.layer.borderWidth = 0;
    
    self.cultivoLabel.text = [NSString stringWithFormat:@"Cultivo: %@", cultivo.nombre];
    self.armarioLabel.text = [NSString stringWithFormat:@"Armarios: %d", cultivo.armarios.count];

    
}
@end
