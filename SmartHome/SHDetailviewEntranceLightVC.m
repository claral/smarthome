//
//  SHDetailviewEntranceLightVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewEntranceLightVC.h"
#import "SVSegmentedControl.h"
#import "SVSegmentedThumb.h"
#import "VEVMPercentageWheelViewController.h"

@interface SHDetailviewEntranceLightVC ()

@property (strong) VEVMPercentageWheelViewController *pwvc;

@end

@implementation SHDetailviewEntranceLightVC

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
    
    
    // 1st CONTROL
    // Hinzufuegen von Feldern: @"Text". (Text betitelt Feld)
    SVSegmentedControl *navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"OFF", @"ON", nil]];
    navSC.changeHandler = ^(NSUInteger newIndex) {
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
    };
    
    [self.view addSubview:navSC];
    
    navSC.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/4);  //CGPointMake(160, 70). Ausrichten Des ToggleButtons im IPad Bildschirm selber
    
    //Percentage Wheel
    self.pwvc = [[VEVMPercentageWheelViewController alloc]init];
    
    UIView *pwView = self.pwvc.view;
    
    [pwView setBounds:CGRectMake(0, 0, pwView.frame.size.width, pwView.frame.size.height)];
    [pwView setCenter:CGPointMake(510, 400)];
//    [pwView setBackgroundColor:[UIColor magentaColor]];
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
