//
//  VEStaticHorizontalView.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 23.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "VEStaticHorizontalSliderView.h"

#define padding 7.0f
#define needleRectPadding 3.0f
#define needleStrength 10.0f

@interface VEStaticHorizontalSliderView ()

@property (nonatomic, assign) UIEdgeInsets itemInsets;
@property (nonatomic, strong) NSArray *itemLayers;

@end

@implementation VEStaticHorizontalSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.itemInsets = UIEdgeInsetsMake(3, 3, 3, 3);
		self.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin |
								 UIViewAutoresizingFlexibleLeftMargin |
								 UIViewAutoresizingFlexibleRightMargin |
								 UIViewAutoresizingFlexibleTopMargin);
    }
    return self;
}


#pragma mark - Overriding Properties

- (void)setItems:(NSArray *)items
{
	if (_items != items)
	{
		_items = items;
		
		[self setupItemLayers];
	}
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
	if (_currentIndex != currentIndex)
	{
		_currentIndex = currentIndex;
		self.needleLayer.position = [self positionOfIndex:_currentIndex];
	}
}

#pragma mark - Setup

- (void)setupItemLayers
{
	for (CALayer *subLayer in [self.layer sublayers])
	{
		[subLayer removeFromSuperlayer];
	}
	
	NSMutableArray *itemLayers;
	itemLayers = [NSMutableArray array];
	

	
	for (int index = 0; index < [self.items count]; index++)
	{
		CALayer *itemLayer;
		itemLayer = [self createItemLayerAtIndex:index];
		[itemLayers addObject:itemLayer];
		[self.layer addSublayer:itemLayer];
	}
	
	self.itemLayers = itemLayers;
	
	CAShapeLayer *needleLayer;
	needleLayer = [self createNeedleLayer];
	needleLayer.position = [self positionOfIndex:self.currentIndex];
	self.needleLayer = needleLayer;
	
	[self.layer addSublayer:needleLayer];
}


#pragma mark - Snapping

- (void)updateCurrentIndex
{
	for (int index = 0; index < [self.itemLayers count]; index++)
	{
		CALayer *itemLayer;
		CGRect extendedItemLayerFrame;
		
		itemLayer = [self.itemLayers objectAtIndex:index];
		extendedItemLayerFrame = CGRectMake(itemLayer.frame.origin.x - self.itemInsets.left,
											itemLayer.frame.origin.y - self.itemInsets.top,
											itemLayer.frame.size.width + self.itemInsets.left + self.itemInsets.right,
											itemLayer.frame.size.height + self.itemInsets.top + self.itemInsets.bottom);
		if (CGRectContainsPoint(extendedItemLayerFrame, self.needleLayer.position) == YES)
		{
			self.currentIndex = index;
			return;
		}
	}
//	NSLog(@"ERROR: could not find a suitable item");
}

- (void)snapNeedleToNearestItem
{
	NSInteger oldIndex;
	oldIndex = self.currentIndex;
	
	[self updateCurrentIndex];
	
	if (self.currentIndex == oldIndex) {
		self.needleLayer.position = [self positionOfIndex:self.currentIndex];
	}
    
    [self.sDelegate sliderDidMoveTo:self.currentIndex];
}

#pragma mark - Helpers


- (CGPoint)positionOfIndex:(NSInteger)index
{
	CALayer *itemLayer;
	itemLayer = [self.itemLayers objectAtIndex:index];
	
	return itemLayer.position;
}

