//
//  ShareManager.m
//  BluePrinter
//
//  Created by ZengRuihui on 15/12/17.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "ShareManager.h"

static ShareManager *instance = nil;

@implementation ShareManager

+ (ShareManager *)sharedInstance
{
    if(instance == nil) {
        instance = [[ShareManager alloc] init];
    }
    return instance;
}

+ (void)destroyInstance
{
    instance = nil;
}

- (void)initialization
{
    [ShareSDK registerApp:@"eada945e0218" activePlatforms:@[@(SSDKPlatformSubTypeWechatSession), @(SSDKPlatformSubTypeWechatTimeline), @(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx42f62ab42e5c1c6e"
                                      appSecret:@"7448cd9de6b3c6cd5f3dddbf4cce8c95"];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:@"4046900797"
                                          appSecret:@"c5c01398d97f74c85e688bd80e5f01b7"
                                        redirectUri:@"http://mob.com"
                                           authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        };
    }];
}

- (void)shareWithEditor:(SSDKPlatformType)platformType
     otherPlatformTypes:(NSArray *)otherPlatformTypes
                  title:(NSString *)title
               content:(NSString *)content
                images:(id)images
                   url:(NSString *)url
                 block:(void (^)(BOOL success))block
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                     images:images
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeImage];
    
    [ShareSDK showShareEditor:platformType
           otherPlatformTypes:otherPlatformTypes
                  shareParams:shareParams
          onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end)
     {
         
         switch (state) {
             case SSDKResponseStateSuccess: {
                 if (block) {
                     block(YES);
                 }
                 break;
             }
             case SSDKResponseStateFail: {
                 if (block) {
                     block(NO);
                 }
                 break;
             }
             case SSDKResponseStateCancel: {
                 if (block) {
                     block(NO);
                 }
                 break;
             }
             default:
                 if (block) {
                     block(NO);
                 }
                 break;
         }
     }];
}

@end
