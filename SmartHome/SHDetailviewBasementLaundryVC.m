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

- (IBAction)startWashing:(id)sender;

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
    item1.icon = [UIImage imageNamed:@"01-Aus"];
    item1.title = @"   Aus      ";

    SHIconWithTitle *item2 = [[SHIconWithTitle alloc] init];
    item2.icon = [UIImage imageNamed:@"02-Kochwäsche"];
    item2.title = @"Kochwäsche";
    
    SHIconWithTitle *item3 = [[SHIconWithTitle alloc] init];
    item3.icon = [UIImage imageNamed:@"03-Kochwäsche"];
    item3.title = @"Kochwäsche";
    
    SHIconWithTitle *item4 = [[SHIconWithTitle alloc] init];
    item4.icon = [UIImage imageNamed:@"04-Pflegeleicht"];
    item4.title = @"Pflegeleicht";
    
    SHIconWithTitle *item5 = [[SHIconWithTitle alloc] init];
    item5.icon = [UIImage imageNamed:@"05-Feinwäsche"];
    item5.title = @"Feinwäsche";
    
    SHIconWithTitle *item6 = [[SHIconWithTitle alloc] init];
    item6.icon = [UIImage imageNamed:@"06-Handwäsche"];
    item6.title = @"Handwäsche";
    
    SHIconWithTitle *item7 = [[SHIconWithTitle alloc] init];
    item7.icon = [UIImage imageNamed:@"07-Eco"];
    item7.title = @"   Eco      ";
    
    SHIconWithTitle *item8 = [[SHIconWithTitle alloc] init];
    item8.icon = [UIImage imageNamed:@"08-Schleudern"];
    item8.title = @"Schleudern";
    
    NSArray *items = [[NSArray alloc] initWithObjects:item1,item2,item3,item4,item5,item6,item7,item8, nil];

    self.wvc.items = items;
    
    UIView *wView = self.wvc.view;
    
    
//    [wView setBackgroundColor:[UIColor magentaColor]];
    [wView setBounds:CGRectMake(0, 0, wView.frame.size.width, wView.frame.size.height)];
    [wView setCenter:CGPointMake(400, 400)];
    
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

- (IBAction)startWashing:(id)sender {
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Waschvorgang" message:@"wird durchgeführt!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [message show];
    
}
@end
