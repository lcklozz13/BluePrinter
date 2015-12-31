//
//  ShareFunction.h
//  XM_12580
//
//  Created by mac on 12-7-9.
//  Copyright (c) 2012年 Neptune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface ShareFunction : NSObject <UIAlertViewDelegate>

//取设备唯一值 钥匙串中的uuid
+ (NSString *)getDeviceUniqueIdByService:(NSString *)service key:(NSString *)key;

//处理数据 如是null或"<null>"则返回空串
+ (NSString *)getStringWithData:(id)data;

+ (NSString*)uuid;

//取当前语言系统
+ (NSString*)getPreferredLanguage;

//hmac-Sha1加密
+ (NSData *)hmacSha1:(NSString *)key text:(NSString *)text;
+ (NSString*)sha1WithText:(NSString*)text;


#pragma mark    - 验证

//手机号码验证
+ (BOOL)checkPhoneNumInput:(NSString *)_text;
//美国手机号验证
+(BOOL)checkAmericaPhoneNumber:(NSString*)str;
//判断邮箱
+ (BOOL)validateEmail:(NSString *)email;


#pragma mark    - 十六进制转换

//十六进制字符串转换为普通字符串
+ (NSData *)stringFromHexString:(NSString *)hexString;
//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(id)string;
//获取字符串的MD5值
+ (NSString*)md5ByString:(NSString*)str;


#pragma mark    - 时间处理

+ (NSDate *)getDateWithTimeStr:(NSString *)timeStr;
+ (NSDictionary *)getDateDicWithTime:(NSDate *)date;
//获得当前时间戳
+ (NSString *)getCurrentTimeIntervalStr;
//获得当前时间
+ (NSString *)currentTime;

//冷却是否结束时间
+ (NSInteger)getLastCoolingTime:(NSString *)key;
//设置冷却时间
+ (void)setCoolingTimeWithKey:(NSString *)key time:(NSString *)time;


#pragma mark    - toast

//显示Toast提示
+ (void)showToast:(NSString *)text inSuperview:(UIView *)view;
+ (void)showToast:(NSString *)text;


#pragma mark    - 提示框

+ (void)showAlertWithText:(NSString *)text;
+ (void)showAlertWithTitle:(NSString *)title andText:(NSString *)text andDelegate:(id)delegate andTag:(NSInteger)tag;
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;


#pragma mark    - 经纬度坐标

//将角度转为弧度
+ (double)radians:(double)degrees;
//根据经纬度换算出直线距离
+ (double)getDistanceWithLat1:(double)lat1 lng1:(double)lng1 lat2:(double)lat2 lng2:(double)lng2;
//根据经纬度换算出直线距离 返回字符串
+ (NSString *)getDistanceStrWithLat1:(double)lat1 lng1:(double)lng1 lat2:(double)lat2 lng2:(double)lng2;
//根据距离返回字符串
+ (NSString *)getDistanceStrWithDistance:(NSInteger)distance;

@end
