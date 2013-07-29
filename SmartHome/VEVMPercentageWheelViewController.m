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
