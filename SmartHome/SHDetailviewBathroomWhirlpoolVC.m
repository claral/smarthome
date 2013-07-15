//
//  SHDetailviewBathroomWhirlpoolVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewBathroomWhirlpoolVC.h"

@interface SHDetailviewBathroomWhirlpoolVC ()

@property (strong) VEIFStaticHorizontalSliderViewController *svc;

@end

@implementation SHDetailviewBathroomWhirlpoolVC

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

    self.svc =
    [[VEIFStaticHorizontalSliderViewController alloc] init];
    self.svc.sDelegate = self;
    
    SHIconWithTitle *icon1 = [[SHIconWithTitle alloc] init];
    icon1.icon = [UIImage imageNamed:@"Bubble1"];
    icon1.title = @"Wenig Blubberblasen";
    
    SHIconWithTitle *icon2 = [[SHIconWithTitle alloc] init];
    icon2.icon = [UIImage imageNamed:@"Bubble2"];
    icon2.title = @"Viele Blubberblasen";
    
    SHIconWithTitle *icon3 = [[SHIconWithTitle alloc] init];
    icon3.icon = [UIImage imageNamed:@"Bubble3"];
    icon3.title = @"Sehr viele Blubberblasen";
    
    self.svc.icons = [[NSArray alloc] initWithObjects:icon1, icon2, icon3, nil];
    
    UIView *sliderView = self.svc.view;
    
    [sliderView setBounds:CGRectMake(-100, 80, sliderView.frame.size.width, sliderView.frame.size.height)];
    //[self.view addSubview:sliderView];
    //[self.view sendSubviewToBack:sliderView];
    [self.view insertSubview:sliderView atIndex:0];

    
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

- (void)sliderDidMoveTo:(NSInteger)index
{
    NSLog(@"Selected Item = %i", index);
}

@end
