//
//  VERoundedButton.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 22.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "VERoundedButton.h"
#import "VEIFTapNHoldViewController.h"

@implementation VERoundedButton

+ (id)layer
{
	VERoundedButton* button = [[VERoundedButton alloc] init];
	
	button.drawBackgroundGradient = YES;
	
	return button;
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
	[self prepareLayers];
}

- (void)prepareLayers
{
	[self.backgroundLayer removeFromSuperlayer];
	[self.imageLayer removeFromSuperlayer];
	[self.titleLayer removeFromSuperlayer];
	
	NSArray *backgroundColors;
	
	if (self.drawBackgroundGradient == YES) {
		backgroundColors = [self standardBackgroundColors];
	}
	else {
		backgroundColors = [NSArray arrayWithObjects:
							(id)[[UIColor colorWithWhite:0.85 alpha:1.0f] CGColor],
							[[UIColor colorWithWhite:0.85 alpha:1.0f] CGColor],
							nil];
	}
	
	self.backgroundLayer = [CAGradientLayer layer];
	self.backgroundLayer.frame = self.bounds;
	self.backgroundLayer.cornerRadius = self.bounds.size.width * 0.5f;
	self.backgroundLayer.colors = backgroundColors;
	self.backgroundLayer.borderColor = [[UIColor darkGrayColor] CGColor];
	self.backgroundLayer.borderWidth = 1.0f;
	
	
	self.imageLayer = [CALayer layer];
	self.imageLayer.frame = CGRectMake(self.frame.size.width * 0.1f,
									   self.frame.size.height*0.1f,
									   self.frame.size.width*0.8f,
									   self.frame.size.height*0.8f);
    //images in button aligned
//    self.frame.size.width * 0.25f,
//    self.frame.size.height * 0.2f,
//    self.frame.size.width * 0.5f,
//    self.frame.size.height * 0.5f);
    
	[self.imageLayer setContentsScale:[[UIScreen mainScreen] scale]];
	
	self.titleLayer = [CATextLayer layer];
	self.titleLayer.frame = CGRectMake(0,
									   self.frame.size.height * 0.50f,
									   self.frame.size.width,
									   self.frame.size.height * 3.2f);
//    (0,
//     self.frame.size.height * 0.70f,
//     self.frame.size.width,
//     self.frame.size.height * 0.16f);
	
	CGFloat calculatedLayerFontSize = 30.0f;
	[self.titleLayer setFont:@"Helvetica"];
	[self.titleLayer setString:@"Kochstufe"];
    
	[self.titleLayer setFontSize:calculatedLayerFontSize];
	[self.titleLayer setContentsScale:[[UIScreen mainScreen] scale]];
	
	[self.titleLayer setAlignmentMode:kCAAlignmentCenter];
	[self.titleLayer setForegroundColor:[[UIColor blackColor] CGColor]];

//	[self.titleLayer setShadowOpacity:0.7f];
//	[self.titleLayer setShadowOffset:CGSizeMake(0, 1)];
//	
	[self addSublayer:self.backgroundLayer];
	[self addSublayer:self.imageLayer];
	[self addSublayer:self.titleLayer];
}

- (void)setHighlighted:(BOOL)highlighted
{
	if (_highlighted != highlighted)
	{
		_highlighted = highlighted;
		
		if (_highlighted == YES) {
			self.backgroundLayer.colors = [self highlightedBackgroundColors];
		}
		else {
			self.backgroundLayer.colors = [self standardBackgroundColors];
		}
	}
}


- (void)setPressed:(BOOL)pressed
{
	if (_pressed != pressed)
	{
		_pressed = pressed;
		
		if (_pressed == YES) {
			self.backgroundLayer.colors = [self pressedBackgroundColors];
		}
		else {
			self.backgroundLayer.colors = [self standardBackgroundColors];
		}
	}
}
#pragma mark - Helpers


- (NSArray *)standardBackgroundColors
{
	return [NSArray arrayWithObjects:
			(id)[[UIColor whiteColor] CGColor],
			[[UIColor grayColor] CGColor],
			nil];
}

- (NSArray *)highlightedBackgroundColors
{
	return [NSArray arrayWithObjects:
			(id)[[UIColor darkGrayColor] CGColor],
			[[UIColor blackColor] CGColor],
			nil];
}

- (NSArray *)pressedBackgroundColors
{
	return [NSArray arrayWithObjects:
			(id)[[UIColor lightGrayColor] CGColor],
			[[UIColor darkGrayColor] CGColor],
			nil];
}

@end
