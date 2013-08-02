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
//@property (nonatomic, assign) int currentIndexValue_Basement;

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
    SVSegmentedControl *navSC_WholeHouse = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    SVSegmentedControl *navSC_Bedroom = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    SVSegmentedControl *navSC_Bathroom = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    SVSegmentedControl *navSC_Kitchen = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    SVSegmentedControl *navSC_LivingRoom = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    SVSegmentedControl *navSC_Entrance = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
//    SVSegmentedControl *navSC_Basement = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@" AUS ", @" EIN ", nil]];
    
    
    
    // ----------
    // ON OFF whole house
    navSC_WholeHouse.changeHandler = ^(NSUInteger newIndex) {
        __block NSUInteger index = navSC_WholeHouse.selectedSegmentIndex;
        
        // storage of currentindex
        self.currentIndexValue_WholeHouse = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_WholeHouse] forKey:@"currentIndexValueJalousieTabWholeHouse"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_WholeHouse setIndexToBeginWith:index];
        
        NSInteger helperInt;
        if (self.currentIndexValue_WholeHouse == 1)// 1 = OFF
        {
            helperInt = 0;
            [navSC_Bedroom setSelectedSegmentIndex:helperInt animated:NO];
//            [navSC_Basement setSelectedSegmentIndex:helperInt animated:NO];
            [navSC_Bathroom setSelectedSegmentIndex:helperInt animated:NO];
            [navSC_Entrance setSelectedSegmentIndex:helperInt animated:NO];
            [navSC_Kitchen setSelectedSegmentIndex:helperInt animated:NO];
            [navSC_LivingRoom setSelectedSegmentIndex:helperInt animated:NO];
        } else if (self.currentIndexValue_WholeHouse == 0) // 0 = ON
        {
            helperInt = 1;
            [navSC_Bedroom setSelectedSegmentIndex:helperInt animated:NO];
//            [navSC_Basement setSelectedSegmentIndex:helperInt animated:NO];
            [navSC_Bathroom setSelectedSegmentIndex:helperInt animated:NO];
            [navSC_Entrance setSelectedSegmentIndex:helperInt animated:NO];
            [navSC_Kitchen setSelectedSegmentIndex:helperInt animated:NO];
            [navSC_LivingRoom setSelectedSegmentIndex:helperInt animated:NO];
        }
        
        self.currentIndexValue_Bedroom = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bedroom] forKey:@"currentIndexValueJalousieTabBedroom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Bedroom setIndexToBeginWith:index];
