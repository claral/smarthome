//
//  SVSegmentedThumb.h
//  TestSwitch
//
//  Created by Lisa Hüfner on 21.06.13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVSegmentedThumb : UIView

@property (nonatomic, strong) UIImage *backgroundImage; // default is nil;
@property (nonatomic, strong) UIImage *highlightedBackgroundImage; // default is nil;

@property (nonatomic, strong) UIColor *tintColor; // default is [UIColor grayColor]
@property (nonatomic, strong) UIColor *textColor; // default is [UIColor whiteColor]
@property (nonatomic, strong) UIColor *textShadowColor; // default is [UIColor blackColor]
@property (nonatomic, readwrite) CGSize textShadowOffset; // default is CGSizeMake(0, -1)
@property (nonatomic, readwrite) BOOL shouldCastShadow; // default is YES (NO when backgroundImage is set)
@property (nonatomic, assign) CGFloat gradientIntensity; // default is 0.15

@end