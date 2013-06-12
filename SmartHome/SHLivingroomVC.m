//
//  SHLivingroomVC.m
//  SmartHome
//
//  Created by Steffen Bauereiss on 12.06.13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHLivingroomVC.h"
#import "SHDetailviewLivingroomLightViewController.h"

@interface SHLivingroomVC ()

@end

@implementation SHLivingroomVC

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lightButtonTouchUp:(UIButton *)sender {
	
	SHDetailviewLivingroomLightViewController* viewControllerLivingRoomDetailLight = [[SHDetailviewLivingroomLightViewController alloc] initWithNibName:@"SHDetailviewLivingroomLightViewController" bundle:nil];
    
    //[self.view pushViewController:viewControllerLivingRoomDetailLight];
    [self presentViewController:viewControllerLivingRoomDetailLight animated:NO completion:^{
        NSLog(@"Controller presented");
    }];
	

}

- (IBAction)backToSH:(UIButton *)sender {
	[self dismissViewControllerAnimated:NO completion:nil];
}

@end
