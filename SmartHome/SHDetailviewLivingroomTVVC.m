//
//  SHDetailviewLivingroomTVVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewLivingroomTVVC.h"
#import "SVSegmentedControl.h"
#import "SVSegmentedThumb.h"

@interface SHDetailviewLivingroomTVVC ()

@property (strong, nonatomic, readwrite) NSArray *arrayTVChanels;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerWheelTVChanels;
@property (nonatomic, assign) int currentTVChanel;
//@property (weak, nonatomic) IBOutlet UILabel *labelCurrentTVChanel;
@property (weak, nonatomic) IBOutlet UILabel *labelTVChannelHelper;

@property (nonatomic, assign) float currentVolumeValue;
@property (weak, nonatomic) IBOutlet UISlider *sliderTVVolume;
@property (weak, nonatomic) IBOutlet UILabel *labelVolume;
@property (weak, nonatomic) IBOutlet UILabel *labelVolumeHelper;

@property (weak, nonatomic) IBOutlet UIButton *buttonSoundMute;
@property (nonatomic,assign) int buttonWithImageMute;// 1 = sound, 0 = mute

- (IBAction)sliderVolumeChange:(id)sender;
- (IBAction)changeSoundMute:(id)sender;

@property (nonatomic, assign) int currentIndexValue;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewWheelFrame;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewVolumeTriangle;

@end

@implementation SHDetailviewLivingroomTVVC


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
    self.currentTVChanel = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentTVChanelLivingRoom"] integerValue];
    
    // reading stored row
    int currRow = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentRowValueTVLivingRoom"] integerValue];
    [self.pickerWheelTVChanels selectRow:currRow inComponent:0 animated:NO];
    
    // reading stored volume
    self.currentVolumeValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentTVVolumeValueLivingRoom"] floatValue];
    self.sliderTVVolume.value = self.currentVolumeValue;
    
    // reading stored button image
    int buttonWithImageMuteHelper = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentButtonWithImageMuteValueTVLivingRoom"] integerValue];
    if (buttonWithImageMuteHelper == 0)
    {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_mute.png"] forState:UIControlStateNormal];
        [self.sliderTVVolume setValue:(0.0f)];
    } else if (buttonWithImageMuteHelper == 1){
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_volume.png"] forState:UIControlStateNormal];
        [self.sliderTVVolume setValue:self.currentVolumeValue];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.currentVolumeValue == 0) {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_mute.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 0;
    } else{
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_volume.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 1;
    }
    
    // ONOFFSwitch
    // Hinzufuegen von Feldern: @"Text". (Text betitelt Feld)
    SVSegmentedControl *navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    navSC.changeHandler = ^(NSUInteger newIndex) {
        __block NSUInteger index = navSC.selectedSegmentIndex;
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
        
        // storage of currentindex
        self.currentIndexValue = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue] forKey:@"currentIndexValueTVLivingRoom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC setIndexToBeginWith:index];
        
        
        self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueTVLivingRoom"] integerValue];
        int returnIdxVal;
        if (self.currentIndexValue == 0) // off
        {
            returnIdxVal = [navSC setIndexToBeginWith:1];
            [self.pickerWheelTVChanels setHidden:NO];
            [self.sliderTVVolume setHidden:NO];
            [self.labelVolume setHidden:NO];
            [self.labelVolumeHelper setHidden:NO];
            [self.labelTVChannelHelper setHidden:NO];
            [self.imageViewWheelFrame setHidden:NO];
            [self.imageViewVolumeTriangle setHidden:NO];
            [self.buttonSoundMute setHidden:NO];
        } else if (self.currentIndexValue == 1) // on
        {
            returnIdxVal = [navSC setIndexToBeginWith:0];
            [self.pickerWheelTVChanels setHidden:YES];
            [self.sliderTVVolume setHidden:YES];
            [self.labelVolume setHidden:YES];
            [self.labelVolumeHelper setHidden:YES];
            [self.labelTVChannelHelper setHidden:YES];
            [self.imageViewWheelFrame setHidden:YES];
            [self.imageViewVolumeTriangle setHidden:YES];
            [self.buttonSoundMute setHidden:YES];
        }
    };
    
    
    
    // reading stored index value
    self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueTVLivingRoom"] integerValue];
    int returnIdxVal;
    
    // show ON OFF // from living room view to tv view
    if (self.currentIndexValue == 0) // on
    {
        // set stored index
        returnIdxVal = [navSC setIndexToBeginWith:1];
        [self.pickerWheelTVChanels setHidden:NO];
        [self.sliderTVVolume setHidden:NO];
        [self.labelVolume setHidden:NO];
        [self.labelVolumeHelper setHidden:NO];
        [self.labelTVChannelHelper setHidden:NO];
        [self.imageViewWheelFrame setHidden:NO];
        [self.imageViewVolumeTriangle setHidden:NO];
        [self.buttonSoundMute setHidden:NO];
    } else if (self.currentIndexValue == 1) // off
    {
        // set stored index
        returnIdxVal = [navSC setIndexToBeginWith:0];
        [self.pickerWheelTVChanels setHidden:YES];
        [self.sliderTVVolume setHidden:YES];
        [self.labelVolume setHidden:YES];
        [self.labelVolumeHelper setHidden:YES];
        [self.labelTVChannelHelper setHidden:YES];
        [self.imageViewWheelFrame setHidden:YES];
        [self.imageViewVolumeTriangle setHidden:YES];
        [self.buttonSoundMute setHidden:YES];
    }
    
    
    
    [self.view addSubview:navSC];
    navSC.center = CGPointMake(930, 55);
    
    //tap function beim slider
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)];
    [self.sliderTVVolume addGestureRecognizer:gr];

    
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
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.currentVolumeValue] forKey:@"currentTVVolumeValueLivingRoom"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.buttonWithImageMute] forKey:@"currentButtonWithImageMuteValueTVLivingRoom"];
    
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
    /*if (self.labelTVChannel.text.length == 2)
    {
        NSLog(@"channel should consist of just 2 items - number of items: %d", self.labelTVChannel.text.length);
    } else {
        NSString *digit = sender.currentTitle;
        self.labelTVChannel.text = [self.labelTVChannel.text stringByAppendingString:digit];
    }*/
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
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentTVChanel] forKey:@"currentTVChanelLivingRoom"];
    // storage of row
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:row] forKey:@"currentRowValueTVLivingRoom"];
    
