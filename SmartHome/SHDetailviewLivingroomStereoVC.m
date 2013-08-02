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
@property (weak, nonatomic) IBOutlet UILabel *labelVolumeHelper;
@property (nonatomic, assign) float currentVolumeValue;

@property (weak, nonatomic) IBOutlet UIButton *buttonSoundMute;
@property (nonatomic,assign) int buttonWithImageMute;// 1 = sound, 0 = mute

@property (nonatomic, assign) int buttonWithImagePlay; // 1 = play, 0 = pause
@property (weak, nonatomic) IBOutlet UIButton *buttonPlayPause;

//@property (weak, nonatomic) IBOutlet UIPickerView *pickerWheelSongs;
//@property (strong, nonatomic, readwrite) NSArray *arraySongs;
//@property (weak, nonatomic) IBOutlet UILabel *labelSongTitle;
//@property (nonatomic, assign) int currentSong;
- (IBAction)sliderVolumeChange:(UISlider *)sender;
- (IBAction)changePlayPause:(id)sender;
- (IBAction)changeSoundMute:(id)sender;


@property (nonatomic, assign) int currentIndexValue;

@end

@implementation SHDetailviewLivingroomStereoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        /*self.arraySongs = [[NSArray alloc] initWithObjects:@"Avicii - Wake Me Up", @"Crystal Castles - Empathy", @"Iggy Pop - The Passenger", @"Joris Delacroix - Aire France", @"Marteria - Lila Wolken", @"Milkey Chance - Stolen Dance", @"Tom Odell - Another Love", nil];*/
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // ONOFFSwitch
    // Hinzufuegen von Feldern: @"Text". (Text betitelt Feld)
    /*SVSegmentedControl *navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    navSC.changeHandler = ^(NSUInteger newIndex) {
        __block NSUInteger index = navSC.selectedSegmentIndex;
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
        
        // storage of currentindex
        self.currentIndexValue = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue] forKey:@"currentIndexValueStereoLivingRoom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC setIndexToBeginWith:index];
        
        
        self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueStereoLivingRoom"] integerValue];
        int returnIdxVal;
        if (self.currentIndexValue == 0) // off
        {
            returnIdxVal = [navSC setIndexToBeginWith:1];
            [self.pickerWheelSongs setHidden:NO];
            [self.sliderVolume setHidden:NO];
            [self.labelVolume setHidden:NO];
            [self.labelSongTitle setHidden:NO];
            [self.labelVolumeHelper setHidden:NO];
            [self.buttonPlayPause setHidden:NO];
        } else if (self.currentIndexValue == 1) // on
        {
            returnIdxVal = [navSC setIndexToBeginWith:0];
            [self.pickerWheelSongs setHidden:YES];
            [self.sliderVolume setHidden:YES];
            [self.labelVolume setHidden:YES];
            [self.labelSongTitle setHidden:YES];
            [self.labelVolumeHelper setHidden:YES];
            [self.buttonPlayPause setHidden:YES];
        }
    };
    
    
    // reading stored index value
    self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueStereoLivingRoom"] integerValue];
    int returnIdxVal;
    
    // show ON OFF // from entrance view to whirlpool view // TODOOO
    if (self.currentIndexValue == 0) // on
    {
        // set stored index
        returnIdxVal = [navSC setIndexToBeginWith:1];
        [self.pickerWheelSongs setHidden:NO];
        [self.sliderVolume setHidden:NO];
        [self.labelVolume setHidden:NO];
        [self.labelSongTitle setHidden:NO];
        [self.labelVolumeHelper setHidden:NO];
        [self.buttonPlayPause setHidden:NO];
    } else if (self.currentIndexValue == 1) // off
    {
        // set stored index
        returnIdxVal = [navSC setIndexToBeginWith:0];
        [self.pickerWheelSongs setHidden:YES];
        [self.sliderVolume setHidden:YES];
        [self.labelVolume setHidden:YES];
        [self.labelSongTitle setHidden:YES];
        [self.labelVolumeHelper setHidden:YES];
        [self.buttonPlayPause setHidden:YES];
    }
    
    
    [self.view addSubview:navSC];
    navSC.center = CGPointMake(930, 55);*/
    
    if (self.currentVolumeValue == 0) {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_mute.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 0;
    } else{
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_volume.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 1;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // reading stored volume
    self.currentVolumeValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentVolumeValue"] floatValue];
    self.sliderVolume.value = self.currentVolumeValue;
//    self.labelVolume.text = [NSString stringWithFormat:@"%.1f", self.currentVolumeValue * 100];
    
    // reading stored song (label)
    /*self.currentSong = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentSongStereoLivingRoom"] integerValue];
    
    // reading stored row
    int currRow = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentRowValueStereoLivingRoom"] integerValue];
    [self.pickerWheelSongs selectRow:currRow inComponent:0 animated:NO];
    self.labelSongTitle.text = [self.arraySongs objectAtIndex:currRow];*/
    
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
//    self.labelVolume.text = [NSString stringWithFormat:@"%.1f", self.currentVolumeValue * 100];
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
