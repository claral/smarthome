//
//  VEWheelView.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 26.12.12.
//  Copyright (c) 2012 Institute of Ergonomics. All rights reserved.
//

#import "VEWheelView.h"

#define kNeedleStrength 25.0f

@interface VEWheelView ()

@property (nonatomic, strong) CAShapeLayer *wheelLayer;
@property (nonatomic, strong) CAShapeLayer *needleLayer;

@property (nonatomic, assign) float currentFloatingIndex;

@end

@implementation VEWheelView

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (void)sharedInit
{
	self.autoresizingMask = (UIViewAutoresizingFlexibleHeight |
							 UIViewAutoresizingFlexibleWidth);
	
	[self setBackgroundColor:[UIColor clearColor]];
	
	self.wheelSize = CGSizeMake(300, 300);
	
	self.wheelLayer = [CAShapeLayer layer];
	self.wheelLayer.strokeColor = [[UIColor blackColor] CGColor];
	self.wheelLayer.lineWidth = 1.5f;
	self.wheelLayer.fillColor = [[UIColor colorWithWhite:0.85 alpha:1.000] CGColor];
	self.wheelLayer.path = [[self wheelForChangedFrame] CGPath];
	
	self.wheelLayer.shadowPath = self.wheelLayer.path;
	self.wheelLayer.shadowColor = [[UIColor blackColor] CGColor];
	self.wheelLayer.shadowOffset = CGSizeMake(0, 0.0f);
	self.wheelLayer.shadowRadius = 3.0f;
	self.wheelLayer.shadowOpacity = 1.0f;
	self.wheelLayer.masksToBounds = NO;
	
	self.needleLayer = [CAShapeLayer layer];
	self.needleLayer.strokeColor = [[UIColor blackColor] CGColor];
	self.needleLayer.lineWidth = 1.5f;
	self.needleLayer.fillColor = [[UIColor redColor] CGColor];
	self.needleLayer.path = [[self needlePathForChangedFrame] CGPath];

	[self.wheelLayer addSublayer:self.needleLayer];
	[self.layer addSublayer:self.wheelLayer];
}


- (void)dealloc
{

}

#pragma mark - Wheel Path

- (UIBezierPath *)needlePathForChangedFrame
{
	//ausgehend vom centerLeft bzw. centerRight im Lot hoch bzw runter gehen
	UIBezierPath *needlePath;
	CGFloat halfNeedleHeight;
	CGFloat needleArc;
	
	CGPoint topLeft;
	CGPoint topRight;
	CGPoint bottomRight;
	CGPoint bottomLeft;
	
	CGPoint topLeftBeforeArc;
	CGPoint topLeftAfterArc;
	CGPoint topRightBeforeArc;
	CGPoint topRightAfterArc;
	CGPoint bottomRightBeforeArc;
	CGPoint bottomRightAfterArc;
	CGPoint bottomLeftBeforeArc;
	CGPoint bottomLeftAfterArc;
	
	halfNeedleHeight = 4.0f;
	needleArc = 2.0f;
	
	CGFloat rightDelta;
	CGFloat leftDelta;
	CGFloat rightDeltaMinusArc;
	CGFloat leftDeltaPlusArc;
	
	rightDelta = 0.1f * kNeedleStrength;
	leftDelta = -0.9f * kNeedleStrength;
	
	rightDeltaMinusArc = rightDelta - needleArc;
	leftDeltaPlusArc = leftDelta + needleArc;
	
	
	topRightBeforeArc = CGPointOnLine([self needlePointWithDelta:rightDeltaMinusArc],
									  M_PI_2,
									  -halfNeedleHeight);
	
	topRight = CGPointOnLine([self needlePointWithDelta:rightDelta],
							 M_PI_2,
							 -halfNeedleHeight);
	
	topRightAfterArc = CGPointOnLine([self needlePointWithDelta:rightDelta],
									 M_PI_2,
									 -halfNeedleHeight + needleArc);
	
	
	
	bottomRightBeforeArc = CGPointOnLine([self needlePointWithDelta:rightDelta],
										 M_PI_2,
										 halfNeedleHeight - needleArc);
	
	bottomRight = CGPointOnLine([self needlePointWithDelta:rightDelta],
								M_PI_2,
								halfNeedleHeight);
	
	bottomRightAfterArc = CGPointOnLine([self needlePointWithDelta:rightDeltaMinusArc],
										M_PI_2,
										halfNeedleHeight);
	
	
	bottomLeftBeforeArc = CGPointOnLine([self needlePointWithDelta:leftDeltaPlusArc],
										M_PI_2,
										halfNeedleHeight);
	
	bottomLeft = CGPointOnLine([self needlePointWithDelta:leftDelta],
							   M_PI_2,
							   halfNeedleHeight);
	
	bottomLeftAfterArc = CGPointOnLine([self needlePointWithDelta:leftDelta],
									   M_PI_2,
									   halfNeedleHeight - needleArc);
	
	
	topLeftBeforeArc = CGPointOnLine([self needlePointWithDelta:leftDelta],
									 M_PI_2,
									 -halfNeedleHeight + needleArc);
	
	topLeft = CGPointOnLine([self needlePointWithDelta:leftDelta],
							M_PI_2,
							-halfNeedleHeight);
	
	topLeftAfterArc = CGPointOnLine([self needlePointWithDelta:leftDeltaPlusArc],
									M_PI_2,
									-halfNeedleHeight);
	
	
	needlePath = [UIBezierPath bezierPath];
	[needlePath moveToPoint:topRightBeforeArc];
	[needlePath addCurveToPoint:topRightAfterArc
				  controlPoint1:topRight
				  controlPoint2:topRight];
	
	[needlePath addLineToPoint:bottomRightBeforeArc];
	[needlePath addCurveToPoint:bottomRightAfterArc
				  controlPoint1:bottomRight
				  controlPoint2:bottomRight];
	
	[needlePath addLineToPoint:bottomLeftBeforeArc];
	[needlePath addCurveToPoint:bottomLeftAfterArc
				  controlPoint1:bottomLeft
				  controlPoint2:bottomLeft];
	
	[needlePath addLineToPoint:topLeftBeforeArc];
	[needlePath addCurveToPoint:topLeftAfterArc
				  controlPoint1:topLeft
				  controlPoint2:topLeft];
	
	[needlePath closePath];

	[needlePath setLineWidth:1.5f];
	
	return needlePath;
}


