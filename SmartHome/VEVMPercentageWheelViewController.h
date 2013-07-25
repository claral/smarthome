//
//  VEPercentageWheelViewController.h
//  VirtualUIElements
//
//  Created by Tom Schelo on 23.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VEPercentageWheelView.h"
#import "VELightView.h"


@interface VEVMPercentageWheelViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet VEPercentageWheelView *percentageWheelView;
@property (weak, nonatomic) IBOutlet VELightView *lightView;

@end
