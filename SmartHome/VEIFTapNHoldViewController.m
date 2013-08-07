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
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer; //ICH

@property (nonatomic, strong) id<tapNHoldDelegate> delegate;
@property (nonatomic, assign) NSInteger cookerIndex;

@property (nonatomic,assign) int tapCounter;//ICH

@property (nonatomic,strong) UIView *superView;
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

- (id)initWithIndex:(NSInteger)index cookerValue:(NSInteger)value andDelegate:(id<tapNHoldDelegate>)delegate andSuperView:(UIView*)superView
{
    self = [super init];
    self.superView = superView;

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
	smallButtonSize = CGSizeMake (self.currentButtonSize.width * 0.45f,
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

	//	[smallButton setBackgroundColor:[UIColor greenColor]];
		//increase font size manually a bit (oder eben nicht)
		smallButton.button.titleLayer.fontSize *= 0.5f;
		//smallButton.backgroundColor = [UIColor greenColor];
		smallButton.button.titleLayer.string = icon.title;
		smallButton.button.imageLayer.contents = (__bridge id)(icon.icon.CGImage);
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(handleTapGestureOnSmallButton:)];
        [smallButton addGestureRecognizer:tapGestureRecognizer];
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
	
	UILongPressGestureRecognizer*recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
																							action:@selector(handleTapGesture:)];
    [self.tapNHoldView addGestureRecognizer:recognizer];
	recognizer.minimumPressDuration = 0.3f;
   // [self.tapNHoldView setBackgroundColor:[UIColor redColor]];
    
    UITapGestureRecognizer *tapRecognizerX = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureOnSmallButton:)];
    [self.tapNHoldView addGestureRecognizer:tapRecognizerX];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureDOS:)];
    [self.tapNHoldView addGestureRecognizer:tapRecognizer];
    
    self.tapCounter=0;

}

- (void)dealloc
{

}

#pragma mark - Handle pan Gesture

//Original!! handletapgesture
//- (void)handleTapGesture:(UILongPressGestureRecognizer *)recognizer
//{
//	CGPoint position;
//	position = [recognizer locationInView:self.tapNHoldView];
//	
//	if (recognizer.state == UIGestureRecognizerStateBegan)
//	{
//		if ([self.tapNHoldView.button.backgroundLayer containsPoint:position]) {
//			self.tapNHoldView.button.pressed = YES;
//			[self setSmallButtonsHidden:NO];
//		}
//		
////		[self abortFinishTask];
//		
//		return;
//	}
//	
//	if (self.isActive == NO)
//	{
//		return;
//	}
//	
//	if (recognizer.state == UIGestureRecognizerStateCancelled ||
//		recognizer.state == UIGestureRecognizerStateEnded)
//	{
//		if (self.smallButtonsAnimationEnded == YES)
//		{
//			for (NSUInteger index = 0; index < [self.smallButtonViews count]; index++)
//			{
//				VETapNHoldView *smallButtonView;
//				
//				smallButtonView = [self.smallButtonViews objectAtIndex:index];
//				position = [recognizer locationInView:smallButtonView];
//				
//				if ([smallButtonView.button.backgroundLayer containsPoint:position]){
//					self.currentIndex = index;
//                    [self updateTapNHoldViewToCurrentIndex];
//
//				}
//			}
//		}
//		
//		self.tapNHoldView.button.pressed = NO;
//		[self setSmallButtonsHidden:YES];
//		return;
//	}
//	
//	for (VETapNHoldView *smallButtonView in self.smallButtonViews)
//	{
//		position = [recognizer locationInView:smallButtonView];
//		if ([smallButtonView.button.backgroundLayer containsPoint:position]) {
//			smallButtonView.button.highlighted = YES;
//			continue;
//		}
//		smallButtonView.button.highlighted = NO;
//	}
//}

- (void)handleTapGestureOnSmallButton:(UITapGestureRecognizer *)tapRecognizer
{
    for (NSUInteger index = 0; index < [self.smallButtonViews count]; index++)
    {
        VETapNHoldView *smallButtonView = [self.smallButtonViews objectAtIndex:index];
        CGPoint position = [tapRecognizer locationInView:smallButtonView];

        if ([smallButtonView.button.backgroundLayer containsPoint:position])
        {
            self.currentIndex = index;
            [self updateTapNHoldViewToCurrentIndex];
            self.tapNHoldView.button.pressed = NO;
            [self setSmallButtonsHidden:YES];
            self.tapCounter++;
            break;
        }
    }
}


