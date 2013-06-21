//
//  SHDetailviewEntranceAlarmVC.h
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHDetailviewEntranceAlarmVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelAlarmCode;
- (IBAction)backToSH:(id)sender;
- (IBAction)closeDetailView:(id)sender;
- (IBAction)buttonAlarmDisplay:(UIButton *)sender;
- (IBAction)buttonDeleteAlarmDisplayLastItem:(UIButton *)sender;
@end
