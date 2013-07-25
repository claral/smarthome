//
//  SHDetailviewBasementLaundryVC.m
//  SmartHome
//
//  Created by Lisa Hüfner on 7/25/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewBasementLaundryVC.h"
#import "VEIFWheelViewController.h"

@interface SHDetailviewBasementLaundryVC ()

@property (strong) VEIFWheelViewController *wvc;

@end

@implementation SHDetailviewBasementLaundryVC

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
    
    self.wvc = [[VEIFWheelViewController alloc]init];
    
    SHIconWithTitle *item1 = [[SHIconWithTitle alloc] init];
    item1.icon = [UIImage imageNamed:@"05-Latte-Macchiato"];
    item1.title = @"Latte Macchiato";

    
    NSArray *items = [[NSArray alloc] initWithObjects:item1,item1,item1, nil];

    self.wvc.items = items;
    
    UIView *wView = self.wvc.view;
    
    [wView setBackgroundColor:[UIColor magentaColor]];
    [wView setBounds:CGRectMake(0, 0, wView.frame.size.width, wView.frame.size.height)];
    [wView setCenter:CGPointMake(500, 500)];
    
    [self.view addSubview:wView];

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

@end
