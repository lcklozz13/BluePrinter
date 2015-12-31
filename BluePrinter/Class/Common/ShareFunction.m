//
//  ShareFunction.m
//  XM_12580
//
//  Created by mac on 12-7-9.
//  Copyright (c) 2012年 Neptune. All rights reserved.
//

#import "ShareFunction.h"
#import "Reachability.h"
#import "SSKeychain.h"
#import <Security/SecItem.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <MapKit/MapKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

#include <sys/socket.h> //MAC
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation ShareFunction

//取设备唯一值 钥匙串中的uuid
+ (NSString *)getDeviceUniqueIdByService:(NSString *)service key:(NSString *)key
{
    NSError *error = nil;
    NSString *uuid = [SSKeychain passwordForService:service account:key error:&error];
    if ([error code] == SSKeychainErrorNotFound || uuid.length == 0) {
        CFUUIDRef puuid = CFUUIDCreate(nil);
        CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
        uuid = CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        
        [SSKeychain setPassword:uuid forService:service account:key];
    }
    uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return uuid;
}

//处理数据 如是null或"<null>"则返回空串
+ (NSString *)getStringWithData:(id)data
{
    NSString *text = [NSString stringWithFormat:@"%@", data];
    if ([text isEqualToString:@"<null>"] || [text isEqualToString:@"(null)"])
        text = @"";
    
    return text;
}

+ (NSString*)uuid
{
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString * result = CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    result = [result lowercaseString];
    return result;
}

//取当前语言系统
+ (NSString*)getPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}

//hmac-Sha1加密
+ (NSData *)hmacSha1:(NSString *)key text:(NSString *)text
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
//    NSString *hash;
//    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
//    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", cHMAC[i]];
//    hash = output;
    return HMAC;
}

+ (NSString*)sha1WithText:(NSString*)text
{
    const char *cstr = [text cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:text.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


#pragma mark    - 验证

//手机号码验证
+ (BOOL)checkPhoneNumInput:(NSString *)_text
{
    NSString *Regex = @"(1[0-9])\\d{9}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:_text];
}

//美国手机号验证
+(BOOL)checkAmericaPhoneNumber:(NSString*)str
{
    NSString *Regex = @"[2-7][0-9][1-9]\\d{7}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:str];
}

//判断邮箱
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


#pragma mark    - 十六进制转换

//十六进制字符串转换为普通字符串
+ (NSData *)stringFromHexString:(NSString *)hexString
{
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSData *data = [NSData dataWithBytes:myBuffer length:[hexString length] / 2];
    return data;
    //    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    //    return unicodeString;
}

//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(id)string
{
    NSData *myD = nil;
    if ([string isKindOfClass:[NSString class]]) {
        myD = [string dataUsingEncoding:NSUTF8StringEncoding];;
    }
    else
        myD = string;
    
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0; i<[myD length]; i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@", hexStr, newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@", hexStr, newHexStr];
    }
    return hexStr;
}

//获取字符串的MD5值
+ (NSString*)md5ByString:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
    return nil;
}


#pragma mark    - 时间处理

+ (NSDate *)getDateWithTimeStr:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:timeStr];
    
    return date;
}

+ (NSDictionary *)getDateDicWithTime:(NSDate *)date
{
    date = date ? date : [NSDate date];
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents *comps  = [calendar components:unitFlags fromDate:date];
    
    NSString *year = [NSString stringWithFormat:@"%ld",(long)[comps year]];
    NSString *month = [NSString stringWithFormat:@"%ld",(long)[comps month]];
    NSString *day = [NSString stringWithFormat:@"%ld",(long)[comps day]];
    NSString *hour = [NSString stringWithFormat:@"%ld",(long)[comps hour]];
    NSString *min = [NSString stringWithFormat:@"%ld",(long)[comps minute]];
	NSString *week = [NSString stringWithFormat:@"%ld",(long)[comps weekOfMonth]];
	NSString *weekday = [NSString stringWithFormat:@"%ld",(long)[comps weekday]];
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:year,key_time_year,month,key_time_month,day,key_time_day,hour,key_time_hour,min,key_time_min,week,key_time_week,weekday,key_time_weekday,nil];
	return dic;
}

//获得当前时间戳
+ (NSString *)getCurrentTimeIntervalStr
{
    NSDate *now = [NSDate date];
    long interval = [now timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld", interval];
}

//获得当前时间
+ (NSString *)currentTime
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:now];
}

