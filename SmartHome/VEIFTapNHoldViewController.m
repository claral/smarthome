//
//  VETabNHoldElementViewController.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 16.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "VEIFTapNHoldViewController.h"


#define kSmallButtonDistance 150.0f


@interface VEIFTapNHoldViewController ()

@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, assign) NSString *kCurrentIndex;

@property (nonatomic, assign) CGSize currentButtonSize;

@property (nonatomic, strong) VETapNHoldView *tapNHoldView;
@property (nonatomic, strong) NSArray *smallButtonViews;

@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, assign) BOOL smallButtonsAnimationEnded;
@property (nonatomic, assign) BOOL wantsToHideSmallButtons;

@property (nonatomic, strong) UILongPressGestureRecognizer *recognizer;

@property (nonatomic, strong) id<tapNHoldDelegate> delegate;
@property (nonatomic, assign) NSInteger cookerIndex;

@end

@implementation VEIFTapNHoldViewController

@synthesize delegate = _delegate;

#pragma mark - View Life Cycle

- (id)init
{
    self = [super init];
    if (self) {
   
    }
    return self;
}

- (id)initWithIndex:(NSInteger)index cookerValue:(NSInteger)value andDelegate:(id<tapNHoldDelegate>)delegate;
{
    self = [super init];

    self.cookerIndex = index;
    self.delegate = delegate;
    self.currentIndex = value;
    [self updateTapNHoldViewToCurrentIndex];
    
    return self;
}
- (void)setCookerValue:(NSInteger)value
{
    self.currentIndex = value;
    [self updateTapNHoldViewToCurrentIndex];
}

- (void)setPredefinedValue:(id)value
{
	self.tabBarController.selectedIndex = [value integerValue];
}

- (NSArray *)loadSmallButtonViews
{
	CGRect smallButtonRect;
	CGSize smallButtonSize;
	
	NSMutableArray *smallButtonViews = [NSMutableArray array];
	smallButtonSize = CGSizeMake(self.currentButtonSize.width * 0.45f,
								 self.currentButtonSize.height * 0.45f);
	
	smallButtonRect = CGRectMake(CGRectGetMidX(self.view.bounds) - smallButtonSize.width * 0.5f,
								 CGRectGetMidY(self.view.bounds) - smallButtonSize.height * 0.5f,
								 smallButtonSize.width,
								 smallButtonSize.height);
	
	for (SHIconWithTitle *icon in self.items)
	{
		VETapNHoldView *smallButton;
		smallButton = [[VETapNHoldView alloc] initWithFrame:smallButtonRect];
		smallButton.layer.opacity = 0.5f;
		
		//increase font size manually a bit (oder eben nicht)
		smallButton.button.titleLayer.fontSize *= 0.5f;
		
		smallButton.button.titleLayer.string = icon.title;
		smallButton.button.imageLayer.contents = (__bridge id)(icon.icon.CGImage);
		
		[self.view addSubview:smallButton];
		[smallButtonViews addObject:smallButton];
	}
	return smallButtonViews;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.currentButtonSize = CGSizeMake(200, 200);
	self.smallButtonViews = [self loadSmallButtonViews];
	
	self.tapNHoldView = [[VETapNHoldView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - self.currentButtonSize.width * 0.5f,
																		 CGRectGetMidY(self.view.bounds) - self.currentButtonSize.width * 0.5f,
																		 self.currentButtonSize.width,
																		 self.currentButtonSize.height)];
	[self.view addSubview:self.tapNHoldView];
	[self.view bringSubviewToFront:self.tapNHoldView];
	
	
//	[self addObserver:self
//		   forKeyPath:self.kCurrentIndex
//			  options:NSKeyValueObservingOptionInitial
//			  context:nil];
	
	
	UILongPressGestureRecognizer*recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
																							action:@selector(handleTapGesture:)];
	recognizer.minimumPressDuration = 0.0f;
	[self.tapNHoldView addGestureRecognizer:recognizer];
}

- (void)dealloc
{
	//	self.isActive = NO;
	//
//	[self removeObserver:self forKeyPath:kCurrentIndex];
	//
	//	self.recognizer.enabled = NO;
	//	self.recognizer.delegate = nil;
	//
	//	for (UIGestureRecognizer *rec in self.tapNHoldView.gestureRecognizers) {
	//		rec.enabled = NO;
	//		rec.delegate = nil;
	//		[self.tapNHoldView removeGestureRecognizer:rec];
	//	}
	//
	//
	//	[[self tapNHoldView] removeFromSuperview];
	//
	//	for (VETapNHoldView *view in self.smallButtonViews)
	//	{
	//		[view removeFromSuperview];
	//	}
	//
	//	self.tapNHoldView = nil;
	//	self.smallButtonViews  = nil;
}

#pragma mark - Handle pan Gesture

