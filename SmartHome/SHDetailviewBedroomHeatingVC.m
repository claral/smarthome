//
//  SHDetailviewBedroomHeatingVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewBedroomHeatingVC.h"
#import "VEIFStaticHorizontalSliderViewControllerHeating.h"

@interface SHDetailviewBedroomHeatingVC()

@property (strong) VEIFStaticHorizontalSliderViewControllerHeating *svc;
@property (weak, nonatomic) IBOutlet UIPickerView *heatingWheel;
@property (strong, nonatomic, readwrite) NSArray *heatingWheelItems; // WICHTIG: outlets: dataSource & delegate!
@property (nonatomic, assign) int currentHeatingValue;
@property (nonatomic, assign) int currentIndex;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewWheelFrame;

@end

@implementation SHDetailviewBedroomHeatingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // init array of heating
        self.heatingWheelItems = [[NSArray alloc] initWithObjects:@"15° Celsius", @"16° Celsius", @"17° Celsius", @"18° Celsius", @"19° Celsius", @"20° Celsius", @"21° Celsius", @"22° Celsius", @"23° Celsius", @"24° Celsius", @"25° Celsius", nil];
        //[self.heatingWheel selectRow:1 inComponent:0 animated:NO];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.svc =
    [[VEIFStaticHorizontalSliderViewControllerHeating alloc] init];
    self.svc.sDelegate = self;
    
    SHIconWithTitle *icon1 = [[SHIconWithTitle alloc] init];
    icon1.icon = [UIImage imageNamed:@"SH_ICON_heating_star"];
    icon1.title = @"Anti-Frost";
    
    SHIconWithTitle *icon2 = [[SHIconWithTitle alloc] init];
    icon2.icon = [UIImage imageNamed:@"SH_ICON_heating_manuell"];
    icon2.title = @"Manuell";
    
    SHIconWithTitle *icon3 = [[SHIconWithTitle alloc] init];
    icon3.icon = [UIImage imageNamed:@"SH_ICON_heating_moon"];
    icon3.title = @"Nacht";
    
    SHIconWithTitle *icon4 = [[SHIconWithTitle alloc] init];
    icon4.icon = [UIImage imageNamed:@"SH_ICON_heating_sun"];
    icon4.title = @"Tag";
    
    self.svc.icons = [[NSArray alloc] initWithObjects:icon1, icon2, icon3, icon4, nil];
    
    UIView *sliderView = self.svc.view;
    
    [sliderView setBounds:CGRectMake(0, 0, sliderView.frame.size.width, sliderView.frame.size.height)];
    [sliderView setCenter:CGPointMake(866, 500)];
    //[self.view addSubview:sliderViewSelected];
    //[self.view sendSubviewToBack:sliderView];
    [self.view addSubview:sliderView];
    
    // set pickerwheel of heating to invisible / visible
    if (self.currentIndex == 1)
    {
        NSLog(@"show 'manuell' of heating");
        [self.heatingWheel setHidden:NO];
        [self.imageViewWheelFrame setHidden:NO];
    } else
    {
        [self.heatingWheel setHidden:YES];
        [self.imageViewWheelFrame setHidden:YES];
    }
    
    // reading stored index
    self.currentIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentHeatingIndexBedroom"] intValue];
    NSNumber *currentIdxNumber = [[NSNumber alloc] init];
    currentIdxNumber = [NSNumber numberWithFloat:self.currentIndex];
    [self.svc setPredefinedValue:currentIdxNumber];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // reading stored temperature
    self.currentHeatingValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentHeatingValueBedroom"] integerValue];
    // reading stored row
    int currRow = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentRowValueBedroom"] integerValue];
    [self.heatingWheel selectRow:currRow inComponent:0 animated:NO];
    
    // reading stored index
    self.currentIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentHeatingIndexBedroom"] intValue];
    NSNumber *currentIdxNumber = [[NSNumber alloc] init];
    currentIdxNumber = [NSNumber numberWithFloat:self.currentIndex];
    [self.svc setPredefinedValue:currentIdxNumber];
    
    // set pickerwheel of heating to invisible / visible
    if (self.currentIndex == 1)
    {
        NSLog(@"show 'manuell' of heating");
        [self.heatingWheel setHidden:NO];
        [self.imageViewWheelFrame setHidden:NO];
    } else
    {
        [self.heatingWheel setHidden:YES];
        [self.imageViewWheelFrame setHidden:YES];
    }
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
    // storage of index
    self.currentIndex = index;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndex] forKey:@"currentHeatingIndexBedroom"];
    
    if (index == 1)
    {
        [self.heatingWheel setHidden:NO];
        [self.imageViewWheelFrame setHidden:NO];
    } else
    {
        [self.heatingWheel setHidden:YES];
        [self.imageViewWheelFrame setHidden:YES];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.heatingWheelItems count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.heatingWheelItems objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row == 0)
    {
        self.currentHeatingValue = 15;
    } else if (row == 1)
    {
        self.currentHeatingValue = 16;
    } else if (row == 2)
    {
        self.currentHeatingValue = 17;
    } else if (row == 3)
    {
        self.currentHeatingValue = 18;
    } else if (row == 4)
    {
        self.currentHeatingValue = 19;
    } else if (row == 5)
    {
        self.currentHeatingValue = 20;
    } else if (row == 6)
    {
        self.currentHeatingValue = 21;
    } else if (row == 7)
    {
        self.currentHeatingValue = 22;
    } else if (row == 8)
    {
        self.currentHeatingValue = 23;
    } else if (row == 9)
    {
        self.currentHeatingValue = 24;
    } else if (row == 10)
    {
        self.currentHeatingValue = 25;
    }
    
    // storage of temperature
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentHeatingValue] forKey:@"currentHeatingValueBedroom"];
    // storage of row
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:row] forKey:@"currentRowValueBedroom"];
}

@end
