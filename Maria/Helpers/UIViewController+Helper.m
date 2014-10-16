//
//  UIViewController+Helper.m
//  Maria
//
//  Created by Juan Escudero on 10/16/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "UIViewController+Helper.h"

@implementation UIViewController (Helper)

-(BOOL)validarText:(UITextField*)field
{
    
    field.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    field.layer.cornerRadius = 5;
    
    if ([field.text isEqualToString:@""])
    {
        field.layer.borderColor=[[UIColor redColor]CGColor];
        field.layer.borderWidth = 0.5;
        return false;
    }
    
    return true;
    
}

@end
