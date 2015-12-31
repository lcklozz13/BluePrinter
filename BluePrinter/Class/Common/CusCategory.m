//
//  CusCategory.m
//  PreferentialLife
//
//  Created by 窗外` on 12-8-27.
//  Copyright (c) 2012年 Neptune. All rights reserved.
//

#import "CusCategory.h"
#import <CommonCrypto/CommonDigest.h>
#import <Accelerate/Accelerate.h>

@implementation UIImage (Scale)

- (UIImage *)transformToSize: (CGSize)newsize
{
    // 创建一个bitmap的context
    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *TransformedImg = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return TransformedImg;
}

+ (UIImage *)imageNamed:(NSString *)name withSize:(CGSize)newsize
{
    UIImage *image = [UIImage imageNamed:name];
    UIImage *newImage = [image transformToSize:newsize];
    
    return newImage;
}

- (UIImage *)createThumbImageWithSize:(CGSize)thumbSize percent:(float)percent toPath:(NSString *)thumbPath
{
    CGSize imageSize = self.size;
    if (imageSize.width < thumbSize.width && imageSize.height < thumbSize.height) {
        thumbSize = imageSize;
    }
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat scaleFactor = 0.0;
    CGPoint thumbPoint = CGPointMake(0.0, 0.0);
    CGFloat widthFactor = thumbSize.width / width;
    CGFloat heightFactor = thumbSize.height / height;
    if (widthFactor > heightFactor)
        scaleFactor = widthFactor;
    else
        scaleFactor = heightFactor;
    
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    if (widthFactor > heightFactor)
        thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;
    else if (widthFactor < heightFactor)
        thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;
    
    UIGraphicsBeginImageContext(thumbSize);
    CGRect thumbRect = CGRectZero;
    thumbRect.origin = thumbPoint;
    thumbRect.size.width  = scaledWidth;
    thumbRect.size.height = scaledHeight;
    [self drawInRect:thumbRect];
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    NSData *thumbImageData = UIImageJPEGRepresentation(thumbImage, percent);
    [thumbImageData writeToFile:thumbPath atomically:NO];

    return thumbImage;
}

+ (UIImage *)imageNamed:(NSString *)name left:(NSInteger)left top:(NSInteger)top
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image stretchableImageWithLeftCapWidth:left topCapHeight:top];

    return image;
}

//给图片增加朦胧效果
+ (UIImage *)blurryImage:(UIImage *)imageToBlur withRadius:(CGFloat)blurRadius
{
    if ((blurRadius <= 0.0f) || (blurRadius > 1.0f)) {
        blurRadius = 0.5f;
    }
    
    int boxSize = (int)(blurRadius * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef rawImage = imageToBlur.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(rawImage);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(rawImage);
    inBuffer.height = CGImageGetHeight(rawImage);
    inBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(rawImage) * CGImageGetHeight(rawImage));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(rawImage);
    outBuffer.height = CGImageGetHeight(rawImage);
    outBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(imageToBlur.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end


@implementation NSMutableDictionary (myCompare)

- (NSComparisonResult)myCompareMethodWithDic:(NSMutableDictionary *)otherDic
{
    NSInteger first = [[self objectForKey:@"num"] intValue];
    NSInteger second = [[otherDic objectForKey:@"num"] intValue];

    return first < second;
}

@end


@implementation NSString (myString)

- (CGSize)getLabelSizeWithWidth:(float)width andFont:(UIFont *)font
{
    NSArray *arry = [self componentsSeparatedByString:@"\n"];

    float height = 0;
    float sx = 0;
    for (NSString *str in arry) {
        NSString *t = str;
        if ([t isEqualToString:@""]) {
            t = @" ";
        }
        NSDictionary *attrDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        CGSize detailSize = [t boundingRectWithSize:CGSizeMake(width, 10000.0f) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrDic context:nil].size;
        height += detailSize.height;
        sx = MAX(detailSize.width, sx);
    }

    return CGSizeMake(sx, ceilf(height));
}

- (NSString *)md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

@end


@implementation UILabel (myLabel)

//取文字内容的大小
- (CGSize)getLabelSizeInWidth:(float)width
{
    CGSize size = [self.text getLabelSizeWithWidth:width andFont:self.font];
    return size;
}

//根据内容设置高度
- (void)setSizeToContentHeight
{
    CGSize size = [self getLabelSizeInWidth:self.frame.size.width];
    CGRect frame = self.frame;
    frame.size.height = size.height;
    self.frame = frame;
}

//根据内容设置大小
- (void)setSizeToContentSize
{
    CGSize size = [self getLabelSizeInWidth:SCREEN_WIDTH];
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}

@end


@implementation UIView (myView)

//旋转动画
- (void)startRotationAnimationWithDuration:(float)duration
{
    [self endRotationAnimation];
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 10000000;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

//停止旋转动画
- (void)endRotationAnimation
{
    [self.layer removeAnimationForKey:@"rotationAnimation"];
}

//清除所有子视图
- (void)removeAllSubviews
{
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
}

//修改view的frame
- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)originx
{
    return self.frame.origin.x;
}
- (void)setOriginx:(CGFloat)originx
{
    CGRect frame = self.frame;
    frame.origin.x = originx;
    self.frame = frame;
}

- (CGFloat)originy
{
    return self.frame.origin.y;
}
- (void)setOriginy:(CGFloat)originy
{
    CGRect frame = self.frame;
    frame.origin.y = originy;
    self.frame = frame;
}

@end


@implementation UISearchBar (mySearchBar)

- (void)removeBackground
{
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass: NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
        for (UIView *view in subview.subviews) {
            if ([view isKindOfClass: NSClassFromString(@"UISearchBarBackground")]) {
                [view removeFromSuperview];
                break;
            }
        }
    }
}

@end


@implementation UIButton (myButton)

//设置背景图为可拉伸图像
- (void)setBackgroundImageStretchable
{
    UIImage *bg = [[self backgroundImageForState:UIControlStateNormal] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [self setBackgroundImage:bg forState:UIControlStateNormal];
}

@end