//
//  VEStaticHorizontalView.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 23.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface VEStaticHorizontalSliderView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) CAShapeLayer *needleLayer;

- (void)snapNeedleToNearestItem;
@end
