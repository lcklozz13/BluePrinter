//
//  PublicMethods.m
//  BluePrinter
//
//  Created by baidu on 15/10/26.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//


#import "PublicMethods.h"
#define ISNIGHTMODEL    @"IsNightModel"

@implementation PublicMethods

+ (UIColor *)gs_colorWithHexString:(NSString *)hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#"withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self gs_colorComponentFrom: colorString start: 0 length: 1];
            green = [self gs_colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self gs_colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = 16 - [self gs_colorComponentFrom: colorString start: 0 length: 1];
            red   = [self gs_colorComponentFrom: colorString start: 1 length: 1];
            green = [self gs_colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self gs_colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self gs_colorComponentFrom: colorString start: 0 length: 2];
            green = [self gs_colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self gs_colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self gs_colorComponentFrom: colorString start: 0 length: 2];
            red   = [self gs_colorComponentFrom: colorString start: 2 length: 2];
            green = [self gs_colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self gs_colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return [UIColor clearColor];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
    
}

+ (CGFloat)gs_colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (BOOL)isNightModel
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    if (![userDef valueForKey:ISNIGHTMODEL])
    {
        return NO;
    }
    
    return [userDef boolForKey:ISNIGHTMODEL];
}

+ (UIWindow *)getKeyWindow
{
    return [[UIApplication sharedApplication] keyWindow];
}

+ (void)setNightModel:(BOOL)nightModel
{
    [[NSUserDefaults standardUserDefaults] setBool:nightModel forKey:ISNIGHTMODEL];
    
    if (nightModel)
    {
        [[UIScreen mainScreen] setBrightness:0.25];
    }
    else
    {
        [[UIScreen mainScreen] setBrightness:1];
    }
}

+ (NSDictionary *)getTextAttributedWithForegroundColor:(NSString *)color fontSize:(CGFloat)size
{
    return @{NSForegroundColorAttributeName:[PublicMethods gs_colorWithHexString:color], NSFontAttributeName:[UIFont systemFontOfSize:size]};
}

+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

@end

