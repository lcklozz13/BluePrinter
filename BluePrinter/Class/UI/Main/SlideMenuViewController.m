//
//  SlideMenuViewController.m
//  hconline
//
//  Created by lincong on 5/3/13.
//
//

#import "SlideMenuViewController.h"
#import <QuartzCore/QuartzCore.h>

typedef enum {
    DDMenuPanDirectionLeft = 0,
    DDMenuPanDirectionRight,
} DDMenuPanDirection;

typedef enum {
    DDMenuPanCompletionLeft = 0,
    DDMenuPanCompletionRight,
    DDMenuPanCompletionRoot,
} DDMenuPanCompletion;

#define kMenuFullWidth 320.0f
#define kMenuDisplayedWidth 267.0f
#define kMenuOverlayWidth (self.view.bounds.size.width - kMenuDisplayedWidth)
#define kMenuBounceOffset 10.0f
#define kMenuBounceDuration .3f
#define kMenuSlideDuration .3f

@interface SlideMenuViewController ()
{
    CGFloat _panOriginX;
    CGPoint _panVelocity;
    DDMenuPanDirection _panDirection;
    DDMenuPanCompletion _completion;
    
    struct
    {
        unsigned int respondsToWillShowViewController:1;
        unsigned int showingLeftView:1;
        unsigned int showingRightView:1;
        unsigned int canShowRight:1;
        unsigned int canShowLeft:1;
    } _menuFlags;
}
- (void)showShadow:(BOOL)val;
- (void)resetNavButtons;
@end

@implementation SlideMenuViewController
@synthesize leftViewController;
@synthesize rightViewController;
@synthesize rootViewController;
@synthesize leftViewDidShow;
@synthesize pan;
@synthesize delegate;
@synthesize tap=_tap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setRootViewController:(UIViewController *)rootViewController1
{
    UIViewController *tmp = rootViewController;
    rootViewController = [rootViewController1 retain];
    //移除旧的根视图
    if (tmp)
    {
        [tmp removeFromParentViewController];
        [tmp.view removeFromSuperview];
        [tmp release];
        tmp = nil;
    }
    //设置新的根视图
    if (rootViewController)
    {
        rootViewController.view.frame = self.view.bounds;
        pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
        [rootViewController.view addGestureRecognizer:pan];
        [self.view addSubview:rootViewController.view];
        [self addChildViewController:rootViewController];
    }
    //设置NaviBar的左右item
    [self resetNavButtons];
}

- (void)resetNavButtons
{
    if (!rootViewController) return;
    
    UIViewController *topController = nil;
    if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navController = (UINavigationController*)rootViewController;
        if ([[navController viewControllers] count] > 0)
        {
            topController = [[navController viewControllers] objectAtIndex:0];
        }
    }
    else if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabController = (UITabBarController*)rootViewController;
        topController = [tabController selectedViewController];
        
    }
    else
    {
        topController = rootViewController;
    }
    
	//页面菜单
    if (_menuFlags.canShowLeft)
    {
        UIImage *image = [UIImage imageNamed:@"icon-personal- information"];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width + 11, image.size.height + 5)];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        topController.navigationItem.leftBarButtonItem = item;
        [item release];
        [button release];
