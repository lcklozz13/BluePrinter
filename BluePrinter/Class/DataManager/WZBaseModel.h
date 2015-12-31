//
//  WZBaseModel.h
//  CampusExchange
//
//  Created by 窗外` on 15/6/28.
//
//

#import <Foundation/Foundation.h>

@interface WZBaseModel : NSObject

- (id)initWithData:(NSDictionary *)data;

//将Model转换为字典
- (NSDictionary *)toDictionary;

@end


#pragma mark 用户信息
@interface UserInfo : WZBaseModel

@property (strong, nonatomic) NSString *headPic;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *birthDay;
@property (strong, nonatomic) NSString *birthStr;
@property (assign, nonatomic) SexType sex;
@property (strong, nonatomic) id uid;
@property (assign, nonatomic) NSInteger worksCount;
@property (strong, nonatomic) NSString *leaveMoney;

@end


#pragma mark 商品类型
@interface ProductTypeModel : WZBaseModel

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *pid;
@property (strong, nonatomic) NSString *rank;

@end


#pragma mark 作品列表
@interface WorksListModel : WZBaseModel

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *price;
@property (assign, nonatomic) int sale;
@property (strong, nonatomic) NSString *src;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *work_id;
@property (strong, nonatomic) NSString *type_name;
@property (strong, nonatomic) NSString *product_name;

@end


#pragma mark 作品详情
@interface WorksInfoModel : WZBaseModel

@property (strong, nonatomic) NSString *cansell;
@property (strong, nonatomic) NSString *create_time;
@property (strong, nonatomic) NSString *des;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *pics;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *product_id;
@property (assign, nonatomic) int sale;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *uname;
@property (strong, nonatomic) NSString *type_name;
@property (strong, nonatomic) NSString *product_name;

@end


#pragma mark 地址
@interface AddressModel : WZBaseModel

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *id;
@property (assign, nonatomic) bool is_default;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *phone_name;
@property (strong, nonatomic) NSString *user_id;

@end


#pragma mark 购物车数据
@interface CartModel : WZBaseModel

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *photo;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) NSString *mainType;
@property (strong, nonatomic) NSString *subType;
@property (assign, nonatomic) int count;
@property (assign, nonatomic) int stock;
@property (assign, nonatomic) bool bSelected;//购物车中是否被选中

@end


#pragma mark 订单列表
@interface OrderModel : WZBaseModel

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *orderno;
@property (strong, nonatomic) NSString *order_time;
@property (assign, nonatomic) NSTimeInterval order_time_utc;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *remark;
@property (strong, nonatomic) NSString *trade;

@property (strong, nonatomic) NSString *pay_time;
@property (assign, nonatomic) NSTimeInterval pay_time_utc;
@property (assign, nonatomic) NSTimeInterval pay_type;

@property (strong, nonatomic) NSString *wuliu_code;
@property (strong, nonatomic) NSString *wuliu_id;
@property (strong, nonatomic) NSString *wuliu_remark;
@property (strong, nonatomic) NSString *wuliu_name;

@property (assign, nonatomic) OrderState state;
@property (assign, nonatomic) PayState pay_state;
@property (assign, nonatomic) RefundState tuikuan_state;
@property (assign, nonatomic) DeliverState fahuo_state;
@property (assign, nonatomic) SignState qianshou_state;
@property (assign, nonatomic) CustomOrderState orderState;

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *address_detail;
@property (strong, nonatomic) NSString *address_id;
@property (strong, nonatomic) NSString *address_phone;
@property (strong, nonatomic) NSString *address_phone_name;

@property (strong, nonatomic) NSArray *worksList;

@end


#pragma mark 订单中的作品
@interface OrderWorksModel : WZBaseModel

@property (strong, nonatomic) NSString *product_name;
@property (strong, nonatomic) NSString *product_pic;
@property (strong, nonatomic) NSString *product_price;
@property (strong, nonatomic) NSString *wokrs_id;
@property (strong, nonatomic) NSString *works_name;
@property (strong, nonatomic) NSString *works_pic;
@property (assign, nonatomic) int num;

@end


#pragma mark 支付数据
@interface PaymentModel : WZBaseModel

@property (strong, nonatomic) NSString *retrun_url;
@property (strong, nonatomic) NSString *cancel_url;
@property (strong, nonatomic) id total_fee;
@property (strong, nonatomic) NSString *order_id;
@property (strong, nonatomic) NSString *order_no;
@property (strong, nonatomic) NSString *orderProductName;

@end


@interface FinancialProduct : WZBaseModel
@property (nonatomic, assign) FinancialProductType      product_type;
@property (nonatomic, strong) NSString                  *product_title;
@property (nonatomic, strong) NSString                  *product_annual_rate;
@property (nonatomic, strong) NSString                  *product_limit_time;
@property (nonatomic, strong) NSString                  *product_purchase_amount;
@property (nonatomic, strong) NSString                  *product_progress_rate;
@property (nonatomic, strong) NSString                  *product_purchased_quantity;
@property (nonatomic, strong) NSString                  *product_remaining_amount;
@property (nonatomic, strong) NSString                  *product_gross;
@property (nonatomic, strong) NSString                  *product_deadline;
@property (nonatomic, strong) NSString                  *product_repayment;
@property (nonatomic, assign) BOOL                      product_is_sold_out;
@property (nonatomic, strong) NSString                  *paymentMoney;


@end
