//
//  NetDataManager.h
//  XM_12580
//
//  Created by mac on 12-7-9.
//  Copyright (c) 2012年 Neptune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"

#define NET_DATA_MANAGER [NetDataManager sharedInstance]

//网络请求响应实例
@interface NetResponse : NSObject

@property (strong, nonatomic) NSDictionary *responseData;//响应数据
@property (strong, nonatomic) NSDictionary *requestData;//请求的数据
@property (assign, nonatomic) NSInteger msgCode;//错误码
@property (copy, nonatomic) NSString *msgInfo;//错误提示
@property (strong, nonatomic) id data;//responseData中的data数据
@property (assign, nonatomic) BOOL result;//是否成功

@end

typedef void (^NetResponseBlock) (NetResponse* response);

@interface NetDataManager : NSObject
{
}

//---------------------------公共
+ (NetDataManager *)sharedInstance;
+ (void)destroyInstance;

- (NSString *)getJsonStrFromData:(id)data;
- (id)getDataFromJson:(NSString *)jsonStr;

- (NSString *)getPhotoUrl:(NSString *)path;

- (void)sendRequestWithPath:(NSString *)path
                     params:(NSMutableDictionary *)params
               onCompletion:(NetResponseBlock)responseBlock
          cancelLastRequest:(BOOL)cancelLastRequest;


#pragma mark    - 接口部分

#pragma mark 注册
- (void)requestRegisterWithPhone:(NSString *)phone
                        password:(NSString *)password
                      valifyCode:(NSString *)valifyCode
                           email:(NSString *)email
                      completion:(NetResponseBlock)response;

#pragma mark 登录
- (void)requestLoginWithPhone:(NSString *)phone
                     password:(NSString *)password
                   completion:(NetResponseBlock)response;

#pragma mark 设计师商店
//sale和price二选一
//排序 0 默认, 1 升序 , 2降序
- (void)requestWorksListWithType:(id)type
                            sale:(id)sale
                           price:(id)price
                            page:(NSInteger)page
                        pageSize:(NSInteger)pageSize
                      completion:(NetResponseBlock)response;

#pragma mark 作品详情
- (void)requestWorksInfoWithWorksId:(id)works_id
                         completion:(NetResponseBlock)response;

#pragma mark 我的作品列表
- (void)requestMyWorksListWithPage:(NSInteger)page
                          pageSize:(NSInteger)pageSize
                        completion:(NetResponseBlock)response;

#pragma mark 修改资料
- (void)requestEditUserInfoWithBirth:(NSString *)birth
                                 sex:(SexType)sex
                                name:(NSString *)name
                          completion:(NetResponseBlock)response;

#pragma mark 地址列表
- (void)requestAddressListWithCompletion:(NetResponseBlock)response;

#pragma mark 编辑或添加地址
- (void)requestEditAddressWithAddressId:(id)addressId
                              phoneName:(NSString *)phoneName
                                  phone:(NSString *)phone
                                address:(NSString *)address
                                 detail:(NSString *)detail
                              isDefault:(BOOL)isDefault
                             completion:(NetResponseBlock)response;

#pragma mark 删除地址
- (void)requestDeleteAddressWithAddressId:(id)addressId
                               completion:(NetResponseBlock)response;

#pragma mark 图片上传
//modul 1为保存作品
- (void)requestUploadPhotoWithModul:(NSString *)modul
                               path:(NSString *)path
                         completion:(NetResponseBlock)response;

#pragma mark 作品保存
//mainFile 为带商品图片的主图
//subFile 为不带商品的效果图
- (void)requestSaveWorksWithMainFile:(NSString *)mainFile
                             subFile:(NSString *)subFile
                           productId:(NSString *)productId
                           worksName:(NSString *)worksName
                              issale:(BOOL)issale
                          completion:(NetResponseBlock)response;

#pragma mark 获取商品类型
- (void)requestProductTypeWithCompletion:(NetResponseBlock)response;

#pragma mark 获取可编辑的商品类型
- (void)requestCanEditProductTypeWithCompletion:(NetResponseBlock)response;

#pragma mark 获取商品列表
- (void)requestProductListWithType:(NSString *)type
                        completion:(NetResponseBlock)response;

- (void)requestBackgroundListWithCompletion:(NetResponseBlock)response;

#pragma mark 创建订单
- (void)requestCreateOrderWithWorksList:(NSArray *)worksList
                         orderAddressId:(NSString *)orderAddressId
                                remarks:(NSString *)remarks
                             completion:(NetResponseBlock)response;

#pragma mark 订单列表
- (void)requestOrderListWithPage:(NSInteger)page
                        pageSize:(NSInteger)pageSize
                      completion:(NetResponseBlock)response;

#pragma mark 反馈
- (void)requestFeedbackWithName:(NSString *)name
                          email:(NSString *)email
                         jianyi:(NSString *)jianyi
                     completion:(NetResponseBlock)response;

#pragma mark 订单详情
- (void)requestOrderDetailWithOrderId:(NSString *)orderId
                           completion:(NetResponseBlock)response;

#pragma mark 取消订单
- (void)requestCancelOrderWithOrderId:(NSString *)orderId
                           completion:(NetResponseBlock)response;

#pragma mark 删除作品
- (void)requestDeleteWorksWithWorksId:(NSString *)worksId
                           completion:(NetResponseBlock)response;

#pragma mark 修改密码
- (void)requestUpdatePasswordWithPassword:(NSString *)password
                               completion:(NetResponseBlock)response;

#pragma mark 订单支付信息
- (void)requestGetOrderPayInfoWithOrderNo:(NSString *)orderNo
                               completion:(NetResponseBlock)response;

#pragma mark 签收订单
- (void)requestSignForOrderWithOrderId:(NSString *)orderId
                            completion:(NetResponseBlock)response;

#pragma mark 修改头像
- (void)requestEditUserPhotoWithPath:(NSString *)path
                          completion:(NetResponseBlock)response;

#pragma mark 忘记密码
- (void)requestForgetPasswordWithEmail:(NSString *)email
                            completion:(NetResponseBlock)response;


#pragma mark -
#pragma mark login

- (void)requestLoginWithAccount:(NSString *)account
                       password:(NSString *)pwd
                     completion:(NetResponseBlock)response;

@end
