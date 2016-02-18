//
//  DataManager.h
//  XM_12580
//
//  Created by mac on 12-7-9.
//  Copyright (c) 2012年 Neptune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZBaseModel.h"

#define DATA_MANAGER [DataManager sharedInstance]
#define DEFAULTS [NSUserDefaults standardUserDefaults]

@class UserInfo;

@interface DataManager : NSObject
{
}

+ (DataManager *)sharedInstance;
+ (void)destroyInstance;


#pragma begin mark    - 用户登录信息

@property (nonatomic, assign) BOOL isLogin;//是否已登录
@property (nonatomic, assign) BOOL isAotoLogin;
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, strong) NSString *sessionId;

- (void)setUserData:(NSDictionary *)userData account:(NSString *)account password:(NSString *)password;
- (void)logout;
- (NSString *)getLoginAccount;
- (NSString *)getLoginPassword;
- (void)saveLoginPassword:(NSString *)password;

//自动登录
- (void)autoLogin;
//登录
- (void)loginWithAccount:(NSString *)account password:(NSString *)password block:(void(^)(BOOL success, NSString *msgInfo))block;


#pragma mark    - 商品类型

@property (strong, nonatomic) NSArray *productTypeAry;//列表数据为ProductTypeModel

- (void)getProductTypeAry:(void(^)(NSArray *list))block;
- (NSString *)getProductTypeName:(id)type;

@end
