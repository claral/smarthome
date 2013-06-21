//
//  SHDetailviewLivingroomPhoneVC.h
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHDetailviewLivingroomPhoneVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelPhoneNumber;
- (IBAction)closeDetailview:(id)sender;
- (IBAction)backToSH:(id)sender;
- (IBAction)buttonPhoneDisplay:(UIButton *)sender;
- (IBAction)buttonDeletePhoneDisplay:(UIButton *)sender;
- (IBAction)buttonDeletePhoneDisplayLastNumber:(UIButton *)sender;
@end
