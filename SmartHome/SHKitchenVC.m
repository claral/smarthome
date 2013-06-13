//
//  SHKitchenVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHKitchenVC.h"
#import "SHDetailviewKitchenLightVC.h"
#import "SHDetailviewKitchenHeatingVC.h"
#import "SHDetailviewKitchenFridgeVC.h"
#import "SHDetailviewKitchenCookerVC.h"
#import "SHDetailviewKitchenCoffeeVC.h"

@interface SHKitchenVC ()

@end

@implementation SHKitchenVC

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

- (IBAction)lightButtonTouchUp:(UIButton *)sender
{
    SHDetailviewKitchenLightVC* viewControllerKitchenDetailLight = [[SHDetailviewKitchenLightVC alloc] initWithNibName:@"SHDetailviewKitchenLightVC" bundle:nil];
    
    [self presentViewController:viewControllerKitchenDetailLight animated:NO completion:nil];
}

- (IBAction)heatingButtonTouchUp:(UIButton *)sender
{
    SHDetailviewKitchenHeatingVC* viewControllerKitchenDetailHeating = [[SHDetailviewKitchenHeatingVC alloc] initWithNibName:@"SHDetailviewKitchenHeatingVC" bundle:nil];
    
    [self presentViewController:viewControllerKitchenDetailHeating animated:NO completion:nil];
}

- (IBAction)fridgeButtonTouchUp:(UIButton *)sender
{
    SHDetailviewKitchenFridgeVC* viewControllerKitchenDetailFridge = [[SHDetailviewKitchenFridgeVC alloc] initWithNibName:@"SHDetailviewKitchenFridgeVC" bundle:nil];
    
    [self presentViewController:viewControllerKitchenDetailFridge animated:NO completion:nil];
}

- (IBAction)cookerButtonTouchUp:(UIButton *)sender
{
    SHDetailviewKitchenCookerVC* viewControllerKitchenDetailCooker = [[SHDetailviewKitchenCookerVC alloc] initWithNibName:@"SHDetailviewKitchenCookerVC" bundle:nil];
    
    [self presentViewController:viewControllerKitchenDetailCooker animated:NO completion:nil];
}

- (IBAction)coffeeButtonTouchUp:(UIButton *)sender
{
    SHDetailviewKitchenCoffeeVC* viewControllerKitchenDetailCoffee = [[SHDetailviewKitchenCoffeeVC alloc] initWithNibName:@"SHDetailviewKitchenCoffeeVC" bundle:nil];
    
    [self presentViewController:viewControllerKitchenDetailCoffee animated:NO completion:nil];
}

- (IBAction)backToSH:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
