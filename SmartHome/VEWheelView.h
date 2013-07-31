//
//  VEWheelView.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 26.12.12.
//  Copyright (c) 2012 Institute of Ergonomics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BHViewComputations.h"

@protocol VEWheelViewDelegate;

@interface VEWheelView : UIView 

@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, assign, readonly) float currentFloatingIndex;
@property (nonatomic, assign) NSUInteger numberOfIndexes;
@property (nonatomic, assign) CGSize wheelSize;
@property (nonatomic, assign) float startingAngle;

@property (nonatomic, assign) id<VEWheelViewDelegate> delegate;

- (BOOL)positionIsOnWheel:(CGPoint)position;
- (float)angleOnWheelForPosition:(CGPoint)position;
- (void)finalizeWheelTracking;

- (void)updateNeedleToPosition:(CGPoint)position;
- (void)rotateNeedleWithRotation:(CGFloat)rotation;
- (UIBezierPath *)wheelForChangedFrame;

- (CGFloat)angleForIndex:(float)index;
- (CGPoint)pointOnCircumferenceForAngle:(CGFloat)angle;
@end

@protocol VEWheelViewDelegate <NSObject>

- (void)wheelViewWantsToLayoutSubviews:(VEWheelView *)wheelView;
- (void)wheelViewDidChangeToIndex:(NSInteger)index;

@end