//        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeft:)];
//        topController.navigationItem.leftBarButtonItem = item;
//        [item release];
//        [button release];
    }
    else
    {
        topController.navigationItem.leftBarButtonItem = nil;
    }
    
    if (_menuFlags.canShowRight)
    {
//        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeft:)];
//        topController.navigationItem.rightBarButtonItem = item;
//        [item release];
        UIImage *image = [UIImage imageNamed:@"icon-personal- information"];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width + 11, image.size.height + 5)];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        topController.navigationItem.leftBarButtonItem = item;
        [item release];
        [button release];
    }
    else
    {
        topController.navigationItem.rightBarButtonItem = nil;
    }
}
//显示左边视图
- (void)showLeft:(id)sender
{
    if (_completion == DDMenuPanCompletionRoot)
    {
        [self showLeftController:YES];
    }
    else
    {
        [self showRootController:YES];
    }
}
//显示右边视图
- (void)showRight:(id)sender
{
    if (_completion == DDMenuPanCompletionRoot)
    {
        [self showRightController:NO];
    }
    else
    {
        [self showRootController:NO];
    }
}
//设置右边视图控件
- (void)setRightViewController:(UIViewController *)rightController
{
    if (rightViewController)
    {
        [rightViewController removeFromParentViewController];
        [rightViewController release];
        rightViewController = nil;
    }
    
    rightViewController = [rightController retain];
    
    if (rightViewController)
    {
        [self addChildViewController:rightViewController];
    }
    
    _menuFlags.canShowRight = (rightViewController!=nil);
    [self resetNavButtons];
}
//设置左边视图控件
- (void)setLeftViewController:(UIViewController *)leftController
{
    if (leftViewController)
    {
        [leftViewController removeFromParentViewController];
        [leftViewController release];
        leftViewController = nil;
    }
    
    leftViewController = [leftController retain];
    
    if (leftViewController)
    {
        [self addChildViewController:leftViewController];
    }
    
    _menuFlags.canShowLeft = (leftViewController!=nil);
    [self resetNavButtons];
}
//显示根视图控件
- (void)showRootController:(BOOL)animated
{
    [_tap setEnabled:NO];
    rootViewController.view.userInteractionEnabled = YES;
    
    CGRect frame = rootViewController.view.frame;
    frame.origin.x = 0.0f;
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    
    if (!animated)
    {
        [UIView setAnimationsEnabled:NO];
    }
    
    [UIView animateWithDuration:.3 animations:^{
        rootViewController.view.frame = frame;
    } completion:^(BOOL finished)
    {
        if (leftViewController && leftViewController.view.superview)
        {
            [leftViewController.view removeFromSuperview];
        }
        
        if (rightViewController && rightViewController.view.superview)
        {
            [rightViewController.view removeFromSuperview];
        }
        
        _menuFlags.showingLeftView = NO;
        _menuFlags.showingRightView = NO;
        
        [self showShadow:NO];
    }];
    
    if (self.delegate && [(NSObject *)delegate respondsToSelector:@selector(slideMenuViewController:willShowViewController:)])
    {
        [self.delegate slideMenuViewController:self willShowViewController:rootViewController];
    }
    
    if (!animated) {
        [UIView setAnimationsEnabled:_enabled];
    }
    _completion = DDMenuPanCompletionRoot;
}
//显示左边视图控制器
- (void)showLeftController:(BOOL)animated
{
    if (!_menuFlags.canShowLeft) return;
    
    if (rightViewController && rightViewController.view.superview)
    {
        [rightViewController.view removeFromSuperview];
        _menuFlags.showingRightView = NO;
    }
    
    if (self.delegate && [(NSObject *)delegate respondsToSelector:@selector(slideMenuViewController:willShowViewController:)])
    {
        [self.delegate slideMenuViewController:self willShowViewController:self.leftViewController];
    }
    
    _menuFlags.showingLeftView = YES;
    [self showShadow:YES];
    
    UIView *view = self.leftViewController.view;
	CGRect frame = self.view.bounds;
	frame.size.width = kMenuFullWidth;
    view.frame = frame;
    [self.view insertSubview:view atIndex:0];
    
    frame = rootViewController.view.frame;
    frame.origin.x = CGRectGetMaxX(view.frame) - (kMenuFullWidth - kMenuDisplayedWidth);
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    
//    rootViewController.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:.3 animations:^{
        rootViewController.view.frame = frame;
    } completion:^(BOOL finished)
    {
        [_tap setEnabled:YES];
    }];
    
    if (!animated) {
        [UIView setAnimationsEnabled:_enabled];
    }
    
    _completion = DDMenuPanCompletionLeft;
}
//显示右边视图控制器
- (void)showRightController:(BOOL)animated
{
    if (!_menuFlags.canShowRight) return;
    
    if (leftViewController && leftViewController.view.superview)
    {
        [leftViewController.view removeFromSuperview];
        _menuFlags.showingLeftView = NO;
    }
    
    if (self.delegate && [(NSObject *)delegate respondsToSelector:@selector(slideMenuViewController:willShowViewController:)])
    {
        [self.delegate slideMenuViewController:self willShowViewController:self.rightViewController];
    }
    _menuFlags.showingRightView = YES;
    [self showShadow:YES];
    
    UIView *view = self.rightViewController.view;
    CGRect frame = self.view.bounds;
	frame.origin.x += frame.size.width - kMenuFullWidth;
	frame.size.width = kMenuFullWidth;
    view.frame = frame;
    [self.view insertSubview:view atIndex:0];
    
    frame = rootViewController.view.frame;
    frame.origin.x = -(frame.size.width - kMenuOverlayWidth);
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    
//    rootViewController.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:.3 animations:^{
        rootViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        [_tap setEnabled:YES];
    }];
    
    if (!animated) {
        [UIView setAnimationsEnabled:_enabled];
    }
    
    _completion = DDMenuPanCompletionRight;
}

