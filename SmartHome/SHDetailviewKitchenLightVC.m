//
//  SHDetailviewKitchenLightVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewKitchenLightVC.h"
#import "VEVMPercentageWheelViewController.h"

@interface SHDetailviewKitchenLightVC ()

@property (strong) VEVMPercentageWheelViewController *pwvc;

@end

@implementation SHDetailviewKitchenLightVC

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
    
    self.pwvc = [[VEVMPercentageWheelViewController alloc]init];
    
    UIView *pwView = self.pwvc.view;
    
    [pwView setBounds:CGRectMake(0, 0, pwView.frame.size.width, pwView.frame.size.height)];
    [pwView setCenter:CGPointMake(500, 500)];
    //[sliderView setBackgroundColor:[UIColor magentaColor]];
    [self.view addSubview:pwView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeDetailView:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)backToSH:(id)sender
{
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    // TODO: wirklich alle Views dismissed?
}

@end
