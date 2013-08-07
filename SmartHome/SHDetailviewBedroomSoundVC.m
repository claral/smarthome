//
//  SHDetailviewBedroomSoundVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewBedroomSoundVC.h"
#import "SVSegmentedControl.h"
#import "SVSegmentedThumb.h"

@interface SHDetailviewBedroomSoundVC ()

@property (weak, nonatomic) IBOutlet UISlider *sliderVolume;
@property (weak, nonatomic) IBOutlet UILabel *labelVolume;
@property (weak, nonatomic) IBOutlet UILabel *labelVolumeHelper;
@property (nonatomic, assign) float currentVolumeValue;

@property (weak, nonatomic) IBOutlet UIButton *buttonSoundMute;
@property (nonatomic,assign) int buttonWithImageMute;// 1 = sound, 0 = mute

@property (nonatomic, assign) int buttonWithImagePlay; // 1 = play, 0 = pause
@property (weak, nonatomic) IBOutlet UIButton *buttonPlayPause;

- (IBAction)sliderVolumeChange:(UISlider *)sender;
- (IBAction)changePlayPause:(id)sender;
- (IBAction)changeSoundMute:(id)sender;


@property (nonatomic, assign) int currentIndexValue;

@end

@implementation SHDetailviewBedroomSoundVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.currentVolumeValue == 0) {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_mute.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 0;
    } else{
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_volume.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 1;
    }
    
    //tap function beim slider
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)];
    [self.sliderVolume addGestureRecognizer:gr];
}

- (void)sliderTapped:(UIGestureRecognizer *)g
{
    UISlider* s = (UISlider*)g.view;
    if (s.highlighted)
        return; // tap on thumb, let slider deal with it
    CGPoint pt = [g locationInView: s];
    CGFloat percentage = pt.x / s.bounds.size.width;
    CGFloat delta = percentage * (s.maximumValue - s.minimumValue);
    CGFloat value = s.minimumValue + delta;
    [s setValue:value animated:YES];
    
    self.currentVolumeValue = value;
    
    // storage of volume
    if (self.currentVolumeValue == 0) {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_mute.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 0;
    } else{
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_volume.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 1;
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.currentVolumeValue] forKey:@"currentVolumeValue"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.buttonWithImageMute] forKey:@"currentButtonWithImageMuteValueStereoLivingRoom"];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // reading stored volume
    self.currentVolumeValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentVolumeValue"] floatValue];
    self.sliderVolume.value = self.currentVolumeValue;
    
    // reading stored button image
    int buttonWithImageMuteHelper = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentButtonWithImageMuteValueStereoLivingRoom"] integerValue];
    if (buttonWithImageMuteHelper == 0)
    {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_mute.png"] forState:UIControlStateNormal];
        [self.sliderVolume setValue:(0.0f)];
    } else if (buttonWithImageMuteHelper == 1){
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_volume.png"] forState:UIControlStateNormal];
        [self.sliderVolume setValue:self.currentVolumeValue];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)closeDetailView:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)backToSH:(id)sender
{
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)sliderVolumeChange:(UISlider *)sender
{
    self.labelVolume.text = NULL;
    self.currentVolumeValue = [sender value];
    
    // storage of volume
    
    if (self.currentVolumeValue == 0) {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_mute.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 0;
    } else{
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_volume.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 1;
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.currentVolumeValue] forKey:@"currentVolumeValue"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.buttonWithImageMute] forKey:@"currentButtonWithImageMuteValueStereoLivingRoom"];
}

- (IBAction)changePlayPause:(id)sender
{
    if (self.buttonPlayPause.imageView.image == [UIImage imageNamed:@"SH_ICON_play.png"])
    {
        [self.buttonPlayPause setImage:[UIImage imageNamed:@"SH_ICON_pause.png"] forState:UIControlStateNormal];
        self.buttonWithImagePlay = 0;
    } else {
        [self.buttonPlayPause setImage:[UIImage imageNamed:@"SH_ICON_play.png"] forState:UIControlStateNormal];
        self.buttonWithImagePlay = 1;
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.buttonWithImagePlay] forKey:@"currentButtonWithImagePlayValueStereoLivingRoom"];
}

- (IBAction)changeSoundMute:(id)sender {
    if (self.buttonSoundMute.imageView.image == [UIImage imageNamed:@"SH_ICON_volume.png"])
    {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_mute.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 0;
        [self.sliderVolume setValue:(0.0f)];
    } else {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_volume.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 1;
        [self.sliderVolume setValue:self.currentVolumeValue];
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.buttonWithImageMute] forKey:@"currentButtonWithImageMuteValueStereoLivingRoom"];
}


@end