//    self.labelCurrentTVChanel.text = [self.arrayTVChanels objectAtIndex:row];
}

- (IBAction)sliderVolumeChange:(UISlider *)sender
{
    self.labelVolume.text = NULL;
    self.currentVolumeValue = [sender value];
//    self.labelVolume.text = [NSString stringWithFormat:@"%.1f", self.currentVolumeValue * 100];
    
    if (self.currentVolumeValue == 0) {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_mute.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 0;
    } else{
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_volume.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 1;
    }

    // storage of volume
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.currentVolumeValue] forKey:@"currentTVVolumeValueLivingRoom"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.buttonWithImageMute] forKey:@"currentButtonWithImageMuteValueTVLivingRoom"];
}

- (IBAction)changeSoundMute:(id)sender {
    if (self.buttonSoundMute.imageView.image == [UIImage imageNamed:@"SH_ICON_volume.png"])
    {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_mute.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 0;
        [self.sliderTVVolume setValue:(0.0f)];
    } else {
        [self.buttonSoundMute setImage:[UIImage imageNamed:@"SH_ICON_volume.png"] forState:UIControlStateNormal];
        self.buttonWithImageMute = 1;
        [self.sliderTVVolume setValue:self.currentVolumeValue];
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:self.buttonWithImageMute] forKey:@"currentButtonWithImageMuteValueTVLivingRoom"];
}

@end
