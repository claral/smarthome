//
//  SHBathroomVC.h
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHBathroomVC : UIViewController

- (IBAction)backToSH:(id)sender;
- (IBAction)lightButtonTouchUp:(UIButton *)sender;
- (IBAction)heatingButtonTouchUp:(UIButton *)sender;
- (IBAction)radioButtonTouchUp:(UIButton *)sender;
- (IBAction)whirlpoolButtonTouchUp:(UIButton *)sender;

@end
