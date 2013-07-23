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

@end

@implementation SHDetailviewEntranceAlarmVC

@synthesize labelAlarmCode = _labelAlarmCode;

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
    
    // 1st CONTROL
    // Hinzufuegen von Feldern: @"Text". (Text betitelt Feld)
    SVSegmentedControl *navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Home", @"Away", nil]];
    navSC.changeHandler = ^(NSUInteger newIndex) {
        NSLog(@"segmentedControl did select index %i (via block handler)", newIndex);
    };
    
    [self.view addSubview:navSC];
    
    navSC.center = CGPointMake((self.view.frame.size.width*3)/4, self.view.frame.size.height/2);  //CGPointMake(160, 70). Ausrichten Des ToggleButtons im IPad Bildschirm selber

    
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
        NSString *digit = sender.currentTitle;
        self.labelAlarmCode.text = [self.labelAlarmCode.text stringByAppendingString:digit];
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
