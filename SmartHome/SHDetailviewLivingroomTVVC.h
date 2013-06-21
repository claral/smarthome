//
//  SHDetailviewLivingroomTVVC.h
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHDetailviewLivingroomTVVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelTVChannel;
- (IBAction)closeDetailView:(id)sender;
- (IBAction)backToSH:(id)sender;
- (IBAction)buttonChanelDisplay:(UIButton *)sender;

@end
