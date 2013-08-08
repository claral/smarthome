//
//  SHTabLightVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHTabLightVC.h"
#import "SVSegmentedControl.h"
#import "SVSegmentedThumb.h"

@interface SHTabLightVC ()

@property (nonatomic, assign) int currentIndexValue_WholeHouse;
@property (nonatomic, assign) int currentIndexValue_Bedroom;
@property (nonatomic, assign) int currentIndexValue_Bathroom;
@property (nonatomic, assign) int currentIndexValue_Kitchen;
@property (nonatomic, assign) int currentIndexValue_LivingRoom;
@property (nonatomic, assign) int currentIndexValue_Entrance;
@property (nonatomic, assign) int currentIndexValue_Basement;

@end

@implementation SHTabLightVC

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
	// Do any additional setup after loading the view.
    
    
    
    // init all ON OFFs
    SVSegmentedControl *navSC_WholeHouse = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    SVSegmentedControl *navSC_Bedroom = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    SVSegmentedControl *navSC_Bathroom = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    SVSegmentedControl *navSC_Kitchen = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    SVSegmentedControl *navSC_LivingRoom = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    SVSegmentedControl *navSC_Entrance = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    SVSegmentedControl *navSC_Basement = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    
    
    
    // ----------
    // ON OFF whole house
    navSC_WholeHouse.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_WholeHouse = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_WholeHouse] forKey:@"currentIndexValueLightTabWholeHouse"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_WholeHouse setIndexToBeginWith:newIndex];
        
        NSInteger helperInt;
        if (self.currentIndexValue_WholeHouse == 0) // 0 = OFF
        {
            helperInt = 0;
        } else // if (self.currentIndexValue_WholeHouse == 0) // 1 = ON
        {
            helperInt = 1;
        }
        
        [navSC_Bedroom setSelectedSegmentIndex:helperInt animated:NO];
        [navSC_Basement setSelectedSegmentIndex:helperInt animated:NO];
        [navSC_Bathroom setSelectedSegmentIndex:helperInt animated:NO];
        [navSC_Entrance setSelectedSegmentIndex:helperInt animated:NO];
        [navSC_Kitchen setSelectedSegmentIndex:helperInt animated:NO];
        [navSC_LivingRoom setSelectedSegmentIndex:helperInt animated:NO];
        
        // storage of currentindex
        self.currentIndexValue_Bedroom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bedroom] forKey:@"currentIndexValueLightBedroom"];
        [navSC_Bedroom setIndexToBeginWith:newIndex];
        
        self.currentIndexValue_Basement = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Basement] forKey:@"currentIndexValueLightBasement"];
        [navSC_Basement setIndexToBeginWith:newIndex];
        
        self.currentIndexValue_Bathroom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bathroom] forKey:@"currentIndexValueLightBathroom"];
        [navSC_Bathroom setIndexToBeginWith:newIndex];
        
        self.currentIndexValue_Entrance = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Entrance] forKey:@"currentIndexValueLightEntrance"];
        [navSC_Entrance setIndexToBeginWith:newIndex];
        
        self.currentIndexValue_Kitchen = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Kitchen] forKey:@"currentIndexValueLightKitchen"];
        [navSC_Kitchen setIndexToBeginWith:newIndex];
        
        self.currentIndexValue_LivingRoom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_LivingRoom] forKey:@"currentIndexValueLightLivingRoom"];
        [navSC_LivingRoom setIndexToBeginWith:newIndex];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    };
    
    // reading stored index value
    self.currentIndexValue_WholeHouse = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueLightTabWholeHouse"] integerValue];
    [navSC_WholeHouse setIndexToBeginWith:self.currentIndexValue_WholeHouse];
    
    [self.view addSubview:navSC_WholeHouse];
    navSC_WholeHouse.center = CGPointMake(930, 55);
    
    
    
    // ----------
    // ON OFF bedroom
    navSC_Bedroom.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_Bedroom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bedroom] forKey:@"currentIndexValueLightBedroom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [navSC_Bedroom setIndexToBeginWith:newIndex];
    };
    
    // reading stored index value
    self.currentIndexValue_Bedroom = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueLightBedroom"] integerValue];
    [navSC_Bedroom setIndexToBeginWith:self.currentIndexValue_Bedroom];
    
    [self.view addSubview:navSC_Bedroom];
    navSC_Bedroom.center = CGPointMake(280, 500);
    
    
    
    // ----------
    // ON OFF bathroom
    navSC_Bathroom.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_Bathroom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bathroom] forKey:@"currentIndexValueLightBathroom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [navSC_Bathroom setIndexToBeginWith:newIndex];
    };
    
    // reading stored index value
    self.currentIndexValue_Bathroom = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueLightBathroom"] integerValue];
    [navSC_Bathroom setIndexToBeginWith:self.currentIndexValue_Bathroom];
    
    [self.view addSubview:navSC_Bathroom];
    navSC_Bathroom.center = CGPointMake(770, 500);
    
    
    
    // ----------
    // ON OFF kitchen
    navSC_Kitchen.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_Kitchen = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Kitchen] forKey:@"currentIndexValueLightKitchen"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [navSC_Kitchen setIndexToBeginWith:newIndex];
    };
    
    // reading stored index value
    self.currentIndexValue_Kitchen = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueLightKitchen"] integerValue];
    [navSC_Kitchen setIndexToBeginWith:self.currentIndexValue_Kitchen];
    
    [self.view addSubview:navSC_Kitchen];
    navSC_Kitchen.center = CGPointMake(720, 250);
    
    
    
    // ----------
    // ON OFF living room
    navSC_LivingRoom.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_LivingRoom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_LivingRoom] forKey:@"currentIndexValueLightLivingRoom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [navSC_LivingRoom setIndexToBeginWith:newIndex];
    };
    
    // reading stored index value
    self.currentIndexValue_LivingRoom = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueLightLivingRoom"] integerValue];
    [navSC_LivingRoom setIndexToBeginWith:self.currentIndexValue_LivingRoom];
    
    [self.view addSubview:navSC_LivingRoom];
    navSC_LivingRoom.center = CGPointMake(350, 250);
    
    
    
    // ----------
    // ON OFF entrance
    navSC_Entrance.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_Entrance = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Entrance] forKey:@"currentIndexValueLightEntrance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [navSC_Entrance setIndexToBeginWith:newIndex];
    };
    
    // reading stored index value
    self.currentIndexValue_Entrance = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueLightEntrance"] integerValue];
    [navSC_Entrance setIndexToBeginWith:self.currentIndexValue_Entrance];
    
    [self.view addSubview:navSC_Entrance];
    navSC_Entrance.center = CGPointMake(540, 500);
    
    

    // ----------
    // ON OFF basement
    navSC_Basement.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_Basement = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Basement] forKey:@"currentIndexValueLightBasement"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [navSC_Basement setIndexToBeginWith:newIndex];
    };
    
    // reading stored index value
    self.currentIndexValue_Basement = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueLightBasement"] integerValue];
    [navSC_Basement setIndexToBeginWith:self.currentIndexValue_Basement];
    
    [self.view addSubview:navSC_Basement];
    navSC_Basement.center = CGPointMake(425, 600);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
