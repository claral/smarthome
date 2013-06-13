//
//  SHEntranceVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHEntranceVC.h"
#import "SHDetailviewEntranceAlarmVC.h"
#import "SHDetailviewEntranceLightVC.h"

@interface SHEntranceVC ()

@end

@implementation SHEntranceVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToSH:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)lightButtonTouchUp:(UIButton *)sender
{
    SHDetailviewEntranceLightVC* viewControllerEntranceDetailLight = [[SHDetailviewEntranceLightVC alloc] initWithNibName:@"SHDetailviewEntranceLightVC" bundle:nil];
    
    [self presentViewController:viewControllerEntranceDetailLight animated:NO completion:nil];
}

- (IBAction)alarmButtonTouchUp:(UIButton *)sender
{
    SHDetailviewEntranceAlarmVC* viewControllerEntranceDetailAlarm = [[SHDetailviewEntranceAlarmVC alloc] initWithNibName:@"SHDetailviewEntranceAlarmVC" bundle:nil];
    
    [self presentViewController:viewControllerEntranceDetailAlarm animated:NO completion:nil];
}

@end