- (void)tap:(UITapGestureRecognizer*)gesture {
    
    [gesture setEnabled:NO];
    [self showRootController:YES];
    
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        [self showShadow:YES];
        
        if (_completion == DDMenuPanCompletionRoot)
        {
            _panOriginX = self.view.frame.origin.x;
        }
        else
        {
            _panOriginX = rootViewController.view.frame.origin.x;
        }
        _panVelocity = CGPointMake(0.0f, 0.0f);
        
        if([gesture velocityInView:self.view].x > 0)
        {
            _panDirection = DDMenuPanDirectionRight;
        }
        else
        {
            _panDirection = DDMenuPanDirectionLeft;
        }
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint velocity = [gesture velocityInView:self.view];
        if((velocity.x*_panVelocity.x + velocity.y*_panVelocity.y) < 0)
        {
            _panDirection = (_panDirection == DDMenuPanDirectionRight) ? DDMenuPanDirectionLeft : DDMenuPanDirectionRight;
        }
        
        _panVelocity = velocity;
        CGPoint translation = [gesture translationInView:self.view];
        CGRect frame = rootViewController.view.frame;
        frame.origin.x = _panOriginX + translation.x;
        
        if (frame.origin.x > 0.0f && !_menuFlags.showingLeftView)
        {
            if(_menuFlags.showingRightView)
            {
                _menuFlags.showingRightView = NO;
                [self.rightViewController.view removeFromSuperview];
            }
            
            if (_menuFlags.canShowLeft)
            {
                _menuFlags.showingLeftView = YES;
                CGRect frame = self.view.bounds;
                frame.size.width = kMenuFullWidth;
                self.leftViewController.view.frame = frame;
                [self.view insertSubview:self.leftViewController.view atIndex:0];
            }
            else
            {
                frame.origin.x = 0.0f; // ignore right view if it's not set
            }
        }
        else if (frame.origin.x < 0.0f && !_menuFlags.showingRightView)
        {
            if(_menuFlags.showingLeftView)
            {
                _menuFlags.showingLeftView = NO;
                [self.leftViewController.view removeFromSuperview];
            }
            
            if (_menuFlags.canShowRight)
            {
                _menuFlags.showingRightView = YES;
                CGRect frame = self.view.bounds;
                frame.origin.x += frame.size.width - kMenuFullWidth;
                frame.size.width = kMenuFullWidth;
                self.rightViewController.view.frame = frame;
                [self.view insertSubview:self.rightViewController.view atIndex:0];
                
            }
            else
            {
                frame.origin.x = 0.0f; // ignore left view if it's not set
            }
        }
        
        rootViewController.view.frame = frame;
        
    }
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled)
    {
        //  Finishing moving to left, right or root view with current pan velocity
        if (_completion == DDMenuPanCompletionRoot && !rightViewController && !_menuFlags.showingLeftView)
        {
            return;
        }
        
        [self.view setUserInteractionEnabled:NO];
        
        _completion = DDMenuPanCompletionRoot; // by default animate back to the root
        
        if (_panDirection == DDMenuPanDirectionRight && _menuFlags.showingLeftView)
        {
            _completion = DDMenuPanCompletionLeft;
        }
        else if (_panDirection == DDMenuPanDirectionLeft && _menuFlags.showingRightView)
        {
            _completion = DDMenuPanCompletionRight;
        }
        
        CGPoint velocity = [gesture velocityInView:self.view];
        if (velocity.x < 0.0f)
        {
            velocity.x *= -1.0f;
        }
        BOOL bounce = (velocity.x > 800);
        CGFloat originX = rootViewController.view.frame.origin.x;
        CGFloat width = rootViewController.view.frame.size.width;
        CGFloat span = (width - kMenuOverlayWidth);
        CGFloat duration = kMenuSlideDuration; // default duration with 0 velocity
        
        if (bounce)
        {
            duration = (span / velocity.x); // bouncing we'll use the current velocity to determine duration
        }
        else
        {
            duration = ((span - originX) / span) * duration; // user just moved a little, use the defult duration, otherwise it would be too slow
        }
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            if (_completion == DDMenuPanCompletionLeft)
            {
                [self showLeftController:NO];
            }
            else if (_completion == DDMenuPanCompletionRight)
            {
                [self showRightController:NO];
            }
            else
            {
                [self showRootController:NO];
            }
            [rootViewController.view.layer removeAllAnimations];
            [self.view setUserInteractionEnabled:YES];
        }];
        
        CGPoint pos = rootViewController.view.layer.position;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        
        NSMutableArray *keyTimes = [[[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2] autorelease];
        NSMutableArray *values = [[[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2] autorelease];
        NSMutableArray *timingFunctions = [[[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2] autorelease];
        
        [values addObject:[NSValue valueWithCGPoint:pos]];
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [keyTimes addObject:[NSNumber numberWithFloat:0.0f]];
        if (bounce)
        {
            duration += kMenuBounceDuration;
            [keyTimes addObject:[NSNumber numberWithFloat:1.0f - ( kMenuBounceDuration / duration)]];
            if (_completion == DDMenuPanCompletionLeft)
            {
                [values addObject:[NSValue valueWithCGPoint:CGPointMake(((width/2) + span) + kMenuBounceOffset, pos.y)]];
            }
            else if (_completion == DDMenuPanCompletionRight)
            {
                [values addObject:[NSValue valueWithCGPoint:CGPointMake(-((width/2) - (kMenuOverlayWidth-kMenuBounceOffset)), pos.y)]];
                
            }
            else
            {
                // depending on which way we're panning add a bounce offset
                if (_panDirection == DDMenuPanDirectionLeft)
                {
                    [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) - kMenuBounceOffset, pos.y)]];
                }
                else
                {
                    [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) + kMenuBounceOffset, pos.y)]];
                }
            }
            
            [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        }
        
        if (_completion == DDMenuPanCompletionLeft)
        {
            [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) + span, pos.y)]];
        }
        else if (_completion == DDMenuPanCompletionRight)
        {
            [values addObject:[NSValue valueWithCGPoint:CGPointMake(-((width/2) - kMenuOverlayWidth), pos.y)]];
        }
        else
        {
            [values addObject:[NSValue valueWithCGPoint:CGPointMake(width/2, pos.y)]];
        }
        
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [keyTimes addObject:[NSNumber numberWithFloat:1.0f]];
        
        animation.timingFunctions = timingFunctions;
        animation.keyTimes = keyTimes;
        //animation.calculationMode = @"cubic";
        animation.values = values;
        animation.duration = duration;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [rootViewController.view.layer addAnimation:animation forKey:nil];
        [CATransaction commit];
    }
}
//设置显示边缘阴影效果
- (void)showShadow:(BOOL)val
{
    if (!rootViewController) return;
    
    rootViewController.view.layer.shadowOpacity = val ? 0.8f : 0.0f;
    if (val)
    {
        rootViewController.view.layer.cornerRadius = 4.0f;
        rootViewController.view.layer.shadowOffset = CGSizeZero;
        rootViewController.view.layer.shadowRadius = 4.0f;
        rootViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    }
}

