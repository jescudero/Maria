//
//  UIImageHelper.m
//  Maria
//
//  Created by Juan Escudero on 10/23/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import "UIImageHelper.h"

@implementation UIImageHelper

-(NSArray*)getFlowersImages
{
    NSArray *images = [NSArray arrayWithObjects:@"flor1", @"flor2", @"flor3", @"flor4", @"flor5", @"flor6", nil];
    
    return images;
}


-(UIImage*)getRandomFlowerImage
{
    NSArray *images = [self getFlowersImages];
    
    int index = arc4random_uniform(images.count);
    
    UIImage *image = [UIImage imageNamed:images[index]];
    
    return image;
}

@end
