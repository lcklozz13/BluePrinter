//
//  CusCategory.h
//  PreferentialLife
//
//  Created by 窗外` on 12-8-27.
//  Copyright (c) 2012年 Neptune. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Scale)

- (UIImage *)transformToSize: (CGSize)newsize;

+ (UIImage *)imageNamed:(NSString *)name withSize:(CGSize)newsize;

- (UIImage *)createThumbImageWithSize:(CGSize)thumbSize percent:(float)percent toPath:(NSString *)thumbPath;

+ (UIImage *)imageNamed:(NSString *)name left:(NSInteger)left top:(NSInteger)top;

//给图片增加朦胧效果
+ (UIImage *)blurryImage:(UIImage *)imageToBlur withRadius:(CGFloat)blurRadius;

@end

@interface NSMutableDictionary (myCompare)

- (NSComparisonResult)myCompareMethodWithDic:(NSMutableDictionary *)otherDic;

@end

@interface NSString (myString)

- (CGSize)getLabelSizeWithWidth:(float)width andFont:(UIFont *)font;
- (NSString *)md5HexDigest;

@end

@interface UILabel (myLabel)

//取文字内容的大小
- (CGSize)getLabelSizeInWidth:(float)width;
//根据内容设置高度
- (void)setSizeToContentHeight;
//根据内容设置大小
- (void)setSizeToContentSize;

@end

@interface UIView (myView)

//修改view的frame
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat originx;
@property (assign, nonatomic) CGFloat originy;

//旋转动画
- (void)startRotationAnimationWithDuration:(float)duration;
//停止旋转动画
- (void)endRotationAnimation;

//清除所有子视图
- (void)removeAllSubviews;

@end

@interface UISearchBar (mySearchBar)

- (void)removeBackground;

@end

@interface UIButton (myButton)

//设置背景图为可拉伸图像
- (void)setBackgroundImageStretchable;

@end
