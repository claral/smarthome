//
//  SHDetailviewBedroomSoundVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewBedroomSoundVC.h"

@interface SHDetailviewBedroomSoundVC ()

@property (nonatomic, assign) float currentVolumeValue;
@property (weak, nonatomic) IBOutlet UISlider *sliderVolume;
@property (weak, nonatomic) IBOutlet UILabel *labelVolumeValue;
- (IBAction)sliderVolumeChange:(UISlider *)sender;

@end

@implementation SHDetailviewBedroomSoundVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // reading stored volume
    self.currentVolumeValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentVolumeValue"] floatValue];
    self.sliderVolume.value = self.currentVolumeValue;
    self.labelVolumeValue.text = [NSString stringWithFormat:@"%.1f", self.currentVolumeValue * 100];
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

- (IBAction)sliderVolumeChange:(UISlider *)sender
{
    self.labelVolumeValue.text = NULL;
    self.currentVolumeValue = [sender value];
    self.labelVolumeValue.text = [NSString stringWithFormat:@"%.1f", self.currentVolumeValue * 100];
    // storage of volume
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.currentVolumeValue] forKey:@"currentVolumeValue"];
}

@end