- (CGPoint)needlePointWithDelta:(CGFloat)delta
{
	CGPoint currentIndexCenter;
	CGFloat currentAngle;
	
	currentAngle = [self currentAngle];
	currentIndexCenter = [self pointOnCircumferenceForAngle:currentAngle];

	return CGPointOnLine(currentIndexCenter,
						 currentAngle,
						 delta);
}


- (UIBezierPath *)wheelForChangedFrame
{
	UIBezierPath *wheel;
	CGRect ovalRect;
	ovalRect = [self ovalRect];
	wheel = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
	[wheel setLineWidth:1.5f];
	
	return wheel;
}

- (void)updateUIElements
{
	self.wheelLayer.path = [[self wheelForChangedFrame] CGPath];
	self.wheelLayer.shadowPath = self.wheelLayer.path;
	self.needleLayer.path = [[self needlePathForChangedFrame] CGPath];
}

#pragma mark - Helper

- (CGPoint)ovalCenter
{
	CGRect oval;
	
	oval = [self ovalRect];
	return CGPointMake(oval.origin.x + 0.5f * oval.size.width,
					   oval.origin.y + 0.5f * oval.size.height);
}

- (CGRect)ovalRect
{
	return CGRectMake(self.frame.origin.x + self.frame.size.width * 0.5f - self.wheelSize.width * 0.5f,
					  self.frame.origin.y + self.frame.size.height * 0.5f - self.wheelSize.height * 0.5f,
					  self.wheelSize.width,
					  self.wheelSize.height);
}

- (CGFloat)radius
{
	return self.wheelSize.width * 0.5f;
}

- (CGFloat)currentAngle
{
	return [self angleForIndex:(float)self.currentFloatingIndex];
}

- (CGFloat)angleForIndex:(float)index
{
	CGFloat anglePerIndex;
	CGFloat angle;
	
	anglePerIndex = 2 * M_PI / (float)self.numberOfIndexes;
	angle = anglePerIndex * (float)(index);
	return angle;
}


- (CGPoint)pointOnCircumferenceForAngle:(CGFloat)angle
{
	CGPoint ovalCenter;
	
	ovalCenter = [self ovalCenter];
	
	return CGPointMake(ovalCenter.x + [self radius] * cosf(angle),
					   ovalCenter.y + [self radius] * sinf(angle));
}

