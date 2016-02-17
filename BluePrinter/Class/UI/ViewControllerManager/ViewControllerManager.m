//
//  ViewControllerManager.m
//  LittleFawn
//
//  Created by baidu on 15/12/24.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "ViewControllerManager.h"
#import "GuidViewController.h"
#import "RecommendedViewController.h"
#import "FinancialProductViewController.h"
#import "MyAssetsViewController.h"
#import "MoreActionViewController.h"
#import "LeftMenuTableViewController.h"


#define ISFIRSTLOAD     @"IsFirstLoad"


@interface ViewControllerManager ()<SlideMenuViewControllerDelegate>
@property (nonatomic, strong) SlideMenuViewController       *slideViewController;
@property (nonatomic, strong) UIViewController              *backViewController;
@property (nonatomic, strong) UITabBarController            *rootController;
- (UIViewController *)getRootViewControllers;
- (UIViewController *)createSlideViewController;
+ (BOOL)isFirstLoad;
@end

@implementation ViewControllerManager

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:245.0f/255.0f green:57.0f/255.0f blue:48.0f/255.0f alpha:1.0f]];
    }
    
    return self;
}

+ (BOOL)isFirstLoad
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    if (![userDef valueForKey:ISFIRSTLOAD])
    {
        [userDef setBool:YES forKey:ISFIRSTLOAD];
        return YES;
    }
    
    return NO;
}



+ (ViewControllerManager *)getInstance
{
    static ViewControllerManager *_ViewControllerManager = nil;
    
    if (!_ViewControllerManager)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _ViewControllerManager = [[ViewControllerManager alloc] init];
        });
    }
    
    
    return _ViewControllerManager;
}

+ (void)setTabBarItemForVc:(UIViewController *)vc selectedImage:(NSString *)selected unSelectImage:(NSString *)unselect vcTitle:(NSString *)title
{
    UIImage *image         = [UIImage imageNamed:unselect];
    UIImage *selectedImage = [UIImage imageNamed:selected];
    
    // 解决ios8下tabbar选中图标跟随背景变蓝色
    if([selectedImage respondsToSelector:@selector(imageWithRenderingMode:)])
    {
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:138.0f/255.0f green:138.0f/255.0f blue:138.0f/255.0f alpha:1.0f], NSFontAttributeName:[UIFont systemFontOfSize:13]}
                                 forState:UIControlStateNormal];
    
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:245.0f/255.0f green:57.0f/255.0f blue:48.0f/255.0f alpha:1.0f], NSFontAttributeName:[UIFont systemFontOfSize:13]}
                                 forState:UIControlStateSelected];
    
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    [vc.tabBarItem setTitle:title];
}

+ (UINavigationController *)createNavigationWithRootViewController:(UIViewController *)vc
{
    UINavigationController *navi = [[UINavigationController alloc] init];
    [navi setViewControllers:[NSArray arrayWithObject:vc]];
    
    return navi;
}

- (UIViewController *)getRootViewControllers
{
    if (!_rootController)
    {
        RecommendedViewController *recommended = [[RecommendedViewController alloc] init];
//        FinancialProductViewController *product = [[FinancialProductViewController alloc] init];
        MyAssetsViewController  *myAssets = [[MyAssetsViewController alloc] init];
        MoreActionViewController *more = [[MoreActionViewController alloc] init];
        
        
        [[self class] setTabBarItemForVc:recommended selectedImage:@"icon-recommend-select" unSelectImage:@"icon-recommend-unselected" vcTitle:@"精品推荐"];
//        [[self class] setTabBarItemForVc:product selectedImage:@"icon-product-selected" unSelectImage:@"icon-product-unselected" vcTitle:@"理财产品"];
        [[self class] setTabBarItemForVc:myAssets selectedImage:@"icon-my-selected" unSelectImage:@"icon-my-unselected" vcTitle:@"我的资产"];
        [[self class] setTabBarItemForVc:more selectedImage:@"icon-more-selected" unSelectImage:@"icon-more-unselected" vcTitle:@"更多"];
        
        NSArray *controllers = [NSArray arrayWithObjects:
                                [[self class] createNavigationWithRootViewController:recommended],
//                                [[self class] createNavigationWithRootViewController:product],
                                [[self class] createNavigationWithRootViewController:myAssets],
                                [[self class] createNavigationWithRootViewController:more],
                                nil];
        
        _rootController = [[UITabBarController alloc] init];
        [_rootController setViewControllers:controllers];
    }
    
    return self.rootController;
}

- (UIViewController *)getVisableRootViewController
{
    if (self.rootController)
    {
        NSArray *viewcontrollers = [self.rootController viewControllers];
        
        return viewcontrollers[self.rootController.selectedIndex];
    }
    
    return nil;
}

- (UIViewController *)createSlideViewController
{
    if (!self.slideViewController)
    {
        _slideViewController = [[SlideMenuViewController alloc] init];
        UIViewController *root = [self getRootViewControllers];
        
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
        
        LeftMenuTableViewController *left = [[LeftMenuTableViewController alloc] init];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [imageView setImage:[UIImage imageNamed:@"bg-personal"]];
        [left.tableView setBackgroundView:imageView];
        
        [_slideViewController setRightViewController:nil];
        [_slideViewController setLeftViewController:left];
        [_slideViewController setRootViewController:root];
        _slideViewController.delegate = self;
        [_slideViewController showRootController:YES];
        [_slideViewController.pan setEnabled:NO];
    }
    
    return self.slideViewController;
}

- (UIViewController *)getRootViewController
{
    if ([[self class] isFirstLoad])
    {
        return [[GuidViewController alloc] init];
    }
    else
    {
        return [self createSlideViewController];
    }
}

- (SlideMenuViewController *)getSlideMenuView
{
    return self.slideViewController;
}

- (void)setLoginSuccessBackViewController:(UIViewController *)backViewController
{
    self.backViewController = backViewController;
}

- (UIViewController *)loginSuccessBackViewController
{
    return self.backViewController;
}

#pragma mark SlideMenuViewControllerDelegate
- (void)slideMenuViewController:(SlideMenuViewController*)controller1 willShowViewController:(UIViewController*)controller2
{
    
}

@end