- (void)handleTapGesture:(UILongPressGestureRecognizer *)recognizer
{
	CGPoint position;
	position = [recognizer locationInView:self.tapNHoldView];
	
	if (recognizer.state == UIGestureRecognizerStateBegan)
	{
		if ([self.tapNHoldView.button.backgroundLayer containsPoint:position]) {
			self.tapNHoldView.button.pressed = YES;
			[self setSmallButtonsHidden:NO];
		}
		
//		[self abortFinishTask];
		
		return;
	}
	
	if (self.isActive == NO)
	{
		return;
	}
	
	if (recognizer.state == UIGestureRecognizerStateCancelled ||
		recognizer.state == UIGestureRecognizerStateEnded)
	{
		if (self.smallButtonsAnimationEnded == YES)
		{
			for (NSUInteger index = 0; index < [self.smallButtonViews count]; index++)
			{
				VETapNHoldView *smallButtonView;
				
				smallButtonView = [self.smallButtonViews objectAtIndex:index];
				position = [recognizer locationInView:smallButtonView];
				
				if ([smallButtonView.button.backgroundLayer containsPoint:position]){
					self.currentIndex = index;
                    [self updateTapNHoldViewToCurrentIndex];

				}
			}
		}
		
		self.tapNHoldView.button.pressed = NO;
		[self setSmallButtonsHidden:YES];
		return;
	}
	
	for (VETapNHoldView *smallButtonView in self.smallButtonViews)
	{
		position = [recognizer locationInView:smallButtonView];
		if ([smallButtonView.button.backgroundLayer containsPoint:position]) {
			smallButtonView.button.highlighted = YES;
			continue;
		}
		smallButtonView.button.highlighted = NO;
	}
}

#pragma mark - Helper

- (void)updateTapNHoldViewToCurrentIndex
{
	VETapNHoldView *newSelectedView;
	newSelectedView = [self.smallButtonViews objectAtIndex:self.currentIndex];
	self.tapNHoldView.button.imageLayer.contents = newSelectedView.button.imageLayer.contents;
	self.tapNHoldView.button.titleLayer.string = newSelectedView.button.titleLayer.string;
	
	[self.tapNHoldView setNeedsDisplay];
	[self.tapNHoldView setNeedsLayout];
    
    [self.delegate cooker:self.cookerIndex didChangeTo:self.currentIndex];
}


- (void)setSmallButtonsHidden:(BOOL)hidden
{
	self.isActive = !hidden;
	
	if (hidden == YES)
	{
		if (self.smallButtonsAnimationEnded == NO) {
			self.wantsToHideSmallButtons = YES;
		}
		else {
			[self hideSmallButtonsWithDelay:0.2f];
		}
	}
	else {
		[self showSmallButtons];
	}
	
}

- (void)showSmallButtons
{
	[UIView beginAnimations:@"animateOut" context:nil];
	[UIView setAnimationDuration:0.25f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	for (NSUInteger index = 0; index < [self.smallButtonViews count]; index++)
	{
		// Idee: Konstruiere rechtwinkliges Dreieck mit Punkt P(x1,y), Gegeben: center(x/y), alpha, Gesucht: x1/y1
		// 1. Antwort http://www.uni-protokolle.de/foren/viewt/181455,0.html
		// y1 -->	sin(alpha) = BP / distance = (y - y1) / distance
		//			y1 = -(sin(alpha) * distance) + y
		// x1 -->	cos(alpha) = AP / distance = (x1 - x) / distance
		//			x1 = cos(alpha) * distance + x
		CGPoint smallButtonPosition;
		
		CGFloat angle;
		CGPoint center;
		CGFloat x1;
		CGFloat y1;
		
		angle = [self angleForIndex:index];
		center = self.tapNHoldView.layer.position;
		y1 = -(sin(angle) * kSmallButtonDistance) + center.y;
		x1 = cos(angle) * kSmallButtonDistance + center.x;
		
		smallButtonPosition = CGPointMake(x1, y1);
		
		VETapNHoldView *currentView;
		currentView = [self.smallButtonViews objectAtIndex:index];
		
		currentView.layer.opacity = 1.0f;
		currentView.layer.position = smallButtonPosition;
	}
	
	self.smallButtonsAnimationEnded = NO;
	[UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	self.smallButtonsAnimationEnded = YES;
	
	if (self.wantsToHideSmallButtons == YES) {
		[self hideSmallButtonsWithDelay:0.2f];
		self.wantsToHideSmallButtons = NO;
	}
}

- (void)hideSmallButtonsWithDelay:(float)delay
{
	[UIView beginAnimations:@"animateIn" context:nil];
	[UIView setAnimationDuration:0.1f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDelay:delay];
	
	for (VETapNHoldView *smallButtonView in self.smallButtonViews)
	{
		smallButtonView.button.highlighted = NO;
		smallButtonView.layer.opacity = 0.0f;
		smallButtonView.layer.position = self.tapNHoldView.layer.position;
	}
	
	[UIView commitAnimations];
}

- (CGFloat)angleForIndex:(float)index
{
	CGFloat anglePerIndex;
	CGFloat angle;
	
	anglePerIndex = 2 * M_PI / (float)[self.smallButtonViews count];
	angle = anglePerIndex * (float)(index);
	return angle;
}


#pragma mark - KVO

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if (keyPath == nil) return;
//	if (object == self && [keyPath isEqualToString:self.kCurrentIndex])
//	{
//		[self updateTapNHoldViewToCurrentIndex];
//		
////		[self handleTaskStatusWithValue:(double)self.currentIndex];
//	}
//	else {
//		[super observeValueForKeyPath:keyPath
//							 ofObject:object
//							   change:change
//							  context:context];
//	}
//}

@end
