//
//  PublicMethods.h
//  BluePrinter
//
//  Created by baidu on 15/10/26.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PublicMethods : NSObject
+ (UIColor *)gs_colorWithHexString:(NSString *)hexString;
+ (UIWindow *)getKeyWindow;
+ (void)setNightModel:(BOOL)nightModel;
+ (BOOL)isNightModel;
+ (NSDictionary *)getTextAttributedWithForegroundColor:(NSString *)color fontSize:(CGFloat)size;
+ (int)getRandomNumber:(int)from to:(int)to;
@end
