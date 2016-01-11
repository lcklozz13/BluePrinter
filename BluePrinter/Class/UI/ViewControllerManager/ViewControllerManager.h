//
//  ViewControllerManager.h
//  LittleFawn
//
//  Created by baidu on 15/12/24.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SlideMenuViewController.h"

typedef NS_ENUM(NSInteger, ViewType)
{
    ViewTyp_turnInto,
    ViewType_turnOut
};

@interface ViewControllerManager : NSObject
+ (ViewControllerManager *)getInstance;
- (UIViewController *)getRootViewController;
- (SlideMenuViewController *)getSlideMenuView;
- (void)setLoginSuccessBackViewController:(UIViewController *)backViewController;
- (UIViewController *)loginSuccessBackViewController;
+ (UINavigationController *)createNavigationWithRootViewController:(UIViewController *)vc;
- (UIViewController *)getVisableRootViewController;
@end
