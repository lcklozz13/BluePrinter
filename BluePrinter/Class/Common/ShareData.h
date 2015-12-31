//
//  ShareData.h
//  PreferentialLife
//
//  Created by 窗外` on 12-8-21.
//  Copyright (c) 2012年 Neptune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

//全局变量
extern AppDelegate *m_appDelegate;
extern UIAlertView *m_alert;
extern UINavigationController *m_nav;

//字体
#define FONT_WITH_SIZE(SIZE) [UIFont systemFontOfSize:SIZE]
#define FONT_BOLD_WITH_SIZE(SIZE) [UIFont boldSystemFontOfSize:SIZE]

#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define _isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]
#define INTERFACE_ORIENTATION (interfaceOrientation == UIInterfaceOrientationPortrait)

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define SCREEN_HEIGHT SCREEN_SIZE.height
#define SCREEN_WIDTH SCREEN_SIZE.width
#define VIEW_HEIGHT (SCREEN_HEIGHT - 20) //去掉状态栏的高度

//颜色
#define UICOLOR_RGB(a, b, c, alp) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:alp]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CLEAR_COLOR [UIColor clearColor]
#define DARK_GRAY_COLOR [UIColor darkGrayColor]
#define BLACK_COLOR [UIColor blackColor]
#define WHITE_COLOR [UIColor whiteColor]
#define BLUE_COLOR [UIColor blueColor]
#define LIGHT_GRAY_COLOR [UIColor lightGrayColor]
#define GRAY_COLOR [UIColor grayColor]
#define RED_COLOR [UIColor redColor]
#define GREEN_COLOR [UIColor greenColor]

#define GRAY_COLOR_BG UICOLOR_RGB(244, 244, 244, 1)
#define DARK_GRAY_COLOR_TEXT UICOLOR_RGB(52, 53, 55, 1)
#define LIGHT_GRAY_COLOR_TEXT UICOLOR_RGB(142, 142, 147, 1)
#define RED_COLOR_TEXT UICOLOR_RGB(250, 56, 65, 1)

//uitextfield输入限制
#define kLimitLetterNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define kLimitLetter @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define kLimitNum @"0123456789"

//时间KEY
#define key_time_year @"time_year"
#define key_time_month @"time_month"
#define key_time_day @"time_day"
#define key_time_hour @"time_hour"
#define key_time_min @"time_min"
#define key_time_week @"time_week"
#define key_time_weekday @"time_weekday"

#define NSSTRING_OBJECT(object) [ShareFunction getStringWithData:object]
#define NSSTRING_NUM(num) [NSString stringWithFormat:@"%d", (int)(num)]
#define NSARRAY(ary) [[NSArray alloc] initWithArray:ary]
#define NSMUTABLEARRAY(ary) [NSMutableArray arrayWithArray:ary]
#define NSDICTIONARY(dic) [[NSDictionary alloc] initWithDictionary:dic]
#define NSMUTABLEDICTIONARY(dic) [NSMutableDictionary dictionaryWithDictionary:dic]

