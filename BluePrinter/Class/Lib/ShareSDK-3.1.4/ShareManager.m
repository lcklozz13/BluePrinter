//
//  ShareManager.m
//  BluePrinter
//
//  Created by ZengRuihui on 15/12/17.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "ShareManager.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

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
    [ShareSDK registerApp:@"iosv1101" activePlatforms:@[@(SSDKPlatformTypeFacebook), @(SSDKPlatformTypeTwitter)] onImport:^(SSDKPlatformType platformType) {
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeFacebook:
                //设置Facebook应用信息，其中authType设置为只用SSO形式授权
                [appInfo SSDKSetupFacebookByApiKey:@"107704292745179" appSecret:@"38053202e1a5fe26c80c753071f0b573" authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeTwitter:
                [appInfo SSDKSetupTwitterByConsumerKey:@"LRBM0H75rWrU9gNHvlEAA2aOy" consumerSecret:@"gbeWsZvA9ELJSdoBzJ5oLKX0TU09UOwrzdGfo9Tg7DjyGuMe8G" redirectUri:@"http://mob.com"];
                break;
            default:
                break;
        };
    }];
}

- (void)shareWithTitle:(NSString *)title
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
    
    [ShareSDK showShareEditor:SSDKPlatformTypeSinaWeibo
           otherPlatformTypes:@[@(SSDKPlatformTypeFacebook), @(SSDKPlatformTypeTwitter)]
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
