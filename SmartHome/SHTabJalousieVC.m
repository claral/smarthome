//
//  SHTabJalousieVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHTabJalousieVC.h"
#import "SVSegmentedControl.h"
#import "SVSegmentedThumb.h"

@interface SHTabJalousieVC ()

@property (nonatomic, assign) int currentIndexValue_WholeHouse;
@property (nonatomic, assign) int currentIndexValue_Bedroom;
@property (nonatomic, assign) int currentIndexValue_Bathroom;
@property (nonatomic, assign) int currentIndexValue_Kitchen;
@property (nonatomic, assign) int currentIndexValue_LivingRoom;
@property (nonatomic, assign) int currentIndexValue_Entrance;

@end

@implementation SHTabJalousieVC

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
    SVSegmentedControl *navSC_WholeHouse = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" ZU ", @"OFFEN", nil]];
    SVSegmentedControl *navSC_Bedroom = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" ZU ", @"OFFEN", nil]];
    SVSegmentedControl *navSC_Bathroom = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" ZU ", @"OFFEN", nil]];
    SVSegmentedControl *navSC_Kitchen = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" ZU ", @"OFFEN", nil]];
    SVSegmentedControl *navSC_LivingRoom = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" ZU ", @"OFFEN", nil]];
    SVSegmentedControl *navSC_Entrance = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" ZU ", @"OFFEN", nil]];
    
    
    
    // ----------
    // ON OFF whole house
    navSC_WholeHouse.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_WholeHouse = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_WholeHouse] forKey:@"currentIndexValueJalousieTabWholeHouse"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_WholeHouse setIndexToBeginWith:newIndex];
        
        NSInteger helperInt;
        if (self.currentIndexValue_WholeHouse == 0)// 1 = OFF
        {
            helperInt = 0;
        } else //if (self.currentIndexValue_WholeHouse == 1) // 0 = ON
        {
            helperInt = 1;
        }
        
        [navSC_Bedroom setSelectedSegmentIndex:helperInt animated:NO];
        [navSC_Bathroom setSelectedSegmentIndex:helperInt animated:NO];
        [navSC_Entrance setSelectedSegmentIndex:helperInt animated:NO];
        [navSC_Kitchen setSelectedSegmentIndex:helperInt animated:NO];
        [navSC_LivingRoom setSelectedSegmentIndex:helperInt animated:NO];
        
        self.currentIndexValue_Bedroom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bedroom] forKey:@"currentIndexValueJalousieTabBedroom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Bedroom setIndexToBeginWith:newIndex];

        self.currentIndexValue_Bathroom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bathroom] forKey:@"currentIndexValueJalousieTabBathroom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Bathroom setIndexToBeginWith:newIndex];
        
        self.currentIndexValue_Entrance = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Entrance] forKey:@"currentIndexValueJalousieTabEntrance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Entrance setIndexToBeginWith:newIndex];
        
        self.currentIndexValue_Kitchen = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Kitchen] forKey:@"currentIndexValueJalousieTabKitchen"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Kitchen setIndexToBeginWith:newIndex];
        
        self.currentIndexValue_LivingRoom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_LivingRoom] forKey:@"currentIndexValueJalousieTabLivingRoom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_LivingRoom setIndexToBeginWith:newIndex];
        
    };
    
    // reading stored index value
    self.currentIndexValue_WholeHouse = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabWholeHouse"] integerValue];
    
    // show ON OFF
    [navSC_WholeHouse setIndexToBeginWith:self.currentIndexValue_WholeHouse];
    [self.view addSubview:navSC_WholeHouse];
    navSC_WholeHouse.center = CGPointMake(930, 55);
    
    
    
    // ----------
    // ON OFF bedroom
    navSC_Bedroom.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_Bedroom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bedroom] forKey:@"currentIndexValueJalousieTabBedroom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Bedroom setIndexToBeginWith:newIndex];
    };
    // reading stored index value
    self.currentIndexValue_Bedroom = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabBedroom"] integerValue];
    
    // show ON OFF
    [navSC_Bedroom setIndexToBeginWith:self.currentIndexValue_Bedroom];
    [self.view addSubview:navSC_Bedroom];
    navSC_Bedroom.center = CGPointMake(280, 500);
    
    
    
    // ----------
    // ON OFF bathroom
    navSC_Bathroom.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_Bathroom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bathroom] forKey:@"currentIndexValueJalousieTabBathroom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Bathroom setIndexToBeginWith:newIndex];
    };
    // reading stored index value
    self.currentIndexValue_Bathroom = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabBathroom"] integerValue];
    
    // show ON OFF
    [navSC_Bathroom setIndexToBeginWith:self.currentIndexValue_Bathroom];
    [self.view addSubview:navSC_Bathroom];
    navSC_Bathroom.center = CGPointMake(774, 500);
    
    
    
    // ----------
    // ON OFF kitchen
    navSC_Kitchen.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_Kitchen = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Kitchen] forKey:@"currentIndexValueJalousieTabKitchen"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Kitchen setIndexToBeginWith:newIndex];
    };
    // reading stored index value
    self.currentIndexValue_Kitchen = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabKitchen"] integerValue];
    
    // show ON OFF
    [navSC_Kitchen setIndexToBeginWith:self.currentIndexValue_Kitchen];
    [self.view addSubview:navSC_Kitchen];
    navSC_Kitchen.center = CGPointMake(720, 250);
    
    
    
    // ----------
    // ON OFF living room
    navSC_LivingRoom.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_LivingRoom = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_LivingRoom] forKey:@"currentIndexValueJalousieTabLivingRoom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_LivingRoom setIndexToBeginWith:newIndex];
    };
    // reading stored index value
    self.currentIndexValue_LivingRoom = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabLivingRoom"] integerValue];
    
    // show ON OFF
    [navSC_LivingRoom setIndexToBeginWith:self.currentIndexValue_LivingRoom];
    [self.view addSubview:navSC_LivingRoom];
    navSC_LivingRoom.center = CGPointMake(350, 250);
    
    
    
    // ----------
    // ON OFF entrance
    navSC_Entrance.changeHandler = ^(NSUInteger newIndex) {
        
        // storage of currentindex
        self.currentIndexValue_Entrance = newIndex;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Entrance] forKey:@"currentIndexValueJalousieTabEntrance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Entrance setIndexToBeginWith:newIndex];
    };
    // reading stored index value
    self.currentIndexValue_Entrance = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabEntrance"] integerValue];
    
    // show ON OFF
    [navSC_Entrance setIndexToBeginWith:self.currentIndexValue_Entrance];
    [self.view addSubview:navSC_Entrance];
    navSC_Entrance.center = CGPointMake(542, 500);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
