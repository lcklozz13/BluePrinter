//
//  NetDataManager.m
//  XM_12580
//
//  Created by mac on 12-7-9.
//  Copyright (c) 2012年 Neptune. All rights reserved.
//

#import "NetDataManager.h"
#import "ASIFormDataRequest.h"
#import "NSData+Base64.h"
#import "JSON.h"

//#define SEAVER_URL @"112.74.87.87:8080/blueprint"
#define SEAVER_URL @"qznl.qz-software.com"

@implementation NetResponse

@end

static NetDataManager *instance = nil;

@interface NetDataManager ()
{
    MKNetworkEngine *_networkEngine;
}
@end

@implementation NetDataManager

+ (NetDataManager *)sharedInstance
{
	if(instance == nil)
		instance = [[NetDataManager alloc] init];
	return instance;
}

+ (void)destroyInstance
{
    instance = nil;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _networkEngine = [[MKNetworkEngine alloc] initWithHostName:SEAVER_URL customHeaderFields:nil];
    }
    return self;
}

- (void)dealloc
{
    [_networkEngine cancelAllOperations];
}

- (NSString *)getJsonStrFromData:(id)data
{
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    jsonWriter.humanReadable = YES;
    NSString *jsonStr = [jsonWriter stringWithObject:data];
    
    return jsonStr;
}

- (id)getDataFromJson:(NSString *)jsonStr
{
    return [jsonStr JSONValue];
}

- (NSString *)getPhotoUrl:(NSString *)path
{
    return [NSString stringWithFormat:@"http://%@%@", SEAVER_URL, path];
}

- (void)sendRequestWithPath:(NSString *)path
                     params:(NSMutableDictionary *)params
               onCompletion:(NetResponseBlock)responseBlock
          cancelLastRequest:(BOOL)cancelLastRequest
{
    if (cancelLastRequest) {
        //取消前一次请求
        [MKNetworkEngine cancelOperationsContainingURLString:path];
    }
    
    //分离要上传的文件路径
    NSMutableDictionary *tempParams = NSMUTABLEDICTIONARY(params);
//    NSString *filePath = [tempParams objectForKey:@"path"];
//    [tempParams setValue:nil forKey:@"path"];
    
    MKNetworkOperation *op = [_networkEngine operationWithPath:path params:tempParams httpMethod:@"POST" ssl:NO];
    
//    //添加sessionId
//    if (DATA_MANAGER.sessionId)
//        [op addHeader:@"Cookie" withValue:[NSString stringWithFormat:@"JSESSIONID=%@", DATA_MANAGER.sessionId]];
//    
//    //文件上传
//    if (([path isEqualToString:@"/app/uploadPhoto"] || [path isEqualToString:@"/app/user/edit/headPic"]) && filePath)
//        [op addFile:filePath forKey:@"file"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        NSLog(@"请求成功 %@\n%@", operation.url, operation.responseJSON);
        
        NetResponse *response = [[NetResponse alloc] init];
        response.requestData = operation.readonlyPostDictionary;
        response.responseData = operation.responseJSON;
        response.msgCode = [[operation.responseJSON objectForKey:@"msgCode"] integerValue];
        response.data = [operation.responseJSON objectForKey:@"data"];
        response.result = (response.msgCode == 1000 && [[operation.responseJSON objectForKey:@"result"] boolValue]);
        response.msgInfo = [operation.responseJSON objectForKey:@"msgInfo"];

        if (response.msgCode == 9997) {
            //未登录
            [DATA_MANAGER logout];
            return;
        }
        
        if (responseBlock)
            responseBlock(response);
        
    } errorHandler:^(MKNetworkOperation* operation, NSError* error){
        NSLog(@"请求失败 %@", operation.url);
        
        NetResponse *response = [[NetResponse alloc] init];
        response.requestData = operation.readonlyPostDictionary;
        response.msgCode = -1;
        response.result = NO;
        
        if (responseBlock)
            responseBlock(response);
        
    }];
    [_networkEngine enqueueOperation:op];
    
    NSLog(@"开始请求 %@\n%@", op.url, params);
}


#pragma mark    - 接口部分

