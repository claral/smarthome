//
//  VETabNHoldView.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 16.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "VETapNHoldView.h"

@interface VETapNHoldView ()

@end

@implementation VETapNHoldView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		[self sharedInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
	{
		[self sharedInit];
    }
    return self;
}

- (void)sharedInit
{
	self.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin |
							 UIViewAutoresizingFlexibleLeftMargin |
							 UIViewAutoresizingFlexibleRightMargin |
							 UIViewAutoresizingFlexibleTopMargin);
	self.button = [VERoundedButton layer];
	self.button.frame = self.bounds;
	[self.layer addSublayer:self.button];
}


//- (void)layoutSubviews
//{
//	[super layoutSubviews];
//	
//	CGFloat smallerSideSize;
//	
//	if (self.bounds.size.width > self.bounds.size.height) {
//		smallerSideSize = self.bounds.size.height;
//	}
//	else {
//		smallerSideSize = self.bounds.size.width;
//	}
//	
//	self.button.frame = CGRectMake(self.bounds.origin.x,
//								   self.bounds.origin.y,
//								   smallerSideSize,
//								   smallerSideSize);
//}

@end
