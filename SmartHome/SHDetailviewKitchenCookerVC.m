//
//  SHDetailviewKitchenCookerVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewKitchenCookerVC.h"

@interface SHDetailviewKitchenCookerVC ()

@property (strong) VEIFTapNHoldViewController *cookerAView;
@property (strong) VEIFTapNHoldViewController *cookerBView;
@property (strong) VEIFTapNHoldViewController *cookerCView;
@property (strong) VEIFTapNHoldViewController *cookerDView;

@property (nonatomic, assign) int currentIndexCookerA;
@property (nonatomic, assign) int currentIndexCookerB;
@property (nonatomic, assign) int currentIndexCookerC;
@property (nonatomic, assign) int currentIndexCookerD;

@end

@implementation SHDetailviewKitchenCookerVC

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
    
    
/**    Begin Cooker A **/
    self.currentIndexCookerA = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueCookerA"] intValue];

    self.cookerAView =
    [[VEIFTapNHoldViewController alloc] initWithIndex:1 cookerValue:self.currentIndexCookerA andDelegate:self];
//    self.tnhvc.sDelegate = self;
        
    SHIconWithTitle *icon1 = [[SHIconWithTitle alloc] init];
    icon1.icon = [UIImage imageNamed:@"Cooker0"];
    icon1.title = @"0";
    
    SHIconWithTitle *icon2 = [[SHIconWithTitle alloc] init];
    icon2.icon = [UIImage imageNamed:@"Cooker1"];
    icon2.title = @"1";
    
    SHIconWithTitle *icon3 = [[SHIconWithTitle alloc] init];
    icon3.icon = [UIImage imageNamed:@"Cooker2"];
    icon3.title = @"2";
    
    SHIconWithTitle *icon4 = [[SHIconWithTitle alloc] init];
    icon4.icon = [UIImage imageNamed:@"Cooker3"];
    icon4.title = @"3";
    
    SHIconWithTitle *icon5 = [[SHIconWithTitle alloc] init];
    icon5.icon = [UIImage imageNamed:@"Cooker4"];
    icon5.title = @"4";
    
    SHIconWithTitle *icon6 = [[SHIconWithTitle alloc] init];
    icon6.icon = [UIImage imageNamed:@"Cooker5"];
    icon6.title = @"5";
    
    SHIconWithTitle *icon7 = [[SHIconWithTitle alloc] init];
    icon7.icon = [UIImage imageNamed:@"Cooker6"];
    icon7.title = @"6";
    
    SHIconWithTitle *icon8 = [[SHIconWithTitle alloc] init];
    icon8.icon = [UIImage imageNamed:@"Cooker7"];
    icon8.title = @"7";
    
    SHIconWithTitle *icon9 = [[SHIconWithTitle alloc] init];
    icon9.icon = [UIImage imageNamed:@"Cooker8"];
    icon9.title = @"8";
        
    self.cookerAView.items = [[NSArray alloc] initWithObjects:icon3, icon2, icon1, icon9, icon8, icon7, icon6, icon5, icon4, nil];
    
    UIView *AView = self.cookerAView.view;
    
//    [AView setBackgroundColor:[UIColor magentaColor]];
    [AView setBounds:CGRectMake(0,0, AView.frame.size.width*1/4, AView.frame.size.height*2/7)];
    [AView setCenter:CGPointMake(200, 530)];
    
    [self.view addSubview:AView];
    
    
/**    Begin Cooker B **/
    self.currentIndexCookerB = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueCookerB"] intValue];
    
    self.cookerBView =
    [[VEIFTapNHoldViewController alloc] initWithIndex:2 cookerValue:self.currentIndexCookerB andDelegate:self];
    
    self.cookerBView.items = [[NSArray alloc] initWithObjects:icon3, icon2, icon1, icon9, icon8, icon7, icon6, icon5, icon4, nil];
    
    UIView *BView = self.cookerBView.view;
    
    //    [BView setBackgroundColor:[UIColor blueColor]];
    [BView setBounds:CGRectMake(0,0, BView.frame.size.width*1/4, BView.frame.size.height*2/7)];
    [BView setCenter:CGPointMake(200, 230)];
    
    [self.view addSubview:BView];
    
    
    
/**    Begin Cooker C **/
    self.currentIndexCookerC = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueCookerC"] intValue];
    
    self.cookerCView =
    [[VEIFTapNHoldViewController alloc] initWithIndex:3 cookerValue:self.currentIndexCookerC andDelegate:self];
    
    self.cookerCView.items = [[NSArray alloc] initWithObjects:icon3, icon2, icon1, icon9, icon8, icon7, icon6, icon5, icon4, nil];
    
    UIView *CView = self.cookerCView.view;
    
    //    [CView setBackgroundColor:[UIColor greenColor]];
    [CView setBounds:CGRectMake(0,0, CView.frame.size.width*1/4, CView.frame.size.height*2/7)];
    [CView setCenter:CGPointMake(700, 230)];
    
    [self.view addSubview:CView];
    
    

/**    Begin Cooker D **/
    self.currentIndexCookerD = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueCookerD"] intValue];
    
    self.cookerDView =
    [[VEIFTapNHoldViewController alloc] initWithIndex:4 cookerValue:self.currentIndexCookerD andDelegate:self];
    
    self.cookerDView.items = [[NSArray alloc] initWithObjects:icon3, icon2, icon1, icon9, icon8, icon7, icon6, icon5, icon4, nil];
    
    UIView *DView = self.cookerDView.view;
    
    //    [DView setBackgroundColor:[UIColor greenColor]];
    [DView setBounds:CGRectMake(0,0, DView.frame.size.width*1/4, DView.frame.size.height*2/7)];
    [DView setCenter:CGPointMake(700, 530)];
    
    [self.view addSubview:DView];

    

    
}

- (void)cooker:(NSInteger)cookerIndex didChangeTo:(NSInteger)cookerValue
{
    
    NSLog(@"Hurray the cooker %i JUST changed to %i", cookerIndex, cookerValue);

    switch (cookerIndex) {
        case 1:
            self.currentIndexCookerA = cookerValue;
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexCookerA] forKey:@"currentIndexValueCookerA"];
            break;
        case 2:
            self.currentIndexCookerB = cookerValue;
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexCookerB] forKey:@"currentIndexValueCookerB"];
            break;
        case 3:
            self.currentIndexCookerC = cookerValue;
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexCookerC] forKey:@"currentIndexValueCookerC"];
            break;
        case 4:
            self.currentIndexCookerD = cookerValue;
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexCookerD] forKey:@"currentIndexValueCookerD"];
            break;
        default:
            break;
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
       
    // reading stored index
    self.currentIndexCookerA = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueCookerA"] intValue];
    [_cookerAView setCookerValue:self.currentIndexCookerA];

    self.currentIndexCookerB = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueCookerB"] intValue];
    [_cookerBView setCookerValue:self.currentIndexCookerB];
    
    self.currentIndexCookerC = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueCookerC"] intValue];
    [_cookerCView setCookerValue:self.currentIndexCookerC];

    self.currentIndexCookerD = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueCookerD"] intValue];
    [_cookerDView setCookerValue:self.currentIndexCookerD];
    
        
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