#pragma mark - Overriding properties

- (void)setCurrentIndex:(NSUInteger)currentIndex
{
	if (_currentIndex != currentIndex)
	{
		if (currentIndex >= self.numberOfIndexes) {
			currentIndex = 0;
		}
		
		if ((NSInteger)currentIndex < 0) {
			currentIndex = self.numberOfIndexes - 1;
		}
		
		_currentIndex = currentIndex;
	}
	
	CATransform3D oldRotation;
	CATransform3D rotation;
	float newAngle;
	
	newAngle = [self angleForIndex:currentIndex];
	oldRotation = self.layer.transform;
	rotation = CATransform3DMakeRotation(newAngle, 0.0, 0.0, 1.0);
	
	[self.layer setTransform:rotation];
	
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.fromValue = [NSValue valueWithCATransform3D:oldRotation];
	animation.toValue = [NSValue valueWithCATransform3D:rotation];
	animation.delegate = self;
	
	[self.layer addAnimation:animation forKey:@"transform"];
	
	_currentFloatingIndex = (float)currentIndex;
}

- (void)setCurrentFloatingIndex:(float)currentFloatingIndex
{
	if (_currentFloatingIndex != currentFloatingIndex)
	{
		if (currentFloatingIndex >= self.numberOfIndexes) {
			currentFloatingIndex = (float)self.numberOfIndexes - currentFloatingIndex;
		}
		else if (currentFloatingIndex < 0) {
			currentFloatingIndex = (float)self.numberOfIndexes + currentFloatingIndex;
		}
		
		_currentFloatingIndex = currentFloatingIndex;
	}
}

#pragma mark - Rotating Wheel

- (void)updateNeedleToPosition:(CGPoint)position
{
	float newAngle;
	float diff;
	
	newAngle = [self angleOnWheelForPosition:position];
	diff = newAngle - self.startingAngle;
	
	[self rotateNeedleWithRotation:diff];
}

- (void)rotateNeedleWithRotation:(CGFloat)rotation
{
	CATransform3D oldTransform;
	float currentAngleAbsolute;
	
	oldTransform = self.layer.transform;
	[self.layer setTransform:CATransform3DRotate(oldTransform, rotation, 0, 0, 1.0)];
	currentAngleAbsolute = [self angleOfLayerTransform];
	
	self.currentFloatingIndex = currentAngleAbsolute / (2 * M_PI) * self.numberOfIndexes;
}

- (float) angleOnWheelForPosition:(CGPoint)position
{
	float x1; //Schnittpkt x1
	float y1; //Schnittpkt y1
	float t;
	float angle;
	CGPoint center;
	CGPoint positionOnCircumference;
	
	center = [self ovalCenter];
	
	t = [self radius] / sqrtf(powf((position.x - center.x), 2) + powf((position.y - center.y), 2));
	x1 = center.x + t * (position.x  - center.x);
	y1 = center.y + t * (position.y  - center.y);
	positionOnCircumference = CGPointMake(x1, y1);

	angle = atan2f(positionOnCircumference.y - center.y,
				   positionOnCircumference.x - center.x);
	return angle;
}

- (BOOL)positionIsOnWheel:(CGPoint)position
{
	CGAffineTransform transf = CGAffineTransformMakeTranslation(-self.wheelLayer.position.x,
																-self.wheelLayer.position.y);
	
	return CGPathContainsPoint(self.wheelLayer.path,
							   &transf,
							   position,
							   NO);
}

- (float)angleOfLayerTransform
{
	float currentAngleAbsolute;
	currentAngleAbsolute = atan2f(self.layer.transform.m12, self.layer.transform.m11);
	
	if (currentAngleAbsolute < 0) {
		currentAngleAbsolute = (2 * M_PI) + currentAngleAbsolute;
	}

	return currentAngleAbsolute;
}

- (void)finalizeWheelTracking
{
	self.startingAngle = MAXFLOAT;
	self.currentIndex = roundf(self.currentFloatingIndex);
}


#pragma mark - Layout Subviews


- (void)layoutSubviews
{
	[super layoutSubviews];
	
	[self updateUIElements];
	
	if ([self.delegate respondsToSelector:@selector(wheelViewWantsToLayoutSubviews:)]) {
		[self.delegate wheelViewWantsToLayoutSubviews:self];
	}
}

@end
