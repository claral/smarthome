//
//  SHDetailviewLivingroomLightViewController.h
//  SmartHome
//
//  Created by Clara Lange on 6/12/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHDetailviewLivingroomLightViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *ButtonLivingRoomLight;
- (IBAction)ActionButtonLivingroomLight:(id)sender;
- (IBAction)closeDetailView:(id)sender;

@end
