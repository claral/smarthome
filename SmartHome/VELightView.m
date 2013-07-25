//
//  VELightView.m
//  VirtualUIElements
//
//  Created by Tom Schelo on 28.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "VELightView.h"

@implementation VELightView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        _radius = 0.0;
    }
    
    return self;
}

- (void) drawRect:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.size.width/2.0, rect.size.height/2.0);
    _radius *= rect.size.width/2.0;
    
    CGFloat colors [] = {
        255.0, 255.0, 0.0, 1.0,
        255.0, 255.0, 255.0, 0.0
    };
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    CGContextDrawRadialGradient(context, gradient, center, 0.0, center, _radius, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient), gradient = NULL;
    
    CGContextRestoreGState(context);
    
    context = UIGraphicsGetCurrentContext();
    CGRect circleRect = CGRectInset(rect, 15.0, 15.0);
    CGContextAddEllipseInRect(context, circleRect);
    CGContextSetLineWidth(context, 1.0);
    [[UIColor darkGrayColor] setStroke];
    CGContextStrokePath(context);
    
}


@end
