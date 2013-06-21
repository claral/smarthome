//
//  SHDetailviewEntranceAlarmVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewEntranceAlarmVC.h"

@interface SHDetailviewEntranceAlarmVC ()

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

@end
