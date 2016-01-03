//
//  LoadingHUD.m
//  TuanXin
//
//  Created by 窗外` on 13-12-9.
//  Copyright (c) 2013年 窗外`. All rights reserved.
//

#import "LoadingHUD.h"

@implementation LoadingHUD

static MBProgressHUD *HUD = nil;
static NSTimer *m_loadingTimer = nil;

- (void)dealloc
{

}

+ (void)showWithText:(NSString *)text inSuperView:(UIView *)superView
{
    if (HUD && HUD.superview != superView) {
        //显示在不同界面 删除原有的
        [HUD removeFromSuperview];
        HUD = nil;
    }
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:superView];
        HUD.tag = LOADING_HUD_TAG;
        HUD.removeFromSuperViewOnHide = YES;
        HUD.userInteractionEnabled = NO;
        HUD.center = CGPointMake(superView.frame.size.width/2, superView.frame.size.height*0.4);
        [HUD show:YES];
        [superView insertSubview:HUD atIndex:100000];
    }
    HUD.labelText = text;
    [LoadingHUD initLoadingTimer];
}

+ (void)showWithText:(NSString *)text
{
    [LoadingHUD showWithText:text inSuperView:m_appDelegate.window];
}

+ (void)showInSuperView:(UIView *)view
{
    [LoadingHUD showWithText:NSLocalizedString(@"请稍候...", nil) inSuperView:view];
}

+ (void)show
{
    [LoadingHUD showWithText:NSLocalizedString(@"请稍候...", nil)];
}

+ (void)hide
{
    if (HUD) {
        [HUD hide:YES afterDelay:0.2];
        HUD = nil;
    }
    [LoadingHUD stopTimer];
}

+ (void)initLoadingTimer
{
    [LoadingHUD stopTimer];
    m_loadingTimer = [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(loadingTimeOut) userInfo:nil repeats:NO];
}

+ (void)stopTimer
{
    if(m_loadingTimer)
    {
        [m_loadingTimer invalidate];
        m_loadingTimer = nil;
    }
}

+ (void)loadingTimeOut
{
    [ShareFunction showAlertWithText:NSLocalizedString(@"连接超时，请重试", nil)];
    [LoadingHUD hide];
}

@end

