//
//  SHDetailviewLivingroomLightViewController.m
//  SmartHome
//
//  Created by Clara Lange on 6/12/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewLivingroomLightViewController.h"

@interface SHDetailviewLivingroomLightViewController ()

@end

@implementation SHDetailviewLivingroomLightViewController

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

- (IBAction)ActionButtonLivingroomLight:(id)sender
{
    SHDetailviewLivingroomLightViewController* viewControllerLivingRoomDetailLight = [[SHDetailviewLivingroomLightViewController alloc] initWithNibName:@"SHDetailviewLivingroomLightViewController" bundle:nil];
    
    //[self.view pushViewController:viewControllerLivingRoomDetailLight];
    [self presentViewController:viewControllerLivingRoomDetailLight animated:NO completion:^{
        NSLog(@"Controller presented");
    }];

}

- (IBAction)closeDetailView:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
}
@end
