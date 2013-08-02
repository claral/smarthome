//
//  VEStaticHorizontalViewController.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 23.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "VEIFStaticHorizontalSliderViewControllerHeating.h"

@interface VEIFStaticHorizontalSliderViewControllerHeating ()

@property (nonatomic, strong) VEStaticHorizontalSliderViewHeating *horizontalView;
@property (nonatomic, assign) CGPoint startingPosition;

@end

@implementation VEIFStaticHorizontalSliderViewControllerHeating

#pragma mark - init/dealloc

@synthesize icons = _icons;
@synthesize sDelegate = _sDelegate;

- (id)init
{
    self = [super init];
    if (self)
	{
		
    }
	return self;
}


- (void)setPredefinedValue:(id)value
{
	[self.horizontalView setCurrentIndex:[value integerValue]];
}

- (void) loadView
{
	[super loadView];
	
	CGSize horizontalViewSize;
	CGRect horizontalViewFrame;
	
	horizontalViewSize = CGSizeMake(self.view.frame.size.width, 100);
//	horizontalViewFrame = CGRectMake(self.view.frame.size.width * 0.5f - horizontalViewSize.width * 0.5f,
//									 self.view.frame.size.height * 0.5f - horizontalViewSize.height * 0.5f,
//									 self.view.frame.size.width+450.0f, //breite fuer horizontal view +450
//									 horizontalViewSize.height);

	horizontalViewFrame = CGRectMake(self.view.frame.size.width * 0.5f - horizontalViewSize.width * 0.5f,
									 self.view.frame.size.height * 0.5f - horizontalViewSize.height * 0.5f,
									 self.view.frame.size.width+450.0f, //breite fuer horizontal view +450
									 horizontalViewSize.height);

    
	self.horizontalView = [[VEStaticHorizontalSliderViewHeating alloc] initWithFrame:horizontalViewFrame];
	self.horizontalView.items = self.icons;
    self.horizontalView.sDelegate = self.sDelegate;
    
//    [self.horizontalView setBackgroundColor:[UIColor magentaColor]];
	[self.view addSubview:self.horizontalView];
    self.view.frame = self.horizontalView.frame;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	UIPanGestureRecognizer *panRecognizer;
	UITapGestureRecognizer *tapRecognizer;
	panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
															action:@selector(handlePan:)];
	tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
															action:@selector(handleTap:)];
	[self.horizontalView addGestureRecognizer:panRecognizer];
	[self.horizontalView addGestureRecognizer:tapRecognizer];
//	
//	[self.horizontalView addObserver:self
//						  forKeyPath:kCurrentIndex
//							 options:NSKeyValueObservingOptionInitial
//							 context:nil];
}

- (void)dealloc
{
//    [self.horizontalView removeObserver:self
//							 forKeyPath:kCurrentIndex];
}

#pragma mark - Handling Gestures


- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		self.startingPosition = self.horizontalView.needleLayer.position;
	}
	
	if (recognizer.state == UIGestureRecognizerStateCancelled ||
		recognizer.state == UIGestureRecognizerStateEnded)
	{
		self.startingPosition = CGPointZero;
		[self.horizontalView snapNeedleToNearestItem];
		return;
	}
	
	CGPoint translation;
	CGPoint newNeedlePosisition;
	
	translation = [recognizer translationInView:self.horizontalView];
	
	newNeedlePosisition = self.startingPosition;
	newNeedlePosisition.x += translation.x;
	
	if (newNeedlePosisition.x < 1) {
		return;
	}
	
	if (newNeedlePosisition.x > self.horizontalView.frame.size.width - 2) {
		return;
	}
	
	[CATransaction begin];
	[CATransaction setAnimationDuration:0.0f];
	self.horizontalView.needleLayer.position = newNeedlePosisition;
	[CATransaction commit];
}


- (void)handleTap:(UITapGestureRecognizer*)recognizer
{
	CGPoint position;
	
	position = [recognizer locationInView:self.horizontalView];
	position.y = self.horizontalView.needleLayer.position.y;
    
    
    NSLog(@"hurra");
    
	self.horizontalView.needleLayer.position = position;
	[self.horizontalView snapNeedleToNearestItem];
}

- (void)setSDelegate:(id<SliderDelegate>)sDelegate
{
    self.horizontalView.sDelegate = sDelegate;
    _sDelegate = sDelegate;
}

#pragma mark - KVO
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//	if (object == self.horizontalView &&
//		[keyPath isEqualToString:kCurrentIndex])
//	{
//		[self handleTaskStatusWithValue:(double)self.horizontalView.currentIndex];
//	}
//	else {
//		[super observeValueForKeyPath:keyPath
//							 ofObject:object
//							   change:change
//							  context:context];
//	}
//}

@end