- (void)setRootController:(UIViewController *)controller animated:(BOOL)animated {
    
    if (!controller)
    {
        [self setRootViewController:controller];
        return;
    }
    
    if (_menuFlags.showingLeftView)
    {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        // slide out then come back with the new root
        __block  typeof(self) selfRef = self;
        __block UIViewController *rootRef = rootViewController;
        CGRect frame = rootRef.view.frame;
        frame.origin.x = rootRef.view.bounds.size.width;
        
        [UIView animateWithDuration:.1 animations:^{
            
            rootRef.view.frame = frame;
            
        } completion:^(BOOL finished) {
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
            [selfRef setRootViewController:controller];
            rootViewController.view.frame = frame;
            [selfRef showRootController:animated];
            
        }];
    }
    else
    {
        // just add the root and move to it if it's not center
        [self setRootViewController:controller];
        [self showRootController:animated];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (!_tap) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.delegate = (id<UIGestureRecognizerDelegate>)self;
        [self.view addGestureRecognizer:tap];
        [tap setEnabled:NO];
        _tap = tap;
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f)
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers
{
    return YES;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods
{
    return YES;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [leftViewController.view removeFromSuperview];
    [rightViewController.view removeFromSuperview];
    [rootViewController.view removeFromSuperview];
    self.leftViewController = nil;
    self.rightViewController = nil;
    self.rootViewController = nil;
    self.pan = nil;
    _tap = nil;
    
    [super dealloc];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    // Check for horizontal pan gesture
    if (gestureRecognizer == pan) {
        
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:self.view];
        
        if ([panGesture velocityInView:self.view].x < 600 && sqrt(translation.x * translation.x) / sqrt(translation.y * translation.y) > 1) {
            return YES;
        }
        
        return NO;
    }
    
    if (gestureRecognizer == _tap) {
        
        if (rootViewController && (_menuFlags.showingRightView || _menuFlags.showingLeftView)) {
            return CGRectContainsPoint(rootViewController.view.frame, [gestureRecognizer locationInView:self.view]);
        }
        
        return NO;
        
    }
    
    return YES;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer==_tap) {
        return YES;
    }
    return NO;
}

@end
