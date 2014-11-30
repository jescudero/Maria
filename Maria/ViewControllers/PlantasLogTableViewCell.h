//
//  PlantasLogTableViewCell.h
//  Maria
//
//  Created by Juan Escudero on 10/21/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Planta;
@class EventoPlanta;

@protocol PlantasLogCellProtocol <NSObject>

-(void)cambioButtonTapped:(Planta*)planta;
-(void)eliminarCambioButtonTapped:(Planta*)planta;

@end

@interface PlantasLogTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tipo;
@property (weak, nonatomic) IBOutlet UILabel *ciclo;
@property (weak, nonatomic) IBOutlet UILabel *genetica;
@property (weak, nonatomic) IBOutlet UIImageView *foto;
@property (weak, nonatomic) IBOutlet UIButton *cambioButton;


@property (nonatomic, strong) id<PlantasLogCellProtocol> delegate;

@property (nonatomic, strong) Planta *planta;

-(void)configureCell:(Planta*)planta conCambios:(BOOL)conCambios eventoPlanta:(EventoPlanta*)eventoPlanta;

@end
