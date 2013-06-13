//
//  SHLivingroomVC.m
//  SmartHome
//
//  Created by Clara Lange on 12.06.13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHLivingroomVC.h"
#import "SHDetailviewLivingroomLightVC.h"
#import "SHDetailviewLivingroomPhoneVC.h"
#import "SHDetailviewLivingroomStereoVC.h"
#import "SHDetailviewLivingroomTVVC.h"
#import "SHDetailviewLivingroomHeatingVC.h"

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

- (IBAction)lightButtonTouchUp:(UIButton *)sender
{
	SHDetailviewLivingroomLightVC* viewControllerLivingRoomDetailLight = [[SHDetailviewLivingroomLightVC alloc] initWithNibName:@"SHDetailviewLivingroomLightVC" bundle:nil];
    // initWithNibName:@"SHDetailviewLivingroomLightViewController" bundle:nil];
    
    //[self.view pushViewController:viewControllerLivingRoomDetailLight];
    [self presentViewController:viewControllerLivingRoomDetailLight animated:NO completion:^{
        NSLog(@"Controller Light presented");
    }];
}

- (IBAction)phoneButtonTouchUp:(UIButton *)sender
{
    SHDetailviewLivingroomPhoneVC* viewControllerLivingRoomDetailPhone = [[SHDetailviewLivingroomPhoneVC alloc] initWithNibName:@"SHDetailviewLivingroomPhoneVC" bundle:nil];
    
    [self presentViewController:viewControllerLivingRoomDetailPhone animated:NO completion:^{
        NSLog(@"Controller Phone presented");
    }];
}

- (IBAction)tvButtonTouchUP:(UIButton *)sender
{
    SHDetailviewLivingroomTVVC* viewControllerLivingRoomDetailTV = [[SHDetailviewLivingroomTVVC alloc] initWithNibName:@"SHDetailviewLivingroomTVVC" bundle:nil];
    
    [self presentViewController:viewControllerLivingRoomDetailTV animated:NO completion:^{
        NSLog(@"Controller TV presented");
    }];
}

- (IBAction)stereoButtonTouchUp:(UIButton *)sender
{
    SHDetailviewLivingroomStereoVC* viewControllerLivingRoomDetailStereo = [[SHDetailviewLivingroomStereoVC alloc] initWithNibName:@"SHDetailviewLivingroomStereoVC" bundle:nil];
    
    [self presentViewController:viewControllerLivingRoomDetailStereo animated:NO completion:^{
        NSLog(@"Controller Stereo presented");
    }];
}

- (IBAction)heatingButtonTouchUp:(UIButton *)sender
{
    SHDetailviewLivingroomHeatingVC* viewControllerLivingRoomDetailHeating = [[SHDetailviewLivingroomHeatingVC alloc] initWithNibName:@"SHDetailviewLivingroomHeatingVC" bundle:nil];
    
    [self presentViewController:viewControllerLivingRoomDetailHeating animated:NO completion:^{
        NSLog(@"Controller Heating presented");
    }];
}

- (IBAction)backToSH:(UIButton *)sender
{
	[self dismissViewControllerAnimated:NO completion:^{NSLog(@"Controller dismissed");}];
}

@end
