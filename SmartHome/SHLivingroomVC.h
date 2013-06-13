//
//  SHLivingroomVC.h
//  SmartHome
//
//  Created by Clara Lange on 12.06.13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHLivingroomVC : UIViewController

- (IBAction)lightButtonTouchUp:(UIButton *)sender;
- (IBAction)phoneButtonTouchUp:(UIButton *)sender;
- (IBAction)tvButtonTouchUP:(UIButton *)sender;
- (IBAction)stereoButtonTouchUp:(UIButton *)sender;
- (IBAction)heatingButtonTouchUp:(UIButton *)sender;

- (IBAction)backToSH:(UIButton *)sender;


@end
