//
//  TipoLuzSelectorViewController.h
//  Maria
//
//  Created by Juan Escudero on 10/1/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectorProtocol <NSObject>

-(void)cancelSeleccion;
-(void)selectElement:(id)element;

@end

@interface SelectorViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleVC;
@property (nonatomic, strong) id<SelectorProtocol> delegate;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, strong) NSString *property_first;
@property (nonatomic, strong) NSString *property_second;

@end
