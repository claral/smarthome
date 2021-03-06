//
//  VEStaticHorizontalViewController.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 23.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

//#import "VEAbstractControlViewController.h"
#import "SHIconWithTitle.h"
#import "VEStaticHorizontalSliderViewHeating.h"
#import <QuartzCore/QuartzCore.h>

@interface VEIFStaticHorizontalSliderViewControllerHeating : UIViewController

@property (nonatomic, strong) id<SliderDelegate> sDelegate;
@property (nonatomic, strong) NSArray *icons;

- (void)setPredefinedValue:(id)value;

@end
