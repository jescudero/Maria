//
//  DataManager.h
//  Maria
//
//  Created by Juan Escudero on 10/1/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Armario;

@interface DataManager : NSObject

-(void)createApplicationObjects;

//tipos de luz
-(NSArray *)getTiposDeLuz;

-(void)almacenarArmario:(Armario*)armario;

@end
