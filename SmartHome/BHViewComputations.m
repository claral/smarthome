//
//  BHViewComputations.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 25.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "BHViewComputations.h"

@implementation BHViewComputations

CGPoint CGPointOnLine(CGPoint startingPoint, CGFloat angle, CGFloat delta)
{
	CGFloat deltaX;
	CGFloat deltaY;
	
	deltaX = delta * cosf(angle);
	deltaY = delta * -sinf(angle);
	
	return  CGPointMake(startingPoint.x + deltaX,
						startingPoint.y + deltaY);
}

@end