#pragma mark 注册
- (void)requestRegisterWithPhone:(NSString *)phone
                        password:(NSString *)password
                      valifyCode:(NSString *)valifyCode
                           email:(NSString *)email
                      completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phone forKey:@"misdn"];
    [params setValue:password forKey:@"passWord"];
    [params setValue:valifyCode forKey:@"valifyCode"];
    [params setValue:email forKey:@"email"];
    [self sendRequestWithPath:@"/app/user/regedit" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 登录
- (void)requestLoginWithPhone:(NSString *)phone
                     password:(NSString *)password
                   completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([ShareFunction checkPhoneNumInput:phone])
        [params setValue:phone forKey:@"misdn"];
    else
        [params setValue:phone forKey:@"email"];
    [params setValue:password forKey:@"passWord"];
    [self sendRequestWithPath:@"/app/user/login" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 设计师商店
//sale和price二选一
//排序 0 默认, 1 升序 , 2降序
- (void)requestWorksListWithType:(id)type
                            sale:(id)sale
                           price:(id)price
                            page:(NSInteger)page
                        pageSize:(NSInteger)pageSize
                      completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:type forKey:@"type"];
    [params setValue:sale forKey:@"sale"];
    [params setValue:price forKey:@"price"];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(pageSize) forKey:@"pageSize"];
    [self sendRequestWithPath:@"/app/getWorksList" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 作品详情
- (void)requestWorksInfoWithWorksId:(id)works_id
                           completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:works_id forKey:@"works_id"];
    [self sendRequestWithPath:@"/app/getWorksInfo" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 我的作品列表
- (void)requestMyWorksListWithPage:(NSInteger)page
                          pageSize:(NSInteger)pageSize
                        completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(page) forKey:@"page"];
    [params setValue:@(pageSize) forKey:@"pageSize"];
    [self sendRequestWithPath:@"/app/getMyWorksList" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 修改资料
- (void)requestEditUserInfoWithBirth:(NSString *)birth
                                 sex:(SexType)sex
                                name:(NSString *)name
                          completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(sex) forKey:@"sex"];
    [params setValue:birth forKey:@"birth"];
    [params setValue:name forKey:@"name"];
    [self sendRequestWithPath:@"/app/user/edit/editOther" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 地址列表
- (void)requestAddressListWithCompletion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self sendRequestWithPath:@"/app/order/addressList" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 编辑或添加地址
- (void)requestEditAddressWithAddressId:(id)addressId
                              phoneName:(NSString *)phoneName
                                  phone:(NSString *)phone
                                address:(NSString *)address
                                 detail:(NSString *)detail
                              isDefault:(BOOL)isDefault
                             completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:addressId forKey:@"addressId"];
    [params setValue:phoneName forKey:@"phoneName"];
    [params setValue:phone forKey:@"phone"];
    [params setValue:address forKey:@"address"];
    [params setValue:detail forKey:@"detail"];
    [params setValue:@(isDefault) forKey:@"isDefault"];
    if (addressId)
        [self sendRequestWithPath:@"/app/order/updateAddress" params:params onCompletion:response cancelLastRequest:YES];
    else
        [self sendRequestWithPath:@"/app/order/addAddress" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 删除地址
- (void)requestDeleteAddressWithAddressId:(id)addressId
                               completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:addressId forKey:@"addressId"];
    [self sendRequestWithPath:@"/app/order/deleteAddress" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 图片上传
//modul 1为保存作品
- (void)requestUploadPhotoWithModul:(NSString *)modul
                               path:(NSString *)path
                         completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:modul forKey:@"modul"];
    [params setValue:path forKey:@"path"];
    [self sendRequestWithPath:@"/app/uploadPhoto" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 作品保存
//mainFile 为带商品图片的主图
//subFile 为不带商品的效果图
- (void)requestSaveWorksWithMainFile:(NSString *)mainFile
                             subFile:(NSString *)subFile
                           productId:(NSString *)productId
                           worksName:(NSString *)worksName
                              issale:(BOOL)issale
                          completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"0,1" forKey:@"types"];
    [params setValue:[NSString stringWithFormat:@"%@,%@", mainFile, subFile] forKey:@"urls"];
    [params setValue:productId forKey:@"productId"];
    [params setValue:worksName forKey:@"worksName"];
    [params setValue:@(issale) forKey:@"issale"];
    [self sendRequestWithPath:@"/app/saveWorks" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 获取商品类型
- (void)requestProductTypeWithCompletion:(NetResponseBlock)response
{
    [self sendRequestWithPath:@"/app/getProductType" params:nil onCompletion:response cancelLastRequest:YES];
}

#pragma mark 获取可编辑的商品类型
- (void)requestCanEditProductTypeWithCompletion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"edit"];
    [params setValue:@"1" forKey:@"version"];
    [self sendRequestWithPath:@"/app/getProductType" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 获取商品列表
- (void)requestProductListWithType:(NSString *)type
                        completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:type forKey:@"id"];
    [self sendRequestWithPath:@"/app/getProductTypeo" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 获取背景列表
- (void)requestBackgroundListWithCompletion:(NetResponseBlock)response
{
    [self sendRequestWithPath:@"/app/getWorksBackPicture" params:nil onCompletion:response cancelLastRequest:YES];
}

#pragma mark 创建订单
- (void)requestCreateOrderWithWorksList:(NSArray *)worksList
                         orderAddressId:(NSString *)orderAddressId
                                remarks:(NSString *)remarks
                             completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:orderAddressId forKey:@"orderAddressId"];
    [params setValue:remarks forKey:@"remarks"];

    NSMutableArray *ary = [NSMutableArray array];
    for (CartModel *model in worksList) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:NSSTRING_OBJECT(model.id) forKey:@"id"];
        [dic setValue:NSSTRING_NUM(model.count) forKey:@"number"];
        [ary addObject:dic];
    }

    NSString *json = [NET_DATA_MANAGER getJsonStrFromData:ary];
    json = [json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    json = [json stringByReplacingOccurrencesOfString:@" " withString:@""];
    [params setValue:json forKey:@"productJson"];

    [self sendRequestWithPath:@"/app/order/createOrder" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 订单列表
- (void)requestOrderListWithPage:(NSInteger)page
                        pageSize:(NSInteger)pageSize
                      completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [self sendRequestWithPath:@"/app/order/orderList" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 反馈
- (void)requestFeedbackWithName:(NSString *)name
                          email:(NSString *)email
                         jianyi:(NSString *)jianyi
                     completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:name forKey:@"name"];
    [params setValue:email forKey:@"email"];
    [params setValue:jianyi forKey:@"jianyi"];
    [self sendRequestWithPath:@"/app/fankui" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 订单详情
- (void)requestOrderDetailWithOrderId:(NSString *)orderId
                           completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:orderId forKey:@"orderId"];
    [self sendRequestWithPath:@"/app/order/orderDetail" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 取消订单
- (void)requestCancelOrderWithOrderId:(NSString *)orderId
                           completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:orderId forKey:@"orderId"];
    [self sendRequestWithPath:@"/app/order/cancelOrder" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 删除作品
- (void)requestDeleteWorksWithWorksId:(NSString *)worksId
                           completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:worksId forKey:@"worksId"];
    [self sendRequestWithPath:@"/app/deleteWorks" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 修改密码
- (void)requestUpdatePasswordWithPassword:(NSString *)password
                               completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:password forKey:@"password"];
    [self sendRequestWithPath:@"/app/user/updatepsd" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 订单支付信息
- (void)requestGetOrderPayInfoWithOrderNo:(NSString *)orderNo
                               completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:orderNo forKey:@"order_no"];
    [self sendRequestWithPath:@"/app/order/getOrderPayInfo" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 签收订单
- (void)requestSignForOrderWithOrderId:(NSString *)orderId
                            completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:orderId forKey:@"orderId"];
    [self sendRequestWithPath:@"/app/order/orderQianshou" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 修改头像
- (void)requestEditUserPhotoWithPath:(NSString *)path
                          completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:path forKey:@"path"];
    [self sendRequestWithPath:@"/app/user/edit/headPic" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark 忘记密码
- (void)requestForgetPasswordWithEmail:(NSString *)email
                            completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:email forKey:@"email"];
    [self sendRequestWithPath:@"/app/user/forgetPassword" params:params onCompletion:response cancelLastRequest:YES];
}

#pragma mark -
- (void)requestLoginWithAccount:(NSString *)account
                       password:(NSString *)pwd
                     completion:(NetResponseBlock)response
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

//    [params setValue:@"F0MwNjkm0tPOEj07CyLn8yfjX4hnORVZTkBddjFf" forKey:@"_token"];
    [params setValue:account forKey:@"uname"];
    [params setValue:pwd forKey:@"pwd"];
    [params setValue:@"" forKey:@"captcha"];
    
    [self sendRequestWithPath:@"/auth/mlogin" params:params onCompletion:response cancelLastRequest:YES];
}

@end
