//
//  VEPercentageWheelView.h
//  VirtualUIElements
//
//  Created by Tom Schelo on 12.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VEPercentageWheelView : UIView
{
    NSString *temperature;
    float value;
}

@property (nonatomic) float valueAngle;
@property (nonatomic) CGPoint center;
@property (nonatomic) float radius;

@end
