//
//  PlantasLogTableViewCell.h
//  Maria
//
//  Created by Juan Escudero on 10/21/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Planta;

@interface PlantasLogTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UILabel *subtitulo;
@property (weak, nonatomic) IBOutlet UIImageView *foto;


-(void)configureCell:(Planta*)planta;

@end
