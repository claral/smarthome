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
@property (nonatomic, assign) int currentIndexValue;
@property (nonatomic, assign) float currentPercentageValue;

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
    
    
    //Percentage Wheel
    self.pwvc = [[VEVMPercentageWheelViewController alloc]init];
    UIView *pwView = self.pwvc.view;
    
    [pwView setBounds:CGRectMake(0, 0, pwView.frame.size.width, pwView.frame.size.height)];
    [pwView setCenter:CGPointMake(510, 400)];
    
    //[pwView setBackgroundColor:[UIColor magentaColor]];
    //[self.view addSubview:pwView];
    
    
    
    
    // ON OFF CONTROL
    // Hinzufuegen von Feldern: @"Text". (Text betitelt Feld)
    SVSegmentedControl *navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    navSC.changeHandler = ^(NSUInteger newIndex) {
        __block NSUInteger index = navSC.selectedSegmentIndex;
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
        
        // storage of currentindex
        self.currentIndexValue = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue] forKey:@"currentIndexValueLightEntrance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC setIndexToBeginWith:index];
        
        
        // show ON OFF // within light view
        self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueLightEntrance"] integerValue];
        int returnIdxVal;
        if (self.currentIndexValue == 0) // off
        {
            returnIdxVal = [navSC setIndexToBeginWith:1];
            [self.view addSubview:pwView];
        } else if (self.currentIndexValue == 1) // on
        {
            returnIdxVal = [navSC setIndexToBeginWith:0];
            [pwView removeFromSuperview];
        }
        
    };
    
    // reading stored index value
    self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueLightEntrance"] integerValue];
    int returnIdxVal;
    
    // reading stored percentage value
    self.currentPercentageValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentPercentageValueLightEntrance"] floatValue];
    [pwView setBounds:CGRectMake(0, 0, pwView.frame.size.width, pwView.frame.size.height)];
    [pwView setCenter:CGPointMake(510, 400)];
    NSNumber *currentPercentageNumber = [[NSNumber alloc] init];
    
    // show ON OFF // from entrance view to light view
    if (self.currentIndexValue == 0) // on
    {
        // set stored percentage
        currentPercentageNumber = [NSNumber numberWithFloat:self.currentPercentageValue];
        [_pwvc setPredefinedValue:currentPercentageNumber];
        
        // set stored index
        returnIdxVal = [navSC setIndexToBeginWith:1];
        [self.view addSubview:pwView];
    } else if (self.currentIndexValue == 1) // off
    {
        // set stored percentage
        currentPercentageNumber = [NSNumber numberWithFloat:self.currentPercentageValue];
        [_pwvc setPredefinedValue:currentPercentageNumber];

        // set stored index
        returnIdxVal = [navSC setIndexToBeginWith:0];
        [pwView removeFromSuperview];
    }
    
    [self.view addSubview:navSC];
    //navSC.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/4);
    navSC.center = CGPointMake(930, 55);
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // storage of current percentage value
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:_pwvc.percentageWheelView.valueAngle] forKey:@"currentPercentageValueLightEntrance"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
