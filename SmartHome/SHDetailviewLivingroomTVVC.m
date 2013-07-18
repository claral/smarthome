//
//  SHDetailviewLivingroomTVVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewLivingroomTVVC.h"

@interface SHDetailviewLivingroomTVVC ()

@property (strong, nonatomic, readwrite) NSArray *arrayTVChanels;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerWheelTVChanels;
@property (nonatomic, assign) int currentTVChanel;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentTVChanel;

@property (nonatomic, assign) float currentVolumeValue;
@property (weak, nonatomic) IBOutlet UISlider *sliderTVVolume;
@property (weak, nonatomic) IBOutlet UILabel *labelVolume;
- (IBAction)sliderVolumeChange:(id)sender;

@end

@implementation SHDetailviewLivingroomTVVC

@synthesize labelTVChannel = _labelTVChannel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // init array
        self.arrayTVChanels = [[NSArray alloc] initWithObjects:@"01 ARD", @"02 ZDF", @"03 RTL", @"04 RTL II", @"05 Super RTL", @"06 SAT1", @"07 ProSieben", @"08 ProSieben HD", @"09 ProSieben Austria", @"10 Kabel1", @"11 VOX", @"12 ORF1", @"13 ORF2", @"14 MTV", @"15 Sport1", @"16 Eurosport", @"17 SKY", @"18 SKY Filme", @"19 SKY Disney", @"20 SKY Bundesliga", nil];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // reading stored temperature
    self.currentTVChanel = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentTVChanel"] integerValue];
    
    // reading stored row
    int currRow = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentRowValue"] integerValue];
    [self.pickerWheelTVChanels selectRow:currRow inComponent:0 animated:NO];
    self.labelCurrentTVChanel.text = [self.arrayTVChanels objectAtIndex:currRow];
    
    // reading stored volume
    self.currentVolumeValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentTVVolumeValue"] floatValue];
    self.sliderTVVolume.value = self.currentVolumeValue;
    self.labelVolume.text = [NSString stringWithFormat:@"%.1f", self.currentVolumeValue * 100];
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

- (IBAction)buttonChanelDisplay:(UIButton *)sender
{
    // TODO: change after 5 secs possible
    if (self.labelTVChannel.text.length == 2)
    {
        NSLog(@"channel should consist of just 2 items - number of items: %d", self.labelTVChannel.text.length);
    } else {
        NSString *digit = sender.currentTitle;
        self.labelTVChannel.text = [self.labelTVChannel.text stringByAppendingString:digit];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.arrayTVChanels count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.arrayTVChanels objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    int tmpRow = row;
    self.currentTVChanel = tmpRow;
    
    // storage of current chanel
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentTVChanel] forKey:@"currentTVChanel"];
    // storage of row
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:row] forKey:@"currentRowValue"];
    
    self.labelCurrentTVChanel.text = [self.arrayTVChanels objectAtIndex:row];
}

- (IBAction)sliderVolumeChange:(UISlider *)sender
{
    self.labelVolume.text = NULL;
    self.currentVolumeValue = [sender value];
    self.labelVolume.text = [NSString stringWithFormat:@"%.1f", self.currentVolumeValue * 100];
    // storage of volume
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.currentVolumeValue] forKey:@"currentTVVolumeValue"];
}

@end
