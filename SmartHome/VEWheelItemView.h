//
//  VEWheelItemView.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 25.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BHViewComputations.h"
#import "SHIconWithTitle.h"


typedef enum VEWheelItemHorizontalPosition : NSUInteger {
	VEWheelItemHorizontalPositionCenter,
	VEWheelItemHorizontalPositionLeft,
	VEWheelItemHorizontalPositionRight
} VEWheelItemHorizontalPosition;

typedef enum VEWheelItemVerticalPosition : NSUInteger {
	VEWheelItemVerticalPositionCenter,
	VEWheelItemVerticalPositionUp,
	VEWheelItemVerticalPositionDown
} VEWheelItemVerticalPosition;

@protocol SliderDelegate <NSObject>

- (void)sliderDidMoveTo:(NSInteger)index;

@end

@interface VEWheelItemView : UIView


@property (nonatomic, strong) SHIconWithTitle *icon;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *string;

/*
 * the angle determines how to draw the line and what text alignment to be used for the text
 * angle = PI/2 OR angle = 3PI/2 draw center
 * (angle > 0 AND < PI/2) OR (angle >3PI/2 AND < 2PI draw) left aligned
 * angle > PI/2 AND angle < 3PI/2 draw right aligned
 */
@property (nonatomic, assign) CGFloat angle;

/* 
 * the point that is at on the circumference of the circle
 */
@property (nonatomic, assign) CGPoint startingPoint;

@end