//        
//        self.currentIndexValue_Basement = index;
//        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Basement] forKey:@"currentIndexValueJalousieTabBasement"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [navSC_Basement setIndexToBeginWith:index];
        
        self.currentIndexValue_Bathroom = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bathroom] forKey:@"currentIndexValueJalousieTabBathroom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Bathroom setIndexToBeginWith:index];
        
        self.currentIndexValue_Entrance = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Entrance] forKey:@"currentIndexValueJalousieTabEntrance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Entrance setIndexToBeginWith:index];
        
        self.currentIndexValue_Kitchen = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Kitchen] forKey:@"currentIndexValueJalousieTabKitchen"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Kitchen setIndexToBeginWith:index];
        
        self.currentIndexValue_LivingRoom = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_LivingRoom] forKey:@"currentIndexValueJalousieTabLivingRoom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_LivingRoom setIndexToBeginWith:index];
        
    };
    
    // reading stored index value
    self.currentIndexValue_WholeHouse = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabWholeHouse"] integerValue];
    
    // show ON OFF
    int returnIdxVal;
    if (self.currentIndexValue_WholeHouse == 0) // on
    {
        // set stored index
        returnIdxVal = [navSC_WholeHouse setIndexToBeginWith:1];
    } else if (self.currentIndexValue_WholeHouse == 1) // off
    {
        // set stored index
        returnIdxVal = [navSC_WholeHouse setIndexToBeginWith:0];
    }
    
    [self.view addSubview:navSC_WholeHouse];
    //navSC_WholeHouse.center = CGPointMake((self.view.frame.size.width*1)/3, self.view.frame.size.height/3);
    navSC_WholeHouse.center = CGPointMake(930, 55);
    
    
    
    // ----------
    // ON OFF bedroom
    navSC_Bedroom.changeHandler = ^(NSUInteger newIndex) {
        __block NSUInteger index = navSC_Bedroom.selectedSegmentIndex;
        
        // storage of currentindex
        self.currentIndexValue_Bedroom = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bedroom] forKey:@"currentIndexValueJalousieTabBedroom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Bedroom setIndexToBeginWith:index];
    };
    // reading stored index value
    self.currentIndexValue_Bedroom = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabBedroom"] integerValue];
    
    // show ON OFF
    if (self.currentIndexValue_Bedroom == 0) // on
    {
        // set stored index
        [navSC_Bedroom setIndexToBeginWith:1];
    } else if (self.currentIndexValue_Bedroom == 1) // off
    {
        // set stored index
        [navSC_Bedroom setIndexToBeginWith:0];
    }
    
    [self.view addSubview:navSC_Bedroom];
    navSC_Bedroom.center = CGPointMake(280, 500);
    
    
    // ----------
    // ON OFF bathroom
    navSC_Bathroom.changeHandler = ^(NSUInteger newIndex) {
        __block NSUInteger index = navSC_Bathroom.selectedSegmentIndex;
        
        // storage of currentindex
        self.currentIndexValue_Bathroom = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Bathroom] forKey:@"currentIndexValueJalousieTabBathroom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Bathroom setIndexToBeginWith:index];
    };
    // reading stored index value
    self.currentIndexValue_Bathroom = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabBathroom"] integerValue];
    
    // show ON OFF
    if (self.currentIndexValue_Bathroom == 0) // on
    {
        // set stored index
        [navSC_Bathroom setIndexToBeginWith:1];
    } else if (self.currentIndexValue_Bathroom == 1) // off
    {
        // set stored index
        [navSC_Bathroom setIndexToBeginWith:0];
    }
    
    [self.view addSubview:navSC_Bathroom];
    navSC_Bathroom.center = CGPointMake(770, 500);
    
    
    
    // ----------
    // ON OFF kitchen
    navSC_Kitchen.changeHandler = ^(NSUInteger newIndex) {
        __block NSUInteger index = navSC_Kitchen.selectedSegmentIndex;
        
        // storage of currentindex
        self.currentIndexValue_Kitchen = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Kitchen] forKey:@"currentIndexValueJalousieTabKitchen"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Kitchen setIndexToBeginWith:index];
    };
    // reading stored index value
    self.currentIndexValue_Kitchen = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabKitchen"] integerValue];
    
    // show ON OFF
    if (self.currentIndexValue_Kitchen == 0) // on
    {
        // set stored index
        [navSC_Kitchen setIndexToBeginWith:1];
    } else if (self.currentIndexValue_Kitchen == 1) // off
    {
        // set stored index
        [navSC_Kitchen setIndexToBeginWith:0];
    }
    
    [self.view addSubview:navSC_Kitchen];
    navSC_Kitchen.center = CGPointMake(720, 250);
    
    
    
    // ----------
    // ON OFF living room
    navSC_LivingRoom.changeHandler = ^(NSUInteger newIndex) {
        __block NSUInteger index = navSC_LivingRoom.selectedSegmentIndex;
        
        // storage of currentindex
        self.currentIndexValue_LivingRoom = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_LivingRoom] forKey:@"currentIndexValueJalousieTabLivingRoom"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_LivingRoom setIndexToBeginWith:index];
    };
    // reading stored index value
    self.currentIndexValue_LivingRoom = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabLivingRoom"] integerValue];
    
    // show ON OFF
    if (self.currentIndexValue_LivingRoom == 0) // on
    {
        // set stored index
        [navSC_LivingRoom setIndexToBeginWith:1];
    } else if (self.currentIndexValue_LivingRoom == 1) // off
    {
        // set stored index
        [navSC_LivingRoom setIndexToBeginWith:0];
    }
    
    [self.view addSubview:navSC_LivingRoom];
    //navSC_LivingRoom.center = CGPointMake((self.view.frame.size.width*2)/3, 250);
    navSC_LivingRoom.center = CGPointMake(350, 250);
    
    
    
    // ----------
    // ON OFF entrance
    navSC_Entrance.changeHandler = ^(NSUInteger newIndex) {
        __block NSUInteger index = navSC_Entrance.selectedSegmentIndex;
        
        // storage of currentindex
        self.currentIndexValue_Entrance = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Entrance] forKey:@"currentIndexValueJalousieTabEntrance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [navSC_Entrance setIndexToBeginWith:index];
    };
    // reading stored index value
    self.currentIndexValue_Entrance = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabEntrance"] integerValue];
    
    // show ON OFF
    if (self.currentIndexValue_Entrance == 0) // on
    {
        // set stored index
        [navSC_Entrance setIndexToBeginWith:1];
    } else if (self.currentIndexValue_Entrance == 1) // off
    {
        // set stored index
        [navSC_Entrance setIndexToBeginWith:0];
    }

    
    [self.view addSubview:navSC_Entrance];
    navSC_Entrance.center = CGPointMake(540, 500);
    
    
    
//    // ----------
//    // ON OFF basement
//    navSC_Basement.changeHandler = ^(NSUInteger newIndex) {
//        __block NSUInteger index = navSC_Basement.selectedSegmentIndex;
//        
//        // storage of currentindex
//        self.currentIndexValue_Basement = index;
//        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue_Basement] forKey:@"currentIndexValueJalousieTabBasement"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [navSC_Basement setIndexToBeginWith:index];
//    };
//    // reading stored index value
//    self.currentIndexValue_Basement = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueJalousieTabBasement"] integerValue];
//    
//    // show ON OFF
//    if (self.currentIndexValue_Basement == 0) // on
//    {
//        // set stored index
//        [navSC_Basement setIndexToBeginWith:1];
//    } else if (self.currentIndexValue_Basement == 1) // off
//    {
//        // set stored index
//        [navSC_Basement setIndexToBeginWith:0];
//    }
//    
//    [self.view addSubview:navSC_Basement];
//    navSC_Basement.center = CGPointMake(425, 600);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
