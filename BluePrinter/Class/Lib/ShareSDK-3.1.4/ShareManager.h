//
//  ShareManager.h
//  BluePrinter
//
//  Created by ZengRuihui on 15/12/17.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#define SHARE_MANAGER [ShareManager sharedInstance]

@interface ShareManager : NSObject

+ (ShareManager *)sharedInstance;
+ (void)destroyInstance;

- (void)initialization;

/**
 *@[@(SSDKPlatformSubTypeWechatSession), @(SSDKPlatformSubTypeWechatTimeline), @(SSDKPlatformTypeSinaWeibo)]
 */
- (void)shareWithEditor:(SSDKPlatformType)platformType
     otherPlatformTypes:(NSArray *)otherPlatformTypes
                  title:(NSString *)title
                content:(NSString *)content
                 images:(id)images
                    url:(NSString *)url
                  block:(void (^)(BOOL success))block;

@end
