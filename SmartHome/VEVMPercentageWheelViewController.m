//
//  VEPercentageWheelViewController.m
//  VirtualUIElements
//
//  Created by Tom Schelo on 23.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "VEVMPercentageWheelViewController.h"

@interface VEVMPercentageWheelViewController ()
{
    UIPanGestureRecognizer *panRecognizer;
    UITapGestureRecognizer *tapRecognizer;
}

//@property (nonatomic, assign) NSInteger percentage;
@property (nonatomic, assign) float previousValueAngle;
@property (nonatomic, assign) BOOL valueAngleLock;
@property (nonatomic, assign) float previousPercentageValue;
@property (nonatomic, assign) BOOL previousPercentageValueBool1;

@end

@implementation VEVMPercentageWheelViewController

- (id)init
{
    self = [super init];
    if (self)
	{
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_percentageWheelView setBackgroundColor:[UIColor clearColor]];
    
    // Gesture Recognizers
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(updateValueForPan:)];
    [panRecognizer setMaximumNumberOfTouches:1];
    [_percentageWheelView addGestureRecognizer:panRecognizer];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateValueForTap:)];
    [_percentageWheelView addGestureRecognizer:tapRecognizer];
    
    [self addObserver:self
           forKeyPath: @"percentage"
              options:NSKeyValueObservingOptionInitial
              context:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateValueForPan:(UIPanGestureRecognizer *)gr {
    
    [_percentageWheelView setValueAngle:[self angleOnWheelForPosition:[gr locationInView:_percentageWheelView]]];
	
    [self updateValue];
}

- (void) updateValueForTap:(UITapGestureRecognizer *)gr {
    
    [_percentageWheelView setValueAngle:[self angleOnWheelForPosition:[gr locationInView:_percentageWheelView]]];
	
    [self updateValue];
    
}

- (float) angleOnWheelForPosition:(CGPoint)position
{
	float x1;
	float y1;
	float t;
	float angle;
	CGPoint center;
	CGPoint positionOnCircumference;
	
	center = _percentageWheelView.center;
	
	t = _percentageWheelView.radius / sqrtf(powf((position.x - center.x), 2) + powf((position.y - center.y), 2));
	x1 = center.x + t * (position.x  - center.x);
	y1 = center.y + t * (position.y  - center.y);
	positionOnCircumference = CGPointMake(x1, y1);
	
	angle = atan2f(positionOnCircumference.y - center.y,
				   positionOnCircumference.x - center.x);
	
	return angle + M_PI/2.0;
}

- (void) updateValue {

    BOOL boolPercentageZero = false;
    BOOL boolPercentageHundred = false;
    BOOL boolBla;
    self.previousPercentageValue = self.percentage;

    if (_percentageWheelView.valueAngle >= 0) // 0% - 75%
    {
        self.percentage = round(_percentageWheelView.valueAngle/(2*M_PI)*100.0);
        //NSLog(@"case1 percentage: %d ", self.percentage);
        if (self.percentage == 0)
        {
            boolPercentageZero = true;
        } else
            boolPercentageZero = false;

    }
    else // 75% - 100%
    {
        self.percentage = round(100.0 + _percentageWheelView.valueAngle/(2*M_PI)*100.0);
        //NSLog(@"case2 percentage: %d ", self.percentage);
        if (self.percentage == 100)
        {
            boolPercentageHundred = true;
        } else
        {
            boolPercentageHundred = false;
        }
    }

    if (((self.previousPercentageValue <= 100) && (self.previousPercentageValue >= 92)) && ((self.percentage >= 0) && (self.percentage <= 8)))
    //if (self.previousPercentageValue <= 100 && self.previousPercentageValue > self.percentage)
    {
        //NSLog(@"crossover from 100 to zero (clockwise)");
        boolPercentageHundred = true;
        self.percentage = 100;
        //self.percentage = 100.0 + _percentageWheelView.valueAngle/(2*M_PI)*100.0
        _percentageWheelView.valueAngle = -0.01; //2*M_PI + 360.0f; //(self.percentage - 100.0)*(2*M_PI)/100.0;
        boolBla = true;
    }

    if (boolBla == false && (self.previousPercentageValue >= 0) && (self.previousPercentageValue <= 8) && (self.percentage <= 100) && (self.percentage >= 92))
    //if ((self.previousPercentageValue >= 0) && (self.previousPercentageValue <= 5) && (self.percentage <= 100) && (self.percentage >= 95))
    {
        //NSLog(@"crossover from zero to 100 (anti-clockwise)");
        boolPercentageZero = true;
        self.percentage = 0;
        _percentageWheelView.valueAngle = self.percentage*(2*M_PI)/100.0;
        boolBla = false;
    }


    
    if (boolPercentageHundred == true)
    {
        [self updateResultLabel];
        panRecognizer.enabled = NO;
        panRecognizer.enabled = YES;
    } else if (boolPercentageZero == true)
    {
        [self updateResultLabel];
        panRecognizer.enabled = NO;
        panRecognizer.enabled = YES;
    } else //if ((boolPercentageHundred) == false && (boolPercentageZero == false))
    {
        [self updateResultLabel];
    }
    
    // update LightView
    _lightView.radius = (float)_percentage/60;
    [_lightView setNeedsDisplay];
    
    [_percentageWheelView setNeedsDisplay];
}

- (void) updateValueDOS {
    
     if (_percentageWheelView.valueAngle >= 0)
         self.percentage = round(_percentageWheelView.valueAngle/(2*M_PI)*100.0);
     else
         self.percentage = round(100.0 + _percentageWheelView.valueAngle/(2*M_PI)*100.0);
     
     [self updateResultLabel];
     
     // update LightView
     _lightView.radius = (float)_percentage/60;
     [_lightView setNeedsDisplay];
     
     [_percentageWheelView setNeedsDisplay];
}

- (void) updateValueOLD {
    
    if (_percentageWheelView.valueAngle >= 0)
        self.percentage = _percentageWheelView.valueAngle/(2*M_PI)*100;
    else
        self.percentage = 100 + _percentageWheelView.valueAngle/(2*M_PI)*100;
    
    [self updateResultLabel];
    
    // update LightView
    _lightView.radius = (float)_percentage/60;
    [_lightView setNeedsDisplay];
    
    [_percentageWheelView setNeedsDisplay];
    
}

//- (void) updateValue {
//
//    BOOL boolPercentageZero = false;
//    BOOL boolPercentageHundred = false;
//    self.previousPercentageValue = self.percentage;
//    
//    if (_percentageWheelView.valueAngle >= 0) // 0% - 75%
//    {
//        self.percentage = round(_percentageWheelView.valueAngle/(2*M_PI)*100.0);
//        //NSLog(@"case1 percentage: %d ", self.percentage);
//        if (self.percentage == 0)
//        {
//            boolPercentageZero = true;
//        } else
//            boolPercentageZero = false;
//        
//        /*if (self.previousPercentageValueBool1 == YES) // übergang von 0/1 auf 100 - gegen uhrzeigersinn
//        {
//            NSLog(@"1: übergang von 0/1 auf 100 - gegen uhrzeigersinn");
//            if (self.previousPercentageValue < self.percentage)
//            {
//                NSLog(@"2: übergang von 0/1 auf 100 - gegen uhrzeigersinn");
//                if (((self.previousPercentageValue <= 100) && (self.previousPercentageValue >= 90)) && ((self.percentage >= 0) && (self.percentage <= 10)))
//                {
//                    NSLog(@"3: übergang von 0/1 auf 100 - gegen uhrzeigersinn");
//                }
//            }
//        }*/
//        
//        self.previousPercentageValueBool1 = NO;
//    }
//    else // 75% - 100%
//    {
//        self.percentage = round(100.0 + _percentageWheelView.valueAngle/(2*M_PI)*100.0);
//        NSLog(@"case2 percentage: %d ", self.percentage);
//        if (self.percentage == 100)
//        {
//            boolPercentageHundred = true;
//        } else
//        {
//            boolPercentageHundred = false;
//        }
//        
//        //if (self.previousPercentageValueBool1 == NO) // übergang von 100 auf 0/1 - mit uhrzeigersinn
//        {
//            NSLog(@"1: übergang von 100 auf 0/1 - mit uhrzeigersinn");
//            //if (self.previousPercentageValue < self.percentage)
//            {
//                //NSLog(@"2: übergang von 100 auf 0/1 - mit uhrzeigersinn");
//                if (((self.previousPercentageValue <= 100) && (self.previousPercentageValue >= 80)))//&& ((self.percentage >= 0) && (self.percentage <= 20)))
//                {
//                    NSLog(@"3: übergang von 100 auf 0/1 - mit uhrzeigersinnn");
//                }
//            }
//        }
//        
//        self.previousPercentageValueBool1 = YES;
//    }
//    
//    
//    
//    if ((boolPercentageHundred) == false && (boolPercentageZero == false))
//    {
//        [self updateResultLabel];
//        
//        // update LightView
//        _lightView.radius = (float)_percentage/60;
//        [_lightView setNeedsDisplay];
//        
//        [_percentageWheelView setNeedsDisplay];
//    } /*else if (boolPercentageHundred == true)
//    {
//        [self updateResultLabel];
//        panRecognizer.enabled = NO;
//        NSLog(@"hundert erreicht");
//        //sleep(1);
//        //UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"MAX" message:@"Die maximale Helligkeit wurde erreicht" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        //[message show];
//        panRecognizer.enabled = YES;
//    } else if (boolPercentageZero == true)
//    {
//        [self updateResultLabel];
//        panRecognizer.enabled = NO;
//        NSLog(@"zero erreicht");
//        //UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"MIN" message:@"Die minimale Helligkeit wurde erreicht" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        //[message show];
//        panRecognizer.enabled = YES;
//    }*/
//}

- (void) updateResultLabel {
    [[self resultLabel] setText:[NSString stringWithFormat:@"%i%%", _percentage]];
}

- (void) setPredefinedValue:(id)value   {
    float defaultValue = [value floatValue];
    [_percentageWheelView setValueAngle:defaultValue];
    [self updateValue];
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (object == self &&
		[keyPath isEqualToString:@"percentage"])
	{
//		[self handleTaskStatusWithValue:(double)_percentage];
	}
	else {
		[super observeValueForKeyPath:keyPath
							 ofObject:object
							   change:change
							  context:context];
	}
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"percentage"];
    [_percentageWheelView removeGestureRecognizer:panRecognizer];
    [_percentageWheelView removeGestureRecognizer:tapRecognizer];
}

@end
