//
//  VEWheelViewController.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 26.12.12.
//  Copyright (c) 2012 Institute of Ergonomics. All rights reserved.
//

#import "VEIFWheelViewController.h"

@interface VEIFWheelViewController ()

@property (nonatomic, assign) BOOL updatingWheelViaPanGesture;
@property (nonatomic, assign) BOOL updatingWheelViaRotationGesture;
@property (nonatomic, assign) CGFloat lastRotationValue;

@property (nonatomic, strong) VEWheelView *wheelView;
@property (nonatomic, strong) NSArray *itemViews;

@end

@implementation VEIFWheelViewController


#pragma mark - init/dealloc

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
	[self performSelector:@selector(selectCurrentIndex:)
			   withObject:value
			   afterDelay:0.2f];
}

- (void)selectCurrentIndex:(id)value
{
	self.wheelView.currentIndex = [value integerValue];
}

-(int)getCurrentIndex
{
    
    return self.wheelView.currentIndex;
}

- (void)loadView
{
	[super loadView];
	
	self.wheelView = [[VEWheelView alloc] initWithFrame:self.view.bounds];

	[self.view addSubview:self.wheelView];
    self.view.frame = CGRectMake(-60, 0, 700, 500);
    
	self.wheelView.numberOfIndexes = [self.items count];
	self.itemViews  = [self loadItemViews];

	[self.view bringSubviewToFront:self.wheelView];
}

- (NSArray *)loadItemViews
{
	CGRect itemViewRect;
	CGSize itemViewSize;
	
	NSMutableArray *itemViews = [NSMutableArray array];
	itemViewSize = CGSizeMake(200,
							  100);
	
	itemViewRect = CGRectMake(CGRectGetMidX(self.view.bounds) - itemViewSize.width * 0.5f,
							  CGRectGetMidY(self.view.bounds) - itemViewSize.height * 0.5f,
							  itemViewSize.width,
							  itemViewSize.height);
	
	for (int index = 0; index < [self.items count]; index++)
	{
		SHIconWithTitle *thisIcon;
		VEWheelItemView *itemView;
		CGPoint itemViewStartingPoint;
		
		CGFloat angle;
		
		angle = [self.wheelView angleForIndex:index];
		itemViewStartingPoint = [self.wheelView pointOnCircumferenceForAngle:angle];
		
		thisIcon = [self.items objectAtIndex:index];
		
		itemView = [[VEWheelItemView alloc] initWithFrame:itemViewRect];
		itemView.angle = angle;
		itemView.startingPoint = itemViewStartingPoint;
		itemView.icon = thisIcon;
		
		[self.view addSubview:itemView];
		[itemViews addObject:itemView];
	}
	
	return itemViews;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
//	[self.wheelView addObserver:self
//					 forKeyPath:kCurrentIndex
//						options:0
//						context:(void *)self.wheelView.currentIndex];
//	
//	[self.wheelView addObserver:self
//					 forKeyPath:kCurrentFloatingIndex
//						options:0
//						context:nil];

	self.wheelView.delegate = self;
	
	UIRotationGestureRecognizer* rotationRecognizer;
	UITapGestureRecognizer *tapRecognizer;
	rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self
																	  action:@selector(rotationRecognizerDidFire:)];
	tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
															action:@selector(handleTap:)];
	[self.wheelView addGestureRecognizer:rotationRecognizer];
	[self.view addGestureRecognizer:tapRecognizer];
}

- (void)dealloc
{
//	[self.wheelView removeObserver:self
//						forKeyPath:kCurrentIndex];
//	[self.wheelView removeObserver:self
//						forKeyPath:kCurrentFloatingIndex];
	
	self.wheelView.delegate = nil;
}

