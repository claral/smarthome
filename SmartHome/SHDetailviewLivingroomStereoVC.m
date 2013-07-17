//
//  SHDetailviewLivingroomStereoVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewLivingroomStereoVC.h"

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
    
    // storage of volume
    //NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    //[standardUserDefaults setFloat:self.currentVolumeValue forKey:@"floatVolKey"];
    //float currentVol = [standardUserDefaults floatForKey:@"floatVolKey"];
    /*[[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.currentVolumeValue] forKey:@"currentVolumeValue"];
    float currentVol = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentVolumeValue"] floatValue];*/
    //self.sliderVolume.value = currentVol;
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
    self.currentVolumeValue = [sender value] * 100;
    self.labelVolume.text = [NSString stringWithFormat:@"%.1f", self.currentVolumeValue];
}

@end
