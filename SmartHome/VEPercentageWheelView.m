//
//  VEPercentageWheelView.m
//  VirtualUIElements
//
//  Created by Tom Schelo on 12.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "VEPercentageWheelView.h"

@implementation VEPercentageWheelView

- (void)drawRect:(CGRect)rect
{
	_center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
	
	if (self.bounds.size.height > self.bounds.size.width)
		_radius = self.bounds.size.width/2.0-1.0;
	else _radius = self.bounds.size.height/2.0-1.0;

    // create drawing context
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
    CGContextAddArc(ctx, _center.x, _center.y, _radius, 0.0, M_PI*2.0, YES);
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithWhite:0.9 alpha:1.0] CGColor]);
    CGContextFillPath(ctx);
    
    ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, _center.x, _center.y, _radius, -M_PI/2.0, -M_PI/2.0 + self.valueAngle, 0);
    CGContextAddLineToPoint(ctx, _center.x, _center.y);
    CGContextSetFillColorWithColor(ctx, [[UIColor darkGrayColor] CGColor]);
    CGContextFillPath(ctx);
    
    ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, _center.x, _center.y, _radius/1.5, 0.0, M_PI*2.0, YES);
    CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    CGContextFillPath(ctx);
    
}


@end
