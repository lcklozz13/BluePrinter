//
//  PublicEnum.h
//  Housekeeping
//
//  Created by ZengRuihui on 15/7/2.
//  Copyright (c) 2015年 窗外`. All rights reserved.
//

#ifndef Housekeeping_PublicEnum_h
#define Housekeeping_PublicEnum_h

//福州各区域
typedef enum : NSInteger {
    DistrictEnum_Gulou = 1,
    DistrictEnum_Taijiang,
    DistrictEnum_Canshan,
    DistrictEnum_Jinan,
    DistrictEnum_Mawei,
} DistrictEnum;

//分享渠道
typedef enum : NSUInteger {
    Share_Type_Sina = 0,
    Share_Type_WeixiTimeline = 1,
    Share_Type_WeixiSession = 2,
} Share_Type;

//性别
typedef enum : NSUInteger {
    SexType_Male = 1,
    SexType_Female = 2,
    SexType_None = 3,
} SexType;

//订单状态
typedef enum : NSUInteger {
    OrderState_Confirm = 1,//已确认
    OrderState_Cancel = 2,//已取消
    OrderState_Completed = 3,//订单完成
} OrderState;

//支付状态
typedef enum : NSUInteger {
    PayState_Not_Paid = 1,//未支付
    PayState_Paid = 2,//已支付
    PayState_Pending = 3,//其他状态
} PayState;

//发货状态
typedef enum : NSUInteger {
    DeliverState_Non_Delivery = 1,//未发货
    DeliverState_Delivered = 2,//已发货
} DeliverState;

//签收状态
typedef enum : NSUInteger {
    SignState_Not_Sign = 1,//未签收
    SignState_Signed = 2,//已签收
} SignState;

//退款状态
typedef enum : NSUInteger {
    RefundState_Normal = 1,//正常
    RefundState_Apply_Refund = 2,//申请退款
    RefundState_Accept_Refund = 3,//同意退款
    RefundState_Refund = 4,//已退款
} RefundState;

//自定义订单状态
typedef enum : NSUInteger {
    CustomOrderState_Init,
    CustomOrderState_Not_Paid,//未支付
    CustomOrderState_Paid_Pending,//已支付 待审查
    CustomOrderState_Non_Delivery,//已支付 待发货
    CustomOrderState_Delivered,//已发货 待签收
    CustomOrderState_Signed,//已签收
    CustomOrderState_Completed,//订单完成
    CustomOrderState_Cancel,//已取消
    CustomOrderState_Apply_Refund,//申请退款
    CustomOrderState_Accept_Refund,//同意退款 等待退款
    CustomOrderState_Refund,//已退款
} CustomOrderState;

typedef NS_ENUM(NSUInteger, FinancialProductType)
{
    FinancialProductType_Personal,      //个人投资
    FinancialProductType_Enterprise,    //企业投资
    FinancialProductType_Regular        //定期投资
};

#endif
