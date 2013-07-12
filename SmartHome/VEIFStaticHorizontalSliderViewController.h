//
//  VEStaticHorizontalViewController.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 23.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

//#import "VEAbstractControlViewController.h"
#import "SHIconWithTitle.h"
#import "VEStaticHorizontalSliderView.h"
#import <QuartzCore/QuartzCore.h>

@interface VEIFStaticHorizontalSliderViewController : UIViewController

@property (nonatomic, strong) id<SliderDelegate> sDelegate;
@property (nonatomic, strong) NSArray *icons;

@end
