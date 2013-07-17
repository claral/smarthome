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
@property (weak, nonatomic) IBOutlet UIPickerView *heatingWheel;
@property (strong, nonatomic, readwrite) NSArray *heatingWheelItems; // WICHTIG: outlets: dataSource & delegate!
@property (nonatomic, assign) int currentHeatingValue;

@end

@implementation SHDetailviewLivingroomHeatingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // init array of heating
        self.heatingWheelItems = [[NSArray alloc] initWithObjects:@"15° Celsius", @"16° Celsius", @"17° Celsius", @"18° Celsius", @"19° Celsius", @"20° Celsius", @"21° Celsius", @"22° Celsius", @"23° Celsius", @"24° Celsius", @"25° Celsius", nil];
        [self.heatingWheel selectRow:1 inComponent:0 animated:NO];
        
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

    // set pickerwheel of heating to invisible
    [self.heatingWheel setHidden:YES];
    
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
    if (index == 1)
    {
        NSLog(@"show 'manuell' of heating");
        [self.heatingWheel setHidden:NO];
    } else
    {
        [self.heatingWheel setHidden:YES];
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
    
    //NSString *object = [self.heatingWheelItems objectAtIndex:row];
    //NSLog(@"%@", object);
}

@end
