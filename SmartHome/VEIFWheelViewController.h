//
//  VEWheelViewController.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 26.12.12.
//  Copyright (c) 2012 Institute of Ergonomics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VEWheelView.h"
#import "VEWheelItemView.h"


@class VEWheelView;

@interface VEIFWheelViewController : UIViewController <VEWheelViewDelegate>

@property (nonatomic, strong) NSArray *items;

@end