#pragma mark - Wheel Tracking

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches
			  withEvent:event];
	
	if ([[event allTouches] count] > 1) {
		return;
	}
	
	NSSet *touchesInView;
	touchesInView = [event touchesForView:self.wheelView];
	
	if ([touchesInView count] == 1)
	{
		UITouch *touch;
		BOOL tapInWheel;
		CGPoint position;
		
		touch = [[touchesInView allObjects] lastObject];
		position = [touch locationInView:self.wheelView];
		tapInWheel = [self.wheelView positionIsOnWheel:position];
		self.updatingWheelViaPanGesture = tapInWheel;
		
		self.wheelView.startingAngle = [self.wheelView angleOnWheelForPosition:position];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesMoved:touches
			  withEvent:event];
	
	if (self.updatingWheelViaPanGesture == NO) {
		return;
	}
	
	if (self.updatingWheelViaRotationGesture == YES) {
		return;
	}
	
	NSSet *touchesInView;
	CGPoint position;
	
	touchesInView = [event touchesForView:(UIView*)self.wheelView];
	
	if ([touchesInView count] == 1)
	{
		UITouch *touch;
		
		touch = [[touchesInView allObjects] lastObject];
		position = [touch locationInView:self.wheelView];
		
		[self.wheelView updateNeedleToPosition:position];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
	[self finalizeWheelTracking];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesCancelled:touches withEvent:event];
	[self finalizeWheelTracking];
}

- (void)finalizeWheelTracking
{
	if (self.updatingWheelViaPanGesture == YES)
	{
		[self.wheelView finalizeWheelTracking];
		self.updatingWheelViaPanGesture = NO;
	}
}

#pragma mark - RotationRecognizing

- (void)rotationRecognizerDidFire:(UIRotationGestureRecognizer *)rotationRecognizer
{
	if (self.updatingWheelViaPanGesture == YES) {
		return;
	}
	
	CGFloat newRotation;
	CGFloat rotationDiff;
	
	newRotation = rotationRecognizer.rotation;
	rotationDiff = newRotation - self.lastRotationValue;
	
	[self.wheelView rotateNeedleWithRotation:rotationDiff];
	
	self.lastRotationValue = newRotation;
	
	self.updatingWheelViaRotationGesture = YES;
	
	if (rotationRecognizer.state == UIGestureRecognizerStateEnded ||
		rotationRecognizer.state == UIGestureRecognizerStateCancelled)
	{
		self.lastRotationValue = 0;
		[self.wheelView finalizeWheelTracking];
		self.updatingWheelViaRotationGesture = NO;
	}
}

#pragma mark - Tap Recognizing

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
	CGPoint position;
	
	//snap to tapped itemView
	for (int index = 0; index < [self.itemViews count]; index++)
	{
		VEWheelItemView *view;
		view = [self.itemViews objectAtIndex:index];
		position = [recognizer locationInView:view];
		
		if (CGRectContainsPoint(view.bounds, position)) {
			self.wheelView.currentIndex = index;
		}
	}
}

#pragma mark - KVO

//- (void)observeValueForKeyPath:(NSString *)keyPath
//					  ofObject:(id)object
//						change:(NSDictionary *)change
//					   context:(void *)context
//{
//	if (object == self.wheelView &&
//		[keyPath isEqualToString:kCurrentIndex])
//	{
//		[self handleTaskStatusWithValue:(double)self.wheelView.currentIndex];
//	}
//	if (object == self.wheelView &&
//		[keyPath isEqualToString:kCurrentFloatingIndex])
//	{
//		[self abortFinishTask];
//		[self insertInputValueWithValue:(double)self.wheelView.currentFloatingIndex];
//	}
//
//	else {
//		[super observeValueForKeyPath:keyPath
//							 ofObject:object
//							   change:change
//							  context:context];
//	}
//}

#pragma mark - WheelViewDelegate

- (void)wheelViewWantsToLayoutSubviews:(VEWheelView *)wheelView
{
	for (VEWheelItemView *itemView in self.itemViews)
	{
		itemView.startingPoint = [self.wheelView pointOnCircumferenceForAngle:itemView.angle];
	}
}


@end
