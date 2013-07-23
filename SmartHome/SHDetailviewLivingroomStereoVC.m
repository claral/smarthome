//
//  SHDetailviewLivingroomStereoVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewLivingroomStereoVC.h"
#import "SVSegmentedThumb.h"
#import "SVSegmentedControl.h"

@interface SHDetailviewLivingroomStereoVC ()

@property (weak, nonatomic) IBOutlet UISlider *sliderVolume;
@property (weak, nonatomic) IBOutlet UILabel *labelVolume;
@property (nonatomic, assign) float currentVolumeValue;
- (IBAction)sliderVolumeChange:(UISlider *)sender;

@end

@implementation SHDetailviewLivingroomStereoVC

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
    
    // ONOFFSwitch
    // Hinzufuegen von Feldern: @"Text". (Text betitelt Feld)
    SVSegmentedControl *navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"OFF", @"ON", nil]];
    navSC.changeHandler = ^(NSUInteger newIndex) {
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
    };
    
    [self.view addSubview:navSC];
    
    navSC.center = CGPointMake((self.view.frame.size.width*1)/3, (self.view.frame.size.height*1)/2);  //CGPointMake(160, 70). Ausrichten Des ToggleButtons im IPad Bildschirm selber
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // reading stored volume
    self.currentVolumeValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentVolumeValue"] floatValue];
    self.sliderVolume.value = self.currentVolumeValue;
    self.labelVolume.text = [NSString stringWithFormat:@"%.1f", self.currentVolumeValue * 100];
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

- (IBAction)sliderVolumeChange:(UISlider *)sender
{
    self.labelVolume.text = NULL;
    self.currentVolumeValue = [sender value];
    self.labelVolume.text = [NSString stringWithFormat:@"%.1f", self.currentVolumeValue * 100];
    // storage of volume
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.currentVolumeValue] forKey:@"currentVolumeValue"];
}

@end
