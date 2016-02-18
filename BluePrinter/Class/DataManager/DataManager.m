//
//  DataManager.m
//  XM_12580
//
//  Created by mac on 12-7-9.
//  Copyright (c) 2012年 Neptune. All rights reserved.
//

#import "DataManager.h"

static DataManager *instance = nil;

@implementation DataManager

+ (DataManager *)sharedInstance
{
	if(instance == nil) {
		instance = [[DataManager alloc] init];
    }
	return instance;
}

+ (void)destroyInstance
{
    instance = nil;
}


#pragma mark    - 初始化

- (id)init
{
    self = [super init];
    if (self) {
        [self loadAccount];
    }
    return self;
}


#pragma mark    - 用户登录信息

- (void)setUserData:(NSDictionary *)userData account:(NSString *)account password:(NSString *)password
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"userData_%@", account];
    if (userData.count) {
        self.userInfo = [[UserInfo alloc] initWithData:userData];
        self.isLogin = YES;
        self.sessionId = [userData objectForKey:@"SessionID"];
        
        [ud setValue:[self.userInfo toDictionary] forKey:key];
    }
    else {
        self.userInfo = nil;
        self.isLogin = NO;
        self.isAotoLogin = NO;
        
        [ud setValue:nil forKey:key];
    }
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setValue:account forKey:@"account"];
    [data setValue:password forKey:@"password"];
    [ud setValue:data forKey:@"account"];
    [ud synchronize];
}

- (void)loadAccount
{
    self.userInfo = nil;
    NSString *account = [self getLoginAccount];
    NSString *password = [self getLoginAccount];
    if (account && password) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSDictionary *data = [ud objectForKey:[NSString stringWithFormat:@"userData_%@", account]];
        if (data.count) {
            self.userInfo = [[UserInfo alloc] initWithData:data];
            self.isLogin = YES;
        }
    }
}

- (NSString *)getLoginAccount
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *data = [ud objectForKey:@"account"];
    return [data objectForKey:@"account"];
}

- (NSString *)getLoginPassword
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *data = [ud objectForKey:@"account"];
    return [data objectForKey:@"password"];
}

- (void)saveLoginPassword:(NSString *)password
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *data = NSMUTABLEDICTIONARY([ud objectForKey:@"account"]);
    [data setValue:password forKey:@"password"];
    [ud setValue:data forKey:@"account"];
    [ud synchronize];
}

- (void)logout
{
    [self setUserData:nil account:[self getLoginAccount] password:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_LOGOUT object:nil];
}

//自动登录
- (void)autoLogin
{
    NSString *account = [self getLoginAccount];
    NSString *password = [self getLoginPassword];
    if (account && password)
    {
        self.isAotoLogin = YES;
        [self loginWithAccount:account password:password block:^(BOOL success, NSString *msgInfo)
        {
        }];
    }
}

//登录
- (void)loginWithAccount:(NSString *)account password:(NSString *)password block:(void(^)(BOOL success, NSString *msgInfo))block
{
    [NET_DATA_MANAGER requestLoginWithAccount:account password:password completion:^(NetResponse *response) {
        
        if (response.result) {
            //FIXME:START -临时文件适配后需要删除-
            NSMutableDictionary *dict = [NSMutableDictionary new];
            
            dict[@"nickname"] = account;
            dict[@"leaveMoney"] = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:1000 to:1000000]];
            dict[@"accountID"] = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:10000000 to:100000000]];
            dict[@"bankInfor"] = @"云南建行分行";
            dict[@"totalAsset"] = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:10000 to:1000000]];
            dict[@"balance"] = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:10000 to:1000000]];
            dict[@"income"] = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:10000 to:1000000]];
            response.data = dict;
            //FIXME:END
            [self setUserData:response.data account:account password:password];
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTIF_REQUEST_LOGIN_SUCCESS object:nil];
        }
        else
            [self setUserData:nil account:[self getLoginAccount] password:nil];
        if (response.msgCode == -1)
            response.msgInfo = NSLocalizedString(@"网络太差", nil);
        else
            response.msgInfo = NSLocalizedString(@"账号或密码错误", nil);
        if (block) {
            block(response.result, response.msgInfo);
        }
    }];
    
//    [NET_DATA_MANAGER requestLoginWithPhone:account password:password completion:^(NetResponse *response) {
//        
//        if (response.result) {
//            [self setUserData:response.data account:account password:password];
//            [[NSNotificationCenter defaultCenter]postNotificationName:NOTIF_REQUEST_LOGIN_SUCCESS object:nil];
//        }
//        else
//            [self setUserData:nil account:[self getLoginAccount] password:nil];
//        if (response.msgCode == -1)
//            response.msgInfo = NSLocalizedString(@"网络太差", nil);
//        else
//            response.msgInfo = NSLocalizedString(@"账号或密码错误", nil);
//        if (block) {
//            block(response.result, response.msgInfo);
//        }
//    }];
}


#pragma mark    - 商品类型

- (void)getProductTypeAry:(void(^)(NSArray *list))block
{
    if (_productTypeAry.count) {
        if (block)
            block(_productTypeAry);
        return;
    }
    
    [NET_DATA_MANAGER requestProductTypeWithCompletion:^(NetResponse *response) {
        if (response.result) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in response.data) {
                ProductTypeModel *model = [[ProductTypeModel alloc] initWithData:dic];
                [array addObject:model];
            }
            _productTypeAry = NSARRAY(array);
        }
        if (block)
            block(_productTypeAry);
    }];
}

- (NSString *)getProductTypeName:(id)type
{
    NSString *name = nil;
    for (ProductTypeModel *model in _productTypeAry) {
        if ([type integerValue] == [model.id integerValue]) {
            name = model.name;
            return name;
        }
    }
    return name;
}

@end
