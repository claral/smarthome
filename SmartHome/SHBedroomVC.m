//
//  SHBedroomVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHBedroomVC.h"
#import "SHDetailviewBedroomSoundVC.h"
#import "SHDetailviewBedroomLightVC.h"
#import "SHDetailviewBedroomHeatingVC.h"

@interface SHBedroomVC ()

@end

@implementation SHBedroomVC

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
    SHDetailviewBedroomLightVC* viewControllerBedroomDetailLight = [[SHDetailviewBedroomLightVC alloc] initWithNibName:@"SHDetailviewBedroomLightVC" bundle:nil];
    
    [self presentViewController:viewControllerBedroomDetailLight animated:NO completion:nil];
}

- (IBAction)heatingButtonTouchUp:(UIButton *)sender
{
    SHDetailviewBedroomHeatingVC* viewControllerBedroomDetailHeating = [[SHDetailviewBedroomHeatingVC alloc] initWithNibName:@"SHDetailviewBedroomHeatingVC" bundle:nil];
    
    [self presentViewController:viewControllerBedroomDetailHeating animated:NO completion:nil];
}

- (IBAction)soundButtonTouchUp:(UIButton *)sender
{
    SHDetailviewBedroomSoundVC* viewControllerBedroomDetailSound = [[SHDetailviewBedroomSoundVC alloc] initWithNibName:@"SHDetailviewBedroomSoundVC" bundle:nil];
    
    [self presentViewController:viewControllerBedroomDetailSound animated:NO completion:nil];
}
@end
