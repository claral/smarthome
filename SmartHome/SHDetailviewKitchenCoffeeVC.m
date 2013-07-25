//
//  SHDetailviewKitchenCoffeeVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewKitchenCoffeeVC.h"
#import "SVSegmentedThumb.h"
#import "SVSegmentedControl.h"

//#import <VEIFStaticHorizontalSliderViewController.h>
//#import <NSURL+IconName.h>

@interface SHDetailviewKitchenCoffeeVC ()

@property (strong) VEIFStaticHorizontalSliderViewController *svc;
- (IBAction)buttonStartCoffee:(id)sender;

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
    icon2.title = @"Doppio";
    
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
    
    [sliderView setBounds:CGRectMake(0, 0, sliderView.frame.size.width, sliderView.frame.size.height)];
    [sliderView setCenter:CGPointMake(500, 500)];
    //[sliderView setBackgroundColor:[UIColor magentaColor]];
    [self.view addSubview:sliderView];
    //[self.view sendSubviewToBack:sliderView];
//    [self.view insertSubview:sliderView atIndex:0];
    
    // ONOFFSwitch
    // Hinzufuegen von Feldern: @"Text". (Text betitelt Feld)
    SVSegmentedControl *navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"OFF", @"ON", nil]];
    navSC.changeHandler = ^(NSUInteger newIndex) {
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
    };
    
    [self.view addSubview:navSC];
    
    navSC.center = CGPointMake((self.view.frame.size.width*1)/3, self.view.frame.size.height/3);  //CGPointMake(160, 70). Ausrichten Des ToggleButtons im IPad Bildschirm selber
    
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

- (IBAction)buttonStartCoffee:(id)sender
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Kaffeezubereitung" message:@"3...2...1...FERTIG!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [message show];
}

@end
