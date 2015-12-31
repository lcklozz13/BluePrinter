//
//  LeftMenuHeadView.m
//  BluePrinter
//
//  Created by klozz on 15/11/2.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "LeftMenuHeadView.h"
#import "SlideMenuViewController.h"
//#import "MyAccountReviewController.h"
//#import "LoginAccController.h"

@implementation LeftMenuHeadView

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)cellHeight
{
    return 247.0f;
}

- (IBAction)btnCallback:(id)sender
{
//    if (!DATA_MANAGER.isLogin) {
//        //未登录 跳到登录界面
//        SlideMenuViewController *viewController = (SlideMenuViewController *)[[UIApplication sharedApplication].keyWindow rootViewController];
//        [viewController showRootController:YES];
//
//        LoginAccController *loginView = [[LoginAccController alloc] init];
//        [(UINavigationController *)viewController.rootViewController pushViewController:loginView animated:YES];
//        return;
//    }

//    SlideMenuViewController *viewController = (SlideMenuViewController *)[[UIApplication sharedApplication].keyWindow rootViewController];
//    [viewController showRootController:YES];
//    
//    MyAccountReviewController *vc = [[MyAccountReviewController alloc] init];
//    [(UINavigationController *)viewController.rootViewController pushViewController:vc animated:NO];
}

@end
