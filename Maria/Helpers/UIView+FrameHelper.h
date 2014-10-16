//
//  UIView+FrameHelper.h
//  Maria
//
//  Created by Juan Escudero on 10/1/14.
//  Copyright (c) 2014 Juan Escudero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameHelper)

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;
@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

@property (nonatomic) CGSize frameSize;
@property (nonatomic) CGPoint frameOrigin;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic, readonly) CGFloat frameMaxX;
@property (nonatomic, readonly) CGFloat frameMaxY;


@end