- (CAShapeLayer *)createNeedleLayer
{
	if ([self.itemLayers count] == 0) {
		return [CALayer layer];
	}
	
	CAShapeLayer *needleLayer;
	CGRect itemLayerFrame;
	UIBezierPath *path;
	
	itemLayerFrame = [[self.itemLayers lastObject] frame];

	CGSize needleSize;
	CGPoint topLeft;
	CGPoint topLeftBeforeNeedle;
	CGPoint topCenterNeedle;
	CGPoint topRightAfterNeedle;
	CGPoint topRight;
	CGPoint bottomRight;
	CGPoint bottomLeft;
	
	needleSize = CGSizeMake(itemLayerFrame.size.width - (2 * needleRectPadding),
							itemLayerFrame.size.height - (2 * needleRectPadding));
	topLeft = CGPointMake(needleRectPadding, needleRectPadding);
	topLeftBeforeNeedle = CGPointMake(topLeft.x + needleSize.width * 0.5f - needleStrength,
									  topLeft.y);
	topCenterNeedle = CGPointMake(topLeftBeforeNeedle.x + needleStrength,
								  topLeftBeforeNeedle.y + needleStrength);
	topRightAfterNeedle = CGPointMake(topCenterNeedle.x + needleStrength,
									  topCenterNeedle.y - needleStrength);
	topRight = CGPointMake(topLeft.x + needleSize.width,
						   topLeft.y);
	bottomRight = CGPointMake(topRight.x,
							  topRight.y + needleSize.height+50.0f); // Kasten tiefe verstellt mit +50!!!!!
	bottomLeft = CGPointMake(topLeft.x,
							 bottomRight.y);
	
	path = [UIBezierPath bezierPath];
	
	[path moveToPoint:topLeft];
	[path addLineToPoint:topLeftBeforeNeedle];
	[path addLineToPoint:topCenterNeedle];
	[path addLineToPoint:topRightAfterNeedle];
	[path addLineToPoint:topRight];
	[path addLineToPoint:bottomRight];
	[path addLineToPoint:bottomLeft];
	[path closePath];
	
	needleLayer = [CAShapeLayer layer];
	needleLayer.frame = itemLayerFrame;
	needleLayer.path = [path CGPath];
	needleLayer.backgroundColor = [[UIColor clearColor] CGColor];
	needleLayer.strokeColor = [[UIColor darkGrayColor] CGColor];
	needleLayer.fillColor = [[UIColor clearColor] CGColor];
	needleLayer.lineWidth = 5.0f;
	needleLayer.shadowOpacity = 0.8f;
	needleLayer.shadowOffset = CGSizeMake(0, 1.0f);
	needleLayer.shadowRadius = 2.0f;
	needleLayer.shouldRasterize = YES;
	
	return needleLayer;
}

- (CALayer *)createItemLayerAtIndex:(NSInteger)index
{
	CALayer *itemLayer;
	CATextLayer *titleLayer;
	CALayer *imageLayer;
	CGFloat titleHeight;
	SHIconWithTitle *icon;
    
	icon = [self.items objectAtIndex:index];
	itemLayer = [CALayer layer];
	
	itemLayer.frame = [self frameForItemAtIndex:index];
	
	titleLayer = [CATextLayer layer];
	
	titleHeight = 30.0f; //20.0f Platz fuer Schrift
	titleLayer.frame = CGRectMake(padding,
								  itemLayer.frame.size.height - titleHeight - padding + 40.0f,
								  itemLayer.frame.size.width - 2 * padding,
								  titleHeight); //33 Abstand zum Bild
	[titleLayer setContentsScale:[[UIScreen mainScreen] scale]];
	[titleLayer setFont:@"Helvetica"];
	
    [titleLayer setString:icon.title];
	[titleLayer setFontSize:18.0f]; //8.0f Schriftgroesse
	[titleLayer setAlignmentMode:kCAAlignmentCenter];
	[titleLayer setForegroundColor:[[UIColor blackColor] CGColor]];
	
	imageLayer = [CALayer layer];
	UIImage *croppedImageToFit = icon.icon;
    
    
    imageLayer.contentsScale = [[UIScreen mainScreen] scale];

	imageLayer.frame = CGRectMake(0.5 * itemLayer.frame.size.width - 0.5 * croppedImageToFit.size.width,
								  0.5 * itemLayer.frame.size.height - 0.5 * croppedImageToFit.size.height,
								  croppedImageToFit.size.width,
								  croppedImageToFit.size.height);

	imageLayer.contents = (__bridge id)([croppedImageToFit CGImage]);
	
	[itemLayer addSublayer:titleLayer];
	[itemLayer addSublayer:imageLayer];
//	itemLayer.backgroundColor = [[UIColor cyanColor] CGColor];
	return itemLayer;
}

- (CGRect)frameForItemAtIndex:(NSInteger)index
{
	CGFloat xOrigin;
	CGFloat itemWidth;
	
	itemWidth = [self itemWidth];
	xOrigin = (index * itemWidth) + self.itemInsets.left;

	return CGRectMake(xOrigin,
					  self.itemInsets.top,
					  itemWidth - self.itemInsets.left - self.itemInsets.right,
					  self.frame.size.height - self.itemInsets.top - self.itemInsets.bottom);
}

- (CGFloat) itemWidth
{
	if ([self.items count] < 1) {
		return 0;
	}
	
//	return self.frame.size.width / [self.items count]*1.25f; //item groesser
    return self.frame.size.width / [self.items count]*0.80; //item groesser

}

@end