//冷却是否结束时间
+ (NSInteger)getLastCoolingTime:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [ud objectForKey:[NSString stringWithFormat:@"cd%@", key]];
    if (dic) {
        NSTimeInterval time = [[dic objectForKey:@"time"] doubleValue];
        NSTimeInterval recordTime = [[dic objectForKey:@"recordTime"] doubleValue];
        NSTimeInterval nowTime = [NSDate timeIntervalSinceReferenceDate];
        NSInteger i = time - (nowTime - recordTime);
        i = i < 0 ? 0 : i;
        return i;
    }
    else
        return 0;
}

//设置冷却时间
+ (void)setCoolingTimeWithKey:(NSString *)key time:(NSString *)time
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (time == nil) {
        [ud setValue:nil forKey:[NSString stringWithFormat:@"cd%@", key]];
    }
    else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:time forKey:@"time"];
        [dic setValue:[NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]] forKey:@"recordTime"];
        [ud setValue:dic forKey:[NSString stringWithFormat:@"cd%@", key]];
    }
    [ud synchronize];
}


#pragma mark    - toast

//显示Toast提示
+ (void)showToast:(NSString *)text inSuperview:(UIView *)superView
{
    CGSize size = [text getLabelSizeWithWidth:SCREEN_WIDTH-80 andFont:FONT_WITH_SIZE(17)];
    UILabel *toast = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    toast.font = FONT_WITH_SIZE(17);
    toast.textAlignment = NSTextAlignmentCenter;
    toast.text = text;
    toast.textColor = WHITE_COLOR;
    toast.backgroundColor = CLEAR_COLOR;
    toast.numberOfLines = 0;
    toast.layer.masksToBounds = YES;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width + 30, size.height + 20)];
    view.userInteractionEnabled = NO;
    view.alpha = 0;
    view.backgroundColor = UICOLOR_RGB(78, 79, 79, 1);
    view.layer.cornerRadius = 5;
    [view addSubview:toast];
    [superView addSubview:view];
    
    CGPoint center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    CGPoint convertPoint = [superView convertPoint:center fromView:m_appDelegate.window];
    view.center = convertPoint;
    toast.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2);
    
    [UIView animateWithDuration:0.2 animations:^{
        view.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.alpha = 0;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }];
}

+ (void)showToast:(NSString *)text
{
    [ShareFunction showToast:text inSuperview:m_appDelegate.window];
}


#pragma mark    - 提示框

+ (void)showAlertWithText:(NSString *)text
{
    if (m_alert != nil) {
        if ([m_alert.message isEqualToString:text]) {
            return;
        }
        [m_alert dismissWithClickedButtonIndex:10 animated:NO];
        m_alert = nil;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:text message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    alertView.tag = 1000;
    m_alert = alertView;
}

+ (void)showAlertWithTitle:(NSString *)title andText:(NSString *)text andDelegate:(id)delegate andTag:(NSInteger)tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:text delegate:delegate cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = tag;
    [alertView show];
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex == 0) {
            m_alert = 0;
        }
    }
}


#pragma mark    - 经纬度坐标

//将角度转为弧度
+ (double)radians:(double)degrees
{
    return (degrees*3.14159265)/180.0;
}

//根据经纬度换算出直线距离
+ (double)getDistanceWithLat1:(double)lat1 lng1:(double)lng1 lat2:(double)lat2 lng2:(double)lng2
{
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation *dist = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    CLLocationDistance kilometers = [orig distanceFromLocation:dist];
    return kilometers;
}

//根据经纬度换算出直线距离 返回字符串
+ (NSString *)getDistanceStrWithLat1:(double)lat1 lng1:(double)lng1 lat2:(double)lat2 lng2:(double)lng2
{
    double distance = [ShareFunction getDistanceWithLat1:lat1 lng1:lng1 lat2:lat2 lng2:lng2];
    NSString *distanceStr = [ShareFunction getDistanceStrWithDistance:distance];
    return distanceStr;
}

//根据距离返回字符串
+ (NSString *)getDistanceStrWithDistance:(NSInteger)distance
{
    NSInteger distance1 = ceil(distance / 100.0f) * 100;
    distance1 = distance1 < 1000 ? 1000 : distance1;
    float distance2 = distance1 / 1000.0f;
    NSString *distanceStr = [NSString stringWithFormat:@"<%0.1f%@", distance2, @"km"];
    return distanceStr;
}

@end
