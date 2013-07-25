//
//  VEWheelItemView.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 25.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "VEWheelItemView.h"

#define kLineLength 15
#define kQuadrantPadding 0.01
#define kStringDrawingPadding 4.0f

@interface VEWheelItemView ()

@property (nonatomic, assign) VEWheelItemHorizontalPosition horizontalPosition;
@property (nonatomic, assign) VEWheelItemVerticalPosition verticalPosition;
@property (nonatomic, assign) CGSize imageSize;

@end

@implementation VEWheelItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask =	(UIViewAutoresizingFlexibleBottomMargin |
								 UIViewAutoresizingFlexibleLeftMargin |
								 UIViewAutoresizingFlexibleRightMargin |
								 UIViewAutoresizingFlexibleTopMargin);
		self.imageSize = CGSizeMake(50 , 50);
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGContextRef c;
	CGPoint lineStartPoint;
	CGPoint lineEndPoint;
	CGRect stringBoundinBox;
	CGRect imageRect;
	CGPoint imageStartingPoint;
	CGPoint stringStartingPoint;
	CGSize stringSize;
	CGSize contentSize;
	UIFont *font;
	
	font = [UIFont systemFontOfSize:15.0f];
	stringSize = [self.string sizeWithFont:font];
	contentSize = stringSize;
	
	lineStartPoint = [self lineStartPoint];
	lineEndPoint = CGPointOnLine(lineStartPoint,
								 -self.angle,
								 kLineLength);
	
	imageStartingPoint = [self imageStartingPointForLineEndPoint:lineEndPoint
													  stringSize:stringSize];
	
	
	imageRect = CGRectMake(imageStartingPoint.x,
						   imageStartingPoint.y,
						   self.imageSize.width,
						   self.imageSize.height);
	
	stringStartingPoint = [self stringStartingPointForStringSize:stringSize
													lineEndPoint:lineEndPoint];
	
	contentSize.width += imageRect.size.width;
	contentSize.height = self.imageSize.height;
	
	stringBoundinBox = [self stringRectForLineEndPoint:lineEndPoint
										 sizeOfContent:contentSize];
	
	

	c = UIGraphicsGetCurrentContext();
	
	CGFloat gray[4] = {0.85f, 0.85f, 0.85f, 1.0f};
	CGFloat black[4] = {0.0f, 0.0f, 0.0f, 1.0f};
	
	CGContextSaveGState(c);
    CGContextSetFillColor(c, gray);
	CGContextSetShadowWithColor(c, CGSizeMake(0, 0), 2.0f, [[UIColor blackColor] CGColor]);
	
	CGContextFillRect(c, stringBoundinBox);
	CGContextStrokeRect(c, stringBoundinBox);
	
	
    CGContextSetStrokeColor(c, black);
	CGContextSetLineWidth(c, 1.5f);
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, lineStartPoint.x, lineStartPoint.y);
    CGContextAddLineToPoint(c, lineEndPoint.x, lineEndPoint.y);
    CGContextStrokePath(c);
	
	CGContextRestoreGState(c);
	
	UIImage *imageToBeDrawn;
	UIGraphicsBeginImageContextWithOptions(self.imageSize, NO, [UIScreen mainScreen].scale);
	
	[self.image drawInRect:CGRectMake(0, 0, self.imageSize.width, self.imageSize.height)];
	imageToBeDrawn = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	[imageToBeDrawn drawInRect:imageRect];
		
	[self.string drawAtPoint:stringStartingPoint
					forWidth:self.bounds.size.width
					withFont:font
					fontSize:font.pointSize
			   lineBreakMode:NSLineBreakByTruncatingTail
		  baselineAdjustment:UIBaselineAdjustmentAlignCenters];

	
	//	[[NSString stringWithFormat:@"%f",self.angle] drawAtPoint:CGPointZero
	//													 forWidth:self.frame.size.width
	//													 withFont:[UIFont systemFontOfSize:9.0f]
	//													 fontSize:9.0f
	//												lineBreakMode:NSLineBreakByTruncatingMiddle
	//										   baselineAdjustment:UIBaselineAdjustmentAlignCenters];
}

