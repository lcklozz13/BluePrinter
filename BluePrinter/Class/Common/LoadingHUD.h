//
//  LoadingHUD.h
//  TuanXin
//
//  Created by 窗外` on 13-12-9.
//  Copyright (c) 2013年 窗外`. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define LOADING_HUD [LoadingHUD sharedInstance]
#define LOADING_HUD_TAG 31415926

@interface LoadingHUD : NSObject

+ (void)showWithText:(NSString *)text inSuperView:(UIView *)superView;
+ (void)showWithText:(NSString *)text;
+ (void)showInSuperView:(UIView *)view;
+ (void)show;
+ (void)hide;
+ (void)stopTimer;

@end
