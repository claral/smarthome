//
//  SHDetailviewBathroomWhirlpoolVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewBathroomWhirlpoolVC.h"
#import "SVSegmentedControl.h"
#import "SVSegmentedThumb.h"

@interface SHDetailviewBathroomWhirlpoolVC ()

@property (weak, nonatomic) IBOutlet UIPickerView *temperatureWheel;
@property (strong, nonatomic, readwrite) NSArray *temperatureWheelItems;
@property (nonatomic, assign) int currentTemperatureValue;
@property (strong) VEIFStaticHorizontalSliderViewControllerPool *svc;
@property (nonatomic, assign) int currentIndexValue;
@property (nonatomic, assign) int currentIndexValueSliderBubbles;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSliderFrame;

@end

@implementation SHDetailviewBathroomWhirlpoolVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // init array of heating
        self.temperatureWheelItems = [[NSArray alloc] initWithObjects:@"25° Celsius", @"26° Celsius", @"27° Celsius", @"28° Celsius", @"29° Celsius", @"30° Celsius", @"31° Celsius", @"32° Celsius", @"33° Celsius", @"34° Celsius", @"35° Celsius", nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.svc =
    [[VEIFStaticHorizontalSliderViewControllerPool alloc] init];
    self.svc.sDelegate = self;
    
    SHIconWithTitle *icon1 = [[SHIconWithTitle alloc] init];
    icon1.icon = [UIImage imageNamed:@"Bubble1"];
    icon1.title = @"MIN";
    
    SHIconWithTitle *icon2 = [[SHIconWithTitle alloc] init];
    icon2.icon = [UIImage imageNamed:@"Bubble2"];
    icon2.title = @"Mittel";
    
    SHIconWithTitle *icon3 = [[SHIconWithTitle alloc] init];
    icon3.icon = [UIImage imageNamed:@"Bubble3"];
    icon3.title = @"MAX";
    
    self.svc.icons = [[NSArray alloc] initWithObjects:icon1, icon2, icon3, nil];
    
    UIView *sliderView = self.svc.view;
    
    [sliderView setBounds:CGRectMake(0, 0, sliderView.frame.size.width, sliderView.frame.size.height)];
    [sliderView setCenter:CGPointMake(930, 575)];

    
    // STATIC HORIZONTAL SLIDER
    // reading stored wheelindex
    self.currentIndexValueSliderBubbles = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexBubblesSliderWhirlpool"] intValue];
    NSNumber *currentIdxNumber = [[NSNumber alloc] init];
    currentIdxNumber = [NSNumber numberWithFloat:self.currentIndexValueSliderBubbles];
    [self.svc setPredefinedValue:currentIdxNumber];
    
    
    // ONOFFSwitch
    // Hinzufuegen von Feldern: @"Text". (Text betitelt Feld)
    SVSegmentedControl *navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    navSC.changeHandler = ^(NSUInteger newIndex) {
        __block NSUInteger index = navSC.selectedSegmentIndex;
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
        
        // storage of currentindex
        self.currentIndexValue = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue] forKey:@"currentIndexValueWhirlpoolBathroom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC setIndexToBeginWith:index];
        
        
        self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueWhirlpoolBathroom"] integerValue];
        int returnIdxVal;
        if (self.currentIndexValue == 0) // off
        {
            returnIdxVal = [navSC setIndexToBeginWith:1];
            [self.temperatureWheel setHidden:NO];
            [self.imageViewSliderFrame setHidden:NO];
            [self.view addSubview:sliderView];
        } else if (self.currentIndexValue == 1) // on
        {
            returnIdxVal = [navSC setIndexToBeginWith:0];
            [self.temperatureWheel setHidden:YES];
            [self.imageViewSliderFrame setHidden:YES];
            [sliderView removeFromSuperview];
        }
    };
    
    
    
    // reading stored index value
    self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueWhirlpoolBathroom"] integerValue];
    int returnIdxVal;
    
    // show ON OFF // from entrance view to whirlpool view // TODOOO
    if (self.currentIndexValue == 0) // on
    {
        // set stored index
        returnIdxVal = [navSC setIndexToBeginWith:1];
        [self.temperatureWheel setHidden:NO];
        [self.imageViewSliderFrame setHidden:NO];
        [self.view addSubview:sliderView];
    } else if (self.currentIndexValue == 1) // off
    {
        // set stored index
        returnIdxVal = [navSC setIndexToBeginWith:0];
        [self.temperatureWheel setHidden:YES];
        [self.imageViewSliderFrame setHidden:YES];
        [sliderView removeFromSuperview];
    }
    
    
    
    [self.view addSubview:navSC];
    navSC.center = CGPointMake(930, 55);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // reading stored temperature
    self.currentTemperatureValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentHeatingValueWhirlpoolBathroom"] integerValue];
    
    // reading stored row
    int currRow = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentRowValueBathroom"] integerValue];
    [self.temperatureWheel selectRow:currRow inComponent:0 animated:NO];
    
    // reading stored index (slider bubbles)
    self.currentIndexValueSliderBubbles = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexBubblesSliderWhirlpool"] intValue];
    NSNumber *currentIdxNumber = [[NSNumber alloc] init];
    currentIdxNumber = [NSNumber numberWithFloat:self.currentIndexValueSliderBubbles];
    [self.svc setPredefinedValue:currentIdxNumber];
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
    self.currentIndexValueSliderBubbles = index;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValueSliderBubbles] forKey:@"currentIndexBubblesSliderWhirlpool"];
    
    NSLog(@"Selected Item = %i", index);
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.temperatureWheelItems count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.temperatureWheelItems objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row == 0)
    {
        self.currentTemperatureValue = 25;
    } else if (row == 1)
    {
        self.currentTemperatureValue = 26;
    } else if (row == 2)
    {
        self.currentTemperatureValue = 27;
    } else if (row == 3)
    {
        self.currentTemperatureValue = 28;
    } else if (row == 4)
    {
        self.currentTemperatureValue = 29;
    } else if (row == 5)
    {
        self.currentTemperatureValue = 30;
    } else if (row == 6)
    {
        self.currentTemperatureValue = 31;
    } else if (row == 7)
    {
        self.currentTemperatureValue = 32;
    } else if (row == 8)
    {
        self.currentTemperatureValue = 33;
    } else if (row == 9)
    {
        self.currentTemperatureValue = 34;
    } else if (row == 10)
    {
        self.currentTemperatureValue = 35;
    }
    
    // storage of temperature
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentTemperatureValue] forKey:@"currentHeatingValueWhirlpoolBathroom"];
    // storage of row
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:row] forKey:@"currentRowValueBathroom"];
}

@end