- (CGPoint)stringStartingPointForStringSize:(CGSize)stringSize
							   lineEndPoint:(CGPoint)lineEndPoint
{
	CGPoint stringStartingPoint;
	
	switch (self.horizontalPosition)
	{
		case VEWheelItemHorizontalPositionCenter:
			stringStartingPoint.x = lineEndPoint.x - stringSize.width * 0.5f + self.imageSize.width * 0.5f + kStringDrawingPadding;
			break;
			
		case VEWheelItemHorizontalPositionLeft:
			stringStartingPoint.x = lineEndPoint.x - stringSize.width - self.imageSize.width - kStringDrawingPadding * 2;
			break;
			
		case VEWheelItemHorizontalPositionRight:
			stringStartingPoint.x = lineEndPoint.x + kStringDrawingPadding * 2 + self.imageSize.width;
			break;
			
		default:
			break;
	}
	
	switch (self.verticalPosition)
	{
		case VEWheelItemVerticalPositionCenter:
			stringStartingPoint.y = lineEndPoint.y - stringSize.height * 0.5f;
			break;
			
		case VEWheelItemVerticalPositionUp:
			stringStartingPoint.y = lineEndPoint.y - self.imageSize.height * 0.5f - stringSize.height * 0.5f - kStringDrawingPadding;
			break;
			
		case VEWheelItemVerticalPositionDown:
			stringStartingPoint.y = lineEndPoint.y + self.imageSize.height * 0.5 + kStringDrawingPadding - 0.5 * stringSize.height;
			break;
			
		default:
			break;
	}
	
	return stringStartingPoint;
}

- (CGPoint)imageStartingPointForLineEndPoint:(CGPoint)lineEndPoint
								  stringSize:(CGSize)stringSize
{
	CGPoint stringStartingPoint;
	
	switch (self.horizontalPosition)
	{
		case VEWheelItemHorizontalPositionCenter:
			stringStartingPoint.x = lineEndPoint.x - 0.5f * (self.imageSize.width + stringSize.width);
			break;
			
		case VEWheelItemHorizontalPositionLeft:
			stringStartingPoint.x = lineEndPoint.x - self.imageSize.width - kStringDrawingPadding;
			break;
			
		case VEWheelItemHorizontalPositionRight:
			stringStartingPoint.x = lineEndPoint.x + kStringDrawingPadding;
			break;
			
		default:
			break;
	}
	
	switch (self.verticalPosition)
	{
		case VEWheelItemVerticalPositionCenter:
			stringStartingPoint.y = lineEndPoint.y - self.imageSize.height * 0.5f;
			break;
			
		case VEWheelItemVerticalPositionUp:
			stringStartingPoint.y = lineEndPoint.y - self.imageSize.height - kStringDrawingPadding;
			break;
			
		case VEWheelItemVerticalPositionDown:
			stringStartingPoint.y = lineEndPoint.y + kStringDrawingPadding;
			break;
			
		default:
			break;
	}
	
	return stringStartingPoint;
}

- (CGRect)stringRectForLineEndPoint:(CGPoint)start
					  sizeOfContent:(CGSize)contentSize
{
	CGFloat xPosition;
	CGFloat yPosition;
	
	switch (self.horizontalPosition)
	{
		case VEWheelItemHorizontalPositionCenter:
			xPosition = start.x - 0.5 * contentSize.width - kStringDrawingPadding * 2;
			break;
			
		case VEWheelItemHorizontalPositionLeft:
			xPosition = start.x - contentSize.width - kStringDrawingPadding * 4;
			break;
			
		case VEWheelItemHorizontalPositionRight:
			xPosition = start.x;
			break;
			
		default:
			break;
	}
	
	switch (self.verticalPosition)
	{
		case VEWheelItemVerticalPositionCenter:
			yPosition = start.y - contentSize.height * 0.5 - kStringDrawingPadding;
			break;
			
		case VEWheelItemVerticalPositionUp:
			yPosition = start.y - contentSize.height - kStringDrawingPadding * 2;
			break;
			
		case VEWheelItemVerticalPositionDown:
			yPosition = start.y;
			break;
			
		default:
			break;
	}
	
	return CGRectMake(xPosition,
					  yPosition,
					  contentSize.width + kStringDrawingPadding * 4,
					  contentSize.height + kStringDrawingPadding * 2);
}

- (void)setStartingPoint:(CGPoint)startingPoint
{
	if (CGPointEqualToPoint(_startingPoint, startingPoint) == NO)
	{
		_startingPoint = startingPoint;
		
		[self updateFrame];
	}
}


