//
//  SHDetailviewEntranceAlarmVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewEntranceAlarmVC.h"
#import "SVSegmentedControl.h"
#import "SVSegmentedThumb.h"

@interface SHDetailviewEntranceAlarmVC ()
- (IBAction)buttonOKAlarm:(id)sender;
@property (nonatomic, assign) BOOL booleanHome;
@property (nonatomic, assign) int currentIndexValue;
@property (nonatomic, strong) SVSegmentedControl *navSC;


@end

@implementation SHDetailviewEntranceAlarmVC

@synthesize labelAlarmCode = _labelAlarmCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // ON OFF SWITCH
    // Hinzufuegen von Feldern: @"Text". (Text betitelt Feld)
    self.navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"  Home  ", @"  Away  ", nil]];
    
    self.navSC.changeHandler = ^(NSUInteger newIndex) {
        __block NSUInteger index = self.navSC.selectedSegmentIndex;
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
        
        // storage of currentindex
        self.currentIndexValue = index;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:self.currentIndexValue] forKey:@"currentIndexValueAlarmEntrance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navSC setIndexToBeginWith:index];
        self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueAlarmEntrance"] integerValue];
        NSLog(@"stored val in change handler: %d", self.currentIndexValue);
        
        // show ON OFF again
        self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueAlarmEntrance"] integerValue];
        int returnIdxVal;
        if (self.currentIndexValue == 0) // away
        {
            returnIdxVal = [self.navSC setIndexToBeginWith:1];
            NSLog(@"returnidxval: %d", returnIdxVal);
        } else if (self.currentIndexValue == 1) // home
        {
            returnIdxVal = [self.navSC setIndexToBeginWith:0];
            NSLog(@"returnidxval: %d", returnIdxVal);
        }
        
        
        if (index == 1)
        {
            UIAlertView *messageHome = [[UIAlertView alloc] initWithTitle:@"HOME" message:@"Bitte geben Sie das Passwort ein." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [messageHome show];
            self.booleanHome = true;
        } else if (index == 0)
        {
            UIAlertView *messageAway = [[UIAlertView alloc] initWithTitle:@"AWAY" message:@"Das Haus ist verriegelt." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [messageAway show];
            self.booleanHome = false;
        }
    };
    
    
    
    self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValueAlarmEntrance"] integerValue];
    int returnIdxVal;
    if (self.currentIndexValue == 0) // away
    {
        returnIdxVal = [self.navSC setIndexToBeginWith:1];
        NSLog(@"returnidxval: %d", returnIdxVal);
    } else if (self.currentIndexValue == 1) // home
    {
        returnIdxVal = [self.navSC setIndexToBeginWith:0];
        NSLog(@"returnidxval: %d", returnIdxVal);
    }
    
    
    
    
    [self.view addSubview:self.navSC];
    
    self.navSC.center = CGPointMake((self.view.frame.size.width*3)/4, self.view.frame.size.height/2);  //CGPointMake(160, 70). Ausrichten Des ToggleButtons im IPad Bildschirm selber
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.navSC.selectedSegmentIndex == 0)
    {
        UIAlertView *messageHome = [[UIAlertView alloc] initWithTitle:@"HOME" message:@"Bitte geben Sie das Passwort ein." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messageHome show];
        self.booleanHome = true;
    } else if (self.navSC.selectedSegmentIndex == 1)
    {
        UIAlertView *messageAway = [[UIAlertView alloc] initWithTitle:@"AWAY" message:@"Das Haus ist verriegelt." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messageAway show];
        self.booleanHome = false;
    }
    /*[super viewWillAppear:animated];
    
    // reading stored index
    self.currentIndexValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"currentIndexValue"] integerValue];
    NSLog(@"stored val: %d", self.currentIndexValue);
    int returnIdxVal;
    
    // show ON OFF again
    if (self.currentIndexValue == 0) // away
    {
        returnIdxVal = [self.navSC setIndexToBeginWith:1];
        NSLog(@"returnidxval: %d", returnIdxVal);
    } else if (self.currentIndexValue == 1) // home
    {
        returnIdxVal = [self.navSC setIndexToBeginWith:0];
        NSLog(@"returnidxval: %d", returnIdxVal);
    }*/
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

- (IBAction)buttonAlarmDisplay:(UIButton *)sender
{
    if (self.labelAlarmCode.text.length == 4)
    {
        NSLog(@"code should consist of just 4 items - number of items: %d", self.labelAlarmCode.text.length);
    } else {
        if (self.booleanHome == true)
        {
            NSString *digit = sender.currentTitle;
            self.labelAlarmCode.text = [self.labelAlarmCode.text stringByAppendingString:digit];
        }
    }
}

- (IBAction)buttonDeleteAlarmDisplayLastItem:(UIButton *)sender
{
    if (self.labelAlarmCode.text.length > 1)
    {
        [self.labelAlarmCode setText:[self.labelAlarmCode.text substringToIndex:[self.labelAlarmCode.text length]-1]];
    } else if (self.labelAlarmCode.text.length == 1) {
        self.labelAlarmCode.text = @"";
        NSLog(@"bla1");
    } else {
        NSLog(@"bla2");
    }
}

- (IBAction)backToSH:(id)sender
{
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    // TODO: wirklich alle Views dismissed?
}

- (IBAction)buttonOKAlarm:(id)sender
{
    // PW: 1234
    
    if ([self.labelAlarmCode.text isEqual: @"1234"])
    {
        NSLog(@"password ok");
        UIAlertView *messagePWOK = [[UIAlertView alloc] initWithTitle:@"PW OK" message:@"Das Passwort wurde richtig eingegeben." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messagePWOK show];
    } else {
        UIAlertView *messagePWNotOK = [[UIAlertView alloc] initWithTitle:@"PW NICHT OK" message:@"Das Passwort wurde nicht richtig eingegeben. Bitte versuchen Sie es erneut." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messagePWNotOK show];
    }
}
@end
