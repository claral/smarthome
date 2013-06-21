//
//  SHDetailviewLivingroomPhoneVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewLivingroomPhoneVC.h"

@interface SHDetailviewLivingroomPhoneVC ()

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
    self.labelPhoneNumber.text = [self.labelPhoneNumber.text stringByAppendingString:digit];
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

    
    /*// string -> array
    NSMutableString *label = self.labelPhoneNumber.text;
    
    // copy string to array
    NSMutableArray *array = [NSMutableArray array];
    
    if (self.labelPhoneNumber.text.length > 1)
    {
        for (int i = 0; i < label.length; i++)
        {
            unichar c = [label characterAtIndex:i];
            if (!isnumber(c))
                [array addObject:[NSNumber numberWithInt:-1]];
            else
                [array addObject:[NSNumber numberWithInt:c - '0']];
        }
        NSLog(@"array: %@", array);
        
        // delete last item
        int lastItemIndex = self.labelPhoneNumber.text.length;
        [array removeObjectAtIndex:lastItemIndex-1];
        NSLog(@"array: %@", array);
        
        // copy array to string
        [label setString:@""];
        NSLog(@"label: %@",label);
        for (int i = 0; i < (lastItemIndex-1); i++)
        {
            NSLog(@"round %d, characterofarray %@", i, [array objectAtIndex:i]);
            [label appendFormat:@"%@",[array objectAtIndex:i]];
        }
        NSLog(@"%@",label);
        
        self.labelPhoneNumber.text = @" ";
        self.labelPhoneNumber.text = label;
    } else if (self.labelPhoneNumber.text.length == 1) {
        [label setString:@""];
        
        self.labelPhoneNumber.text = @" ";
        self.labelPhoneNumber.text = label;
        NSLog(@"bla1");
    } else {
        NSLog(@"bla2");
    }*/
    
    
    

    
    // TODO: zahl mit 11 stellen ?
    // string -> int division / 10 (ganzzahlige division)
    /*NSString *label = self.labelPhoneNumber.text;
    long phoneNumber;
    
    if (self.labelPhoneNumber.text.length == 0) //empty label
    {
        NSLog(@"empty label");
        label = [NSString stringWithFormat:@""];
        self.labelPhoneNumber.text = label;
    } else { // filled label
        NSLog(@"non-empty label");
        if ([label hasPrefix:@"00"]) //prefix has two zeros
        {
            phoneNumber = [label longLongValue];
            NSLog(@"%ld", phoneNumber);
            
            if (self.labelPhoneNumber.text.length >= 4)
            {
                phoneNumber = phoneNumber / 10;
                label = [NSString stringWithFormat:@"00%ld", phoneNumber];
                self.labelPhoneNumber.text = label;
            } else if (self.labelPhoneNumber.text.length == 3)
            {
                label = [NSString stringWithFormat:@"00"];
                self.labelPhoneNumber.text = label;

            } else if (self.labelPhoneNumber.text.length == 2) {
                label = [NSString stringWithFormat:@"0"];
                self.labelPhoneNumber.text = label;
            } else if (self.labelPhoneNumber.text.length == 1) {
                label = [NSString stringWithFormat:@""];
                self.labelPhoneNumber.text = label;
            } else {
                phoneNumber = phoneNumber / 10;
                label = [NSString stringWithFormat:@"0%ld", phoneNumber];
                self.labelPhoneNumber.text = label;
            }
        }
        else if ([label hasPrefix:@"0"]) //prefix has one zero
        {
            phoneNumber = [label longLongValue];
            NSLog(@"%ld", phoneNumber);
            
            if (self.labelPhoneNumber.text.length == 2)
            {
                label = [NSString stringWithFormat:@"0"];
                self.labelPhoneNumber.text = label;
                
            } else if (self.labelPhoneNumber.text.length == 1) {
                label = [NSString stringWithFormat:@""];
                self.labelPhoneNumber.text = label;
            } else {
                phoneNumber = phoneNumber / 10;
                label = [NSString stringWithFormat:@"0%ld", phoneNumber];
                self.labelPhoneNumber.text = label;
            }
        } else { //prefix is between 1 - 9
            phoneNumber = [label longLongValue];
            NSLog(@"%ld", phoneNumber);
            if (self.labelPhoneNumber.text.length == 1)
            {
                label = [NSString stringWithFormat:@""];
                self.labelPhoneNumber.text = label;
            } else {
                phoneNumber = phoneNumber / 10;
                label = [NSString stringWithFormat:@"%ld", phoneNumber];
                self.labelPhoneNumber.text = label;
            }
        }
    }*/
}
@end
