//
//  ShareManager.m
//  BluePrinter
//
//  Created by ZengRuihui on 15/12/17.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "ShareManager.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"


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
        
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
                
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeChat:[WeiboSDK class]];
                break;
                
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx843534e8f104e376"
                                      appSecret:@"0aa99eb367c41d492733995aa03691a0"];
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
                 block:(void (^)(BOOL success, NSError *error))block
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
         
         switch (state)
         {
             case SSDKResponseStateSuccess:
             {
                 if (block)
                 {
                     block(YES, error);
                 }
                 break;
             }
             case SSDKResponseStateFail:
             {
                 if (block)
                 {
                     block(NO, error);
                 }
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 if (block)
                 {
                     block(NO, error);
                 }
                 break;
             }
             case SSDKResponseStateBegin:
             {
                 
             }
                 break;
             default:
                 if (block)
                 {
                     block(NO, error);
                 }
                 break;
         }
     }];
}

@end