//ICH: Auskommentierter handletapgesture code von mir auf basis von 'recognizer'
- (void)handleTapGesture:(UILongPressGestureRecognizer *)recognizer
{

	CGPoint position;
	position = [recognizer locationInView:self.tapNHoldView];

	if (recognizer.state == UIGestureRecognizerStateBegan)
	{
        if (self.tapCounter%2==0) {

            if ([self.tapNHoldView.button.backgroundLayer containsPoint:position])
            {
                self.tapNHoldView.button.pressed = YES;
                [self setSmallButtonsHidden:NO];
            }

            self.tapCounter++;
            return;
        }
        if (self.tapCounter%2==1){

            if ([self.tapNHoldView.button.backgroundLayer containsPoint:position]) {
                self.tapNHoldView.button.pressed = NO;
                [self setSmallButtonsHidden:YES];
            }

            self.tapCounter++;
            return;

        }
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
            self.tapCounter++;
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


//ICH: handleTapGesture auf basis von tapRecognizer anstatt recognizer
- (void)handleTapGestureDOS:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"tapcounter: %d", self.tapCounter);
    
	CGPoint position;
	position = [tapRecognizer locationInView:self.tapNHoldView];
    
    if (self.tapCounter%2==0)
    {
        
        NSLog(@"Step1: open smallbuttons");
        
        if ([self.tapNHoldView.button.backgroundLayer containsPoint:position])
        {
            self.tapNHoldView.button.pressed = YES;
            [self setSmallButtonsHidden:NO];
            
        }
        
    } else {
        
        //if ([self.tapNHoldView.button.backgroundLayer containsPoint:position])
        //{
            
            NSLog(@"Step2a: close smallbuttons (click on main button)");
            self.tapNHoldView.button.pressed = NO;
            [self setSmallButtonsHidden:YES];
            
        /*} else {
            
            NSLog(@"Step2a: close smallbuttons (click on main button)");
            if (self.smallButtonsAnimationEnded == YES)
            {
                for (NSUInteger index = 0; index < [self.smallButtonViews count]; index++)
                {
                    VETapNHoldView *smallButtonView;
                    smallButtonView = [self.smallButtonViews objectAtIndex:index];
                    position = [tapRecognizer locationInView:smallButtonView];
                    if ([smallButtonView.button.backgroundLayer containsPoint:position])
                    {
                        self.currentIndex = index;
                        [self updateTapNHoldViewToCurrentIndex];
                    }
                }
            }
            self.tapNHoldView.button.pressed = NO;
            [self setSmallButtonsHidden:YES];
            //return;
        }*/
        
        
        /*for (NSUInteger index = 0; index < [self.smallButtonViews count]; index++)
        {
            VETapNHoldView *smallButtonView;
            [smallButtonView setBackgroundColor:[UIColor blueColor]];
            
            smallButtonView = [self.smallButtonViews objectAtIndex:index];
            position = [tapRecognizer locationInView:smallButtonView];
            
            if ([smallButtonView.button.backgroundLayer containsPoint:position])
            {
                NSLog(@"Step2b: close smallbuttons (click on smallbuttons) + update value");
                self.currentIndex = index;
                [self updateTapNHoldViewToCurrentIndex];
                
                self.tapNHoldView.button.pressed = NO;
                [self setSmallButtonsHidden:YES];
                smallButtonView.button.highlighted = YES;
            } else //if ([self.tapNHoldView.button.backgroundLayer containsPoint:position])
            {
                NSLog(@"Step2a: close smallbuttons (click on main button)");
                self.tapNHoldView.button.pressed = NO;
                [self setSmallButtonsHidden:YES];
            }*/
	}
    
    self.tapCounter++;
    
	
//	if (self.isActive == NO)
//	{
//		return;
//	}
    
    //Funktioniert nicht
//    if (tapRecognizer.state == UIGestureRecognizerStateChanged)
//    {
//        for (NSUInteger index = 0; index < [self.smallButtonViews count]; index++)
//        {
//            VETapNHoldView *smallButtonView;
//            
//            smallButtonView = [self.smallButtonViews objectAtIndex:index];
//            position = [tapRecognizer locationInView:smallButtonView];
//            
//            if ([smallButtonView.button.backgroundLayer containsPoint:position]){
//                self.currentIndex = index;
//                [self updateTapNHoldViewToCurrentIndex];
//                
//            }
//        }
//    }
    
	
//	if (tapRecognizer.state == UIGestureRecognizerStateCancelled ||
//		tapRecognizer.state == UIGestureRecognizerStateEnded)
//	{
//		if (self.smallButtonsAnimationEnded == YES)
//		{
//			for (NSUInteger index = 0; index < [self.smallButtonViews count]; index++)
//			{
//				VETapNHoldView *smallButtonView;
//				
//				smallButtonView = [self.smallButtonViews objectAtIndex:index];
//				position = [tapRecognizer locationInView:smallButtonView];
//				
//				if ([smallButtonView.button.backgroundLayer containsPoint:position]){
//					self.currentIndex = index;
//                    [self updateTapNHoldViewToCurrentIndex];
//                    
//				}
//			}
//		}
//		
//		self.tapNHoldView.button.pressed = NO;
        //		[self setSmallButtonsHidden:YES];
//		return;
//	}
	
//	for (VETapNHoldView *smallButtonView in self.smallButtonViews)
//	{
//		position = [tapRecognizer locationInView:smallButtonView];
//		if ([smallButtonView.button.backgroundLayer containsPoint:position]) {
//			smallButtonView.button.highlighted = YES;
//			continue;
//		}
//		smallButtonView.button.highlighted = NO;
//	}
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
    [self.superView bringSubviewToFront:self.view];
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
   // [self.view setBackgroundColor:[UIColor yellowColor]];
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
