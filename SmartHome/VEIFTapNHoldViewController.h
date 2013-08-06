//
//  VETabNHoldElementViewController.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 16.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VETapNHoldView.h"
#import <QuartzCore/QuartzCore.h>
#import "SHIconWithTitle.h"

@protocol tapNHoldDelegate

- (void)cooker:(NSInteger)cookerIndex didChangeTo:(NSInteger)cookerValue;

@end

@interface VEIFTapNHoldViewController : UIViewController

@property (nonatomic, strong) NSArray *items;

- (id)initWithIndex:(NSInteger)index cookerValue:(NSInteger)value andDelegate:(id<tapNHoldDelegate>)delegate andSuperView:(UIView*)superView;
- (void)setCookerValue:(NSInteger)value;

- (void)setPredefinedValue:(id)value;

@end
