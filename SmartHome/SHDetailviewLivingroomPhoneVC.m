//
//  SHDetailviewLivingroomPhoneVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewLivingroomPhoneVC.h"

@interface SHDetailviewLivingroomPhoneVC ()

- (IBAction)anrufenAlert:(id)sender;

@end

@implementation SHDetailviewLivingroomPhoneVC


@synthesize labelPhoneNumber = _labelPhoneNumber;

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

- (IBAction)closeDetailview:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)backToSH:(id)sender
{
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    // TODO: wirklich alle Views dismissed?
}

- (IBAction)buttonPhoneDisplay:(UIButton *)sender
{
    NSString *digit = sender.currentTitle;
    if (self.labelPhoneNumber.text.length < 20)
    {
        self.labelPhoneNumber.text = [self.labelPhoneNumber.text stringByAppendingString:digit];
    }
}

- (IBAction)buttonDeletePhoneDisplay:(UIButton *)sender
{
    self.labelPhoneNumber.text = [self.labelPhoneNumber.text stringByDeletingLastPathComponent];
}

- (IBAction)buttonDeletePhoneDisplayLastNumber:(UIButton *)sender
{
    //NSString *string = self.labelPhoneNumber.text;
    if (self.labelPhoneNumber.text.length > 1)
    {
        [self.labelPhoneNumber setText:[self.labelPhoneNumber.text substringToIndex:[self.labelPhoneNumber.text length]-1]];
    } else if (self.labelPhoneNumber.text.length == 1) {
        self.labelPhoneNumber.text = @"";
        NSLog(@"bla1");
    } else {
        NSLog(@"bla2");
    }
}

- (IBAction)anrufenAlert:(id)sender
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Es klingelt!" message:@"Palim, palim.. Wer da?" delegate:nil cancelButtonTitle:@"Auflegen" otherButtonTitles:nil];
    [message show];
}

@end
