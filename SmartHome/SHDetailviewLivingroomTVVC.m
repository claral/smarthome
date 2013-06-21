//
//  SHDetailviewLivingroomTVVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewLivingroomTVVC.h"

@interface SHDetailviewLivingroomTVVC ()

@end

@implementation SHDetailviewLivingroomTVVC

@synthesize labelTVChannel = _labelTVChannel;

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

- (IBAction)backToSH:(id)sender
{
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    // TODO: wirklich alle Views dismissed?
}

- (IBAction)buttonChanelDisplay:(UIButton *)sender
{
    // TODO: change after 5 secs possible
    if (self.labelTVChannel.text.length == 2)
    {
        NSLog(@"channel should consist of just 2 items - number of items: %d", self.labelTVChannel.text.length);
    } else {
        NSString *digit = sender.currentTitle;
        self.labelTVChannel.text = [self.labelTVChannel.text stringByAppendingString:digit];
    }
}
@end
