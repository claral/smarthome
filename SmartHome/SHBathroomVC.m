//
//  SHBathroomVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHBathroomVC.h"
#import "SHDetailviewBathroomWhirlpoolVC.h"
#import "SHDetailviewBathroomRadioVC.h"
#import "SHDetailviewBathroomLightVC.h"
#import "SHDetailviewBathroomHeatingVC.h"

@interface SHBathroomVC ()

@end

@implementation SHBathroomVC

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
    SHDetailviewBathroomLightVC* viewControllerBathroomDetailLight = [[SHDetailviewBathroomLightVC alloc] initWithNibName:@"SHDetailviewBathroomLightVC" bundle:nil];
    
    [self presentViewController:viewControllerBathroomDetailLight animated:NO completion:nil];
}

- (IBAction)heatingButtonTouchUp:(UIButton *)sender
{
    SHDetailviewBathroomHeatingVC* viewControllerBathroomDetailHeating = [[SHDetailviewBathroomHeatingVC alloc] initWithNibName:@"SHDetailviewBathroomHeatingVC" bundle:nil];
    
    [self presentViewController:viewControllerBathroomDetailHeating animated:NO completion:nil];
}

- (IBAction)radioButtonTouchUp:(UIButton *)sender
{
    SHDetailviewBathroomRadioVC* viewControllerBathroomDetailRadio = [[SHDetailviewBathroomRadioVC alloc] initWithNibName:@"SHDetailviewBathroomRadioVC" bundle:nil];
    
    [self presentViewController:viewControllerBathroomDetailRadio animated:NO completion:nil];
}

- (IBAction)whirlpoolButtonTouchUp:(UIButton *)sender
{
    SHDetailviewBathroomWhirlpoolVC* viewControllerBathroomDetailWhirlpool = [[SHDetailviewBathroomWhirlpoolVC alloc] initWithNibName:@"SHDetailviewBathroomWhirlpoolVC" bundle:nil];
    
    [self presentViewController:viewControllerBathroomDetailWhirlpool animated:NO completion:nil];
}

@end
