//
//  LogTableViewCell.h
//  Maria
//
//  Created by Juan Escudero on 11/30/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventoArmario, EventoPlanta;

@interface LogTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fechaLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

-(void)configureCellEventoArmario:(EventoArmario*)eventoArmario;
-(void)configureCellEventoPlanta:(EventoPlanta*)eventoPlanta;

@end
