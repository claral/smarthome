//
//  SHBasementVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHBasementVC.h"
#import "SHDetailviewBasementLightVC.h"
#import "SHDetailviewBasementLaundryVC.h"

@interface SHBasementVC ()

@end

@implementation SHBasementVC

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
    SHDetailviewBasementLightVC* viewControllerBasementDetailLight = [[SHDetailviewBasementLightVC alloc] initWithNibName:@"SHDetailviewBasementLightVC" bundle:nil];
    
    [self presentViewController:viewControllerBasementDetailLight animated:NO completion:nil];
}

- (IBAction)laundryButtonTouchUp:(UIButton *)sender
{
    SHDetailviewBasementLaundryVC* viewControllerBasementDetailLaundry = [[SHDetailviewBasementLaundryVC alloc] initWithNibName:@"SHDetailviewBasementLaundryVC" bundle:nil];
    
    [self presentViewController:viewControllerBasementDetailLaundry animated:NO completion:nil];
}
@end
