//
//  SHDetailviewKitchenCookerVC.m
//  SmartHome
//
//  Created by Clara Lange on 6/13/13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHDetailviewKitchenCookerVC.h"
#import "VEIFTapNHoldViewController.h"

@interface SHDetailviewKitchenCookerVC ()

@property (weak, nonatomic) IBOutlet UIImageView *cooker1Start;
@property (weak, nonatomic) IBOutlet UIImageView *cooker1Level0;
@property (weak, nonatomic) IBOutlet UIImageView *cooker1Level1;
@property (weak, nonatomic) IBOutlet UIImageView *cooker1Level2;
@property (weak, nonatomic) IBOutlet UIImageView *cooker1Level3;
@property (weak, nonatomic) IBOutlet UIImageView *cooker1Level4;
@property (weak, nonatomic) IBOutlet UIImageView *cooker1Level5;
@property (weak, nonatomic) IBOutlet UIImageView *cooker1Level6;
@property (weak, nonatomic) IBOutlet UIImageView *cooker1Level7;
@property (weak, nonatomic) IBOutlet UIImageView *cooker1Level8;
@property (weak, nonatomic) IBOutlet UIImageView *cooker1Level9;

@property (strong, nonatomic, readwrite) UILongPressGestureRecognizer *longPressGestureRecognizer;

@property (assign, nonatomic, readwrite) BOOL beginFromCooker1StartBool;
@property (strong, nonatomic, readwrite) UIImageView *selectedCooker1Level;
@property (strong, nonatomic, readwrite) UIImageView *currentTouchedCooker1Level;
@property (strong, nonatomic, readwrite) NSArray *cooker1LevelArray;
@property (weak, nonatomic) IBOutlet UILabel *cooker1Label;


@property (strong) VEIFTapNHoldViewController *tnhvc;


@end

@implementation SHDetailviewKitchenCookerVC

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
    
    self.tnhvc =
    [[VEIFTapNHoldViewController alloc] init];
//    self.tnhvc.sDelegate = self;
    
    SHIconWithTitle *icon1 = [[SHIconWithTitle alloc] init];
    icon1.icon = [UIImage imageNamed:@"01-Espresso"];
    icon1.title = @"Espresso";
    
    SHIconWithTitle *icon2 = [[SHIconWithTitle alloc] init];
    icon2.icon = [UIImage imageNamed:@"02-Espresso-Doppio"];
    icon2.title = @"Doppio";
    
    SHIconWithTitle *icon3 = [[SHIconWithTitle alloc] init];
    icon3.icon = [UIImage imageNamed:@"03-Kaffee"];
    icon3.title = @"Kaffee";
    
    SHIconWithTitle *icon4 = [[SHIconWithTitle alloc] init];
    icon4.icon = [UIImage imageNamed:@"04-Cappuccino"];
    icon4.title = @"Cappuccino";
    
        
    self.tnhvc.items = [[NSArray alloc] initWithObjects:icon1, icon2, icon3, icon4, nil];
    
    UIView *sliderView = self.tnhvc.view;
    
    [sliderView setBounds:CGRectMake(0, 0, sliderView.frame.size.width, sliderView.frame.size.height)];
    [sliderView setCenter:CGPointMake(500, 500)];
    //[sliderView setBackgroundColor:[UIColor magentaColor]];
    [self.view addSubview:sliderView];

    
//    // init array cookerlevels (of cooker 1) with uiimmageviews
//    self.cooker1LevelArray = [[NSArray alloc] initWithObjects:self.cooker1Level0, self.cooker1Level1, self.cooker1Level2, self.cooker1Level3, self.cooker1Level4, self.cooker1Level5, self.cooker1Level6, self.cooker1Level7, self.cooker1Level8, self.cooker1Level9 , nil];
//    
//    // TODO: for every cooker
//    // storage
//    NSUInteger cooker1Level = [[[NSUserDefaults standardUserDefaults] valueForKey:@"cookerOneLevel"] integerValue];
//    self.cooker1Label.text = [NSString stringWithFormat:@"Stufe: %d", cooker1Level];
//    self.selectedCooker1Level = [self.cooker1LevelArray objectAtIndex:cooker1Level];
//    [self.selectedCooker1Level setImage:[UIImage imageNamed:@"oven2.png"]];
//    
//    // add a custom long press gesture recognizer
//	self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
//    self.longPressGestureRecognizer.minimumPressDuration = 0.2f;
//    [self.view addGestureRecognizer:self.longPressGestureRecognizer];
}


- (void)handleLongPressGesture:(UILongPressGestureRecognizer*)recognizer
{
    CGPoint touchPoint = [recognizer locationInView:self.view];
    
    // START of long press gesture
    if (UIGestureRecognizerStateBegan == recognizer.state)
    {
        if (self.selectedCooker1Level != nil)
        {
            [self.selectedCooker1Level setImage:[UIImage imageNamed:@"oven.png"]];
            self.cooker1Label.text = [NSString stringWithFormat:@"Stufe: %d", [self.cooker1LevelArray indexOfObject:self.selectedCooker1Level]];
        }
        if (CGRectContainsPoint(self.cooker1Start.frame, touchPoint))
        {
            self.beginFromCooker1StartBool = YES;
            [self.cooker1Start setImage:[UIImage imageNamed:@"oven2.png"]];
        }
    }
    
    // CHANGE of long press gesture
    else if (UIGestureRecognizerStateChanged == recognizer.state)
    {
        if (self.beginFromCooker1StartBool == YES)
        {
            for (UIImageView* object in self.cooker1LevelArray)
            {
                
                if (CGRectContainsPoint(object.frame, touchPoint))
                {
                    object.image = [UIImage imageNamed:@"oven2.png"];
                    self.currentTouchedCooker1Level = object;
                }
                else if ([object isEqual:self.currentTouchedCooker1Level] &&
                         !CGRectContainsPoint(object.frame, touchPoint))
                {
                    object.image = [UIImage imageNamed:@"oven.png"];
                    self.currentTouchedCooker1Level = nil;
                }
                else if (![object isEqual:self.selectedCooker1Level])
                {
                    object.image = [UIImage imageNamed:@"oven.png"];
                }
            }
        }
    }
    
    // END of long press gesture
    else if (UIGestureRecognizerStateEnded == recognizer.state)
    {
        if (self.currentTouchedCooker1Level != nil)
        {
            self.selectedCooker1Level.image = [UIImage imageNamed:@"oven.png"];
            self.selectedCooker1Level = self.currentTouchedCooker1Level;
            self.currentTouchedCooker1Level = nil;
        }
        if (self.selectedCooker1Level != nil)
        {
            [self.selectedCooker1Level setImage:[UIImage imageNamed:@"oven2.png"]];
            NSUInteger newCookerOneLevel = [self.cooker1LevelArray indexOfObject:self.selectedCooker1Level];
            self.cooker1Label.text = [NSString stringWithFormat:@"Stufe: %d", newCookerOneLevel];
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInteger:newCookerOneLevel]
                                                     forKey:@"cookerOneLevel"];
        }
        self.beginFromCooker1StartBool = NO;
    }
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