- (CGPoint)lineStartPoint
{
	CGFloat xPosition;
	CGFloat yPosition;
	
	switch (self.horizontalPosition)
	{
		case VEWheelItemHorizontalPositionCenter:
			xPosition = self.frame.size.width * 0.5f;
			break;
			
		case VEWheelItemHorizontalPositionLeft:
			xPosition = self.frame.size.width;
			break;
			
		case VEWheelItemHorizontalPositionRight:
			xPosition = 0.0f;
			break;
			
		default:
			break;
	}
	
	switch (self.verticalPosition)
	{
		case VEWheelItemVerticalPositionCenter:
			yPosition = self.frame.size.height * 0.5f;
			break;
			
		case VEWheelItemVerticalPositionUp:
			yPosition = self.frame.size.height;
			break;
			
		case VEWheelItemVerticalPositionDown:
			yPosition = 0.0f;
			break;
			
		default:
			break;
	}
	
	return CGPointMake(xPosition, yPosition);
}

//We set the frame according to startingPoint and angle
- (void) updateFrame
{
	//	NSLog(@"%f", self.angle);
	CGRect newFrame;
	newFrame = self.frame;
	
	self.verticalPosition = [self updateVerticalPosition];
	self.horizontalPosition = [self updateHorizontalPosition];
	
	
	switch (self.horizontalPosition)
	{
		case VEWheelItemHorizontalPositionCenter:
			newFrame.origin.x = self.startingPoint.x - 0.5 * newFrame.size.width;
			break;
			
		case VEWheelItemHorizontalPositionLeft:
			newFrame.origin.x = self.startingPoint.x - newFrame.size.width;
			break;
			
		case VEWheelItemHorizontalPositionRight:
			newFrame.origin.x = self.startingPoint.x;
			break;
			
		default:
			break;
	}
	
	switch (self.verticalPosition)
	{
		case VEWheelItemVerticalPositionUp:
			newFrame.origin.y = self.startingPoint.y - newFrame.size.height;
			break;
			
		case VEWheelItemVerticalPositionDown:
			newFrame.origin.y = self.startingPoint.y;
			break;
			
		case VEWheelItemVerticalPositionCenter:
			newFrame.origin.y = self.startingPoint.y - 0.5 * newFrame.size.height;
			break;
			
		default:
			break;
	}
	
	self.frame = newFrame;
	[self setNeedsDisplay];
}


- (VEWheelItemVerticalPosition) updateVerticalPosition
{
	//up
	if (self.angle > M_PI + kQuadrantPadding &&
		self.angle < 2 * M_PI - kQuadrantPadding)
	{
		return VEWheelItemVerticalPositionUp;
	}
	//down
	if (self.angle > 0 + kQuadrantPadding &&
		self.angle < M_PI - kQuadrantPadding)
	{
		return VEWheelItemVerticalPositionDown;
	}
	
	return VEWheelItemVerticalPositionCenter;
}

- (VEWheelItemHorizontalPosition) updateHorizontalPosition
{
	//right
	if (self.angle > (3 * M_PI_2 + kQuadrantPadding) ||
		self.angle < (M_PI_2 - kQuadrantPadding))
	{
		return VEWheelItemHorizontalPositionRight;
	}
	//left
	if (self.angle > M_PI_2 + kQuadrantPadding &&
		self.angle < 3 * M_PI_2 - kQuadrantPadding)
	{
		return VEWheelItemHorizontalPositionLeft;
	}
	//center
	return VEWheelItemHorizontalPositionCenter;
	
}

- (NSTextAlignment)aligmentForPosition
{
	switch (self.horizontalPosition)
	{
		case VEWheelItemHorizontalPositionCenter:
			return NSTextAlignmentCenter;
			break;
			
		case VEWheelItemHorizontalPositionLeft:
			return NSTextAlignmentRight;
			break;
			
		case VEWheelItemHorizontalPositionRight:
			return NSTextAlignmentLeft;
			break;
			
		default:
			break;
	}
	
}

#pragma mark - Overriding Properties

- (void)setIcon:(SHIconWithTitle *)icon
{
	if (_icon != icon)
	{
		_icon = icon;
		
		self.string = icon.title;
		self.image = icon.icon;
		self.imageSize = self.image.size;
	}
}

@end
