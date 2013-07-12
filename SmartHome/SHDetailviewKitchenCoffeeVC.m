//
//  SHDetailviewKitchenCoffeeVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewKitchenCoffeeVC.h"
//#import <VEIFStaticHorizontalSliderViewController.h>
//#import <NSURL+IconName.h>

@interface SHDetailviewKitchenCoffeeVC ()

@property (strong) VEIFStaticHorizontalSliderViewController *svc;

@end

@implementation SHDetailviewKitchenCoffeeVC

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
    icon1.icon = [UIImage imageNamed:@"01-Espresso"];
    icon1.title = @"Espresso";
    
    SHIconWithTitle *icon2 = [[SHIconWithTitle alloc] init];
    icon2.icon = [UIImage imageNamed:@"02-Espresso-Doppio"];
    icon2.title = @"Espresso-Doppio";
    
    SHIconWithTitle *icon3 = [[SHIconWithTitle alloc] init];
    icon3.icon = [UIImage imageNamed:@"03-Kaffee"];
    icon3.title = @"Kaffee";
    
    SHIconWithTitle *icon4 = [[SHIconWithTitle alloc] init];
    icon4.icon = [UIImage imageNamed:@"04-Cappuccino"];
    icon4.title = @"Cappuccino";
    
    SHIconWithTitle *icon5 = [[SHIconWithTitle alloc] init];
    icon5.icon = [UIImage imageNamed:@"05-Latte-Macchiato"];
    icon5.title = @"Latte Macchiato";
    
    SHIconWithTitle *icon6 = [[SHIconWithTitle alloc] init];
    icon6.icon = [UIImage imageNamed:@"07-Milchkaffee"];
    icon6.title = @"Milchkaffee";
    
    SHIconWithTitle *icon7 = [[SHIconWithTitle alloc] init];
    icon7.icon = [UIImage imageNamed:@"07-Warme-Milch"];
    icon7.title = @"Warme Milch";
    
    SHIconWithTitle *icon8 = [[SHIconWithTitle alloc] init];
    icon8.icon = [UIImage imageNamed:@"08-Heisses-Wasser"];
    icon8.title = @"Heisses Wasser";
    
    self.svc.icons = [[NSArray alloc] initWithObjects:icon1, icon2, icon3, icon4, icon5, icon6, icon7, icon8, nil];
    
    UIView *sliderView = self.svc.view;
    
    [sliderView setBounds:CGRectMake(-100, 80, sliderView.frame.size.width, sliderView.frame.size.height)];
    //[self.view addSubview:sliderView];
    //[self.view sendSubviewToBack:sliderView];
    [self.view insertSubview:sliderView atIndex:0];
    
    // Do any additional setup after loading the view from its nib.
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
