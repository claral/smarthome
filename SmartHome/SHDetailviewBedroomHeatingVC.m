//
//  SHDetailviewBedroomHeatingVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewBedroomHeatingVC.h"

@interface SHDetailviewBedroomHeatingVC ()

@property (weak, nonatomic) IBOutlet UIPickerView *heatingWheel;
@property (strong, nonatomic, readwrite) NSArray *heatingWheelItems; // WICHTIG: outlets: dataSource & delegate!
@property (nonatomic, assign) int currentHeatingValue;

@end

@implementation SHDetailviewBedroomHeatingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // init array
         self.heatingWheelItems = [[NSArray alloc] initWithObjects:@"15° Celsius", @"16° Celsius", @"17° Celsius", @"18° Celsius", @"19° Celsius", @"20° Celsius", @"21° Celsius", @"22° Celsius", @"23° Celsius", @"24° Celsius", @"25° Celsius", nil];
        [self.heatingWheel selectRow:1 inComponent:0 animated:NO];
        
        /*// storage of temperature
        //NSInteger currentCelsius = self.currentHeatingValue;
        //currentCelsius = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentCelsius"] integerValue];
        
        NSNumber *currentCelsius = [NSNumber numberWithInt:self.currentHeatingValue];
        currentCelsius = [[NSUserDefaults standardUserDefaults] valueForKey:@"currentCelsius"];*/
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
