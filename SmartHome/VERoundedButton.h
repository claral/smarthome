//
//  VERoundedButton.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 22.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface VERoundedButton : CALayer

@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) CATextLayer *titleLayer;
@property (nonatomic, strong) CAGradientLayer *backgroundLayer;

@property (nonatomic, assign) BOOL pressed;
@property (nonatomic, assign) BOOL highlighted;

@property (nonatomic, assign) BOOL drawBackgroundGradient;

@end
