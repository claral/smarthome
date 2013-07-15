//
//  SHDetailviewLivingroomHeatingVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewLivingroomHeatingVC.h"

@interface SHDetailviewLivingroomHeatingVC ()

@property (strong) VEIFStaticHorizontalSliderViewController *svc;

@end

@implementation SHDetailviewLivingroomHeatingVC

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
    // Do any additional setup after loading the view from its nib.
    
    self.svc =
    [[VEIFStaticHorizontalSliderViewController alloc] init];
    self.svc.sDelegate = self;
    
    SHIconWithTitle *icon1 = [[SHIconWithTitle alloc] init];
    icon1.icon = [UIImage imageNamed:@"Heizung-Frost"];
    icon1.title = @"Anti-Frost";
    
    SHIconWithTitle *icon2 = [[SHIconWithTitle alloc] init];
    icon2.icon = [UIImage imageNamed:@"Heizung-Manuell"];
    icon2.title = @"Manuell ..";
    
    SHIconWithTitle *icon3 = [[SHIconWithTitle alloc] init];
    icon3.icon = [UIImage imageNamed:@"Heizung-Nacht"];
    icon3.title = @"Nacht";
    
    SHIconWithTitle *icon4 = [[SHIconWithTitle alloc] init];
    icon4.icon = [UIImage imageNamed:@"Heizung-Tag"];
    icon4.title = @"Tag";
    
    self.svc.icons = [[NSArray alloc] initWithObjects:icon1, icon2, icon3, icon4, nil];
    
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
