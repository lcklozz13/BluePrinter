//
//  SlideMenuViewController.h
//  hconline
//
//  Created by lincong on 5/3/13.
//
//

#import <UIKit/UIKit.h>

@protocol SlideMenuViewControllerDelegate;
//左右滑动显示子视图的控件
@interface SlideMenuViewController : UIViewController
@property (nonatomic, assign) id<SlideMenuViewControllerDelegate>delegate;
@property (nonatomic, retain) UIViewController      *leftViewController;//左边的视图控件
@property (nonatomic, retain) UIViewController      *rightViewController;//右边的视图控件
@property (nonatomic, retain) UIViewController      *rootViewController;//根视图控件
@property (nonatomic, assign) BOOL                   leftViewDidShow;//左边的视图是否已经展现
@property (nonatomic, retain) UIPanGestureRecognizer    *pan;//接受滑动手势
@property(nonatomic,readonly) UITapGestureRecognizer    *tap;//接受点击手势
- (void)showRootController:(BOOL)animated;//显示根视图
- (void)showRightController:(BOOL)animated;//显示右边视图
- (void)showLeftController:(BOOL)animated;//显示左边视图
- (void)setRootController:(UIViewController *)controller animated:(BOOL)animated;//设置根视图
@end

@protocol SlideMenuViewControllerDelegate
//将要显示某个视图
- (void)slideMenuViewController:(SlideMenuViewController*)controller willShowViewController:(UIViewController*)controller;
@end