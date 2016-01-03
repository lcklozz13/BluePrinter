//
//  WZBaseModel.m
//  CampusExchange
//
//  Created by 窗外` on 15/6/28.
//
//

#import "WZBaseModel.h"
#import <objc/runtime.h>

#pragma mark model基类
@implementation WZBaseModel

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]])
            [self reflectDataFromOtherObject:data];
    }
    return self;
}

- (BOOL)reflectDataFromOtherObject:(NSDictionary *)dic
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *propertyType = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];

        if ([[dic allKeys] containsObject:propertyName]) {
            id value = [dic valueForKey:propertyName];
            if (![value isKindOfClass:[NSNull class]] && value != nil) {
                if ([value isKindOfClass:[NSDictionary class]]) {
                    id pro = [self createInstanceByClassName:[self getClassName:propertyType]];
                    [pro reflectDataFromOtherObject:value];
                    [self setValue:pro forKey:propertyName];
                }
                else {
                    [self setValue:value forKey:propertyName];
                }
            }
        }
    }

    free(properties);
    return true;
}

- (NSArray *)propertyKeys
{
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    NSMutableArray *keys = [NSMutableArray array];
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }

    free(properties);
    return keys;
}

- (NSString *)getClassName:(NSString *)attributes
{
    NSString *type = [attributes substringFromIndex:[attributes rangeOfString:@"\""].location + 1];
    type = [type substringToIndex:[type rangeOfString:@"\""].location];
    return type;
}

- (id)createInstanceByClassName:(NSString *)className {
    NSBundle *bundle = [NSBundle mainBundle];
    Class aClass = [bundle classNamed:className];
    id anInstance = [[aClass alloc] init];
    return anInstance;
}

//将Model转换为字典
- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];

    for (NSString *key in [self propertyKeys]) {
        id propertyValue = [self valueForKey:key];
//        propertyValue = propertyValue ? propertyValue : @"<null>";

        if ([propertyValue isKindOfClass:[WZBaseModel class]]) {
            WZBaseModel *model = (WZBaseModel *)propertyValue;
            propertyValue = [model toDictionary];
        }
        else if ([propertyValue isKindOfClass:[NSArray class]]) {
            NSMutableArray *ary = [NSMutableArray array];
            for (id item in propertyValue) {
                if ([item isKindOfClass:[WZBaseModel class]]) {
                    WZBaseModel *model = (WZBaseModel *)item;
                    [ary addObject:[model toDictionary]];
                }
            }
            propertyValue = ary;
        }

        [dic setValue:propertyValue forKey:key];
    }

    return dic;
}

- (NSString *)description
{
    NSString *className = [[NSString alloc] initWithUTF8String:object_getClassName([self class])];
    NSString *description = [NSString stringWithFormat:@"%@  %@", className, [self toDictionary]];
    return description;
}

@end


#pragma mark 用户信息
@implementation UserInfo

- (void)setBirthDay:(NSString *)birthDay
{
    _birthDay = NSSTRING_OBJECT(birthDay);
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[birthDay longLongValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    self.birthStr = [formatter stringFromDate:date];
}

@end


#pragma mark 商品类型
@implementation ProductTypeModel
@end


#pragma mark 作品列表
@implementation WorksListModel
@end


#pragma mark 作品详情
@implementation WorksInfoModel

- (id)initWithData:(NSDictionary *)data
{
    self = [super initWithData:data];
    if (self) {
        NSMutableArray *ary = [NSMutableArray array];
        for (NSDictionary *dic in self.pics) {
            [ary addObject:[dic objectForKey:@"src"]];
        }
        self.pics = NSARRAY(ary);
    }
    return self;
}

@end


#pragma mark 地址
@implementation AddressModel
@end


#pragma mark 购物车数据
@implementation CartModel
@end


#pragma mark 订单列表
@implementation OrderModel

- (id)initWithData:(NSDictionary *)data
{
    self = [super initWithData:data];
    if (self) {
        NSMutableArray *ary = [NSMutableArray array];
        for (NSDictionary *dic in [data objectForKey:@"worksList"]) {
            OrderWorksModel *model = [[OrderWorksModel alloc] initWithData:dic];
            [ary addObject:model];
        }
        self.worksList = NSARRAY(ary);
        
        [self getOrderState];
    }
    return self;
}

//获取自定义订单类型
- (void)getOrderState
{
    switch (self.state) {
        case OrderState_Confirm: {
            if (self.pay_state == PayState_Not_Paid) {
                //未支付
                self.orderState = CustomOrderState_Not_Paid;
            }
            else if (self.pay_state == PayState_Pending) {
                //已支付 待审核
                self.orderState = CustomOrderState_Paid_Pending;
            }
            else {
                switch (self.tuikuan_state) {
                    case RefundState_Apply_Refund: {
                        //退款申请
                        self.orderState = CustomOrderState_Apply_Refund;
                        break;
                    }
                    case RefundState_Accept_Refund: {
                        //退款中
                        self.orderState = CustomOrderState_Accept_Refund;
                        break;
                    }
                    case RefundState_Refund: {
                        //已退款
                        self.orderState = CustomOrderState_Refund;
                        break;
                    }
                        
                    default: {
                        if (self.fahuo_state == DeliverState_Delivered) {
                            //已发货
                            if (self.qianshou_state == SignState_Not_Sign) {
                                //未签收
                                self.orderState = CustomOrderState_Delivered;
                            }
                            else {
                                //已签收
                                self.orderState = CustomOrderState_Signed;
                            }
                        }
                        else {
                            //未发货
                            self.orderState = CustomOrderState_Non_Delivery;
                        }
                        break;
                    }
                }
            }
            break;
        }
            
        case OrderState_Cancel: {
            //订单取消
            self.orderState = CustomOrderState_Cancel;
            break;
        }
            
        case OrderState_Completed: {
            //订单完成
            self.orderState = CustomOrderState_Completed;
            break;
        }
            
        default:
            self.orderState = CustomOrderState_Init;
            break;
    }
}

@end

#pragma mark 订单中的作品
@implementation OrderWorksModel
@end

#pragma mark 支付数据
@implementation PaymentModel
@end

@implementation FinancialProduct
+ (FinancialProduct *)createFinancialProductFromFinancialProductType:(FinancialProductType)type
{
    FinancialProduct *product = [[FinancialProduct alloc] init];
    
    product.product_type = type;
    product.product_annual_rate = [[NSString alloc] initWithFormat:@"%d.00", [PublicMethods getRandomNumber:8 to:100]];
    product.product_limit_time = [[NSString alloc] initWithFormat:@"%d月", [PublicMethods getRandomNumber:1 to:12]];
    product.product_purchase_amount = [[NSString alloc] initWithFormat:@"%d元", [PublicMethods getRandomNumber:100 to:10000]];
    product.product_progress_rate = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:0 to:100]];
    product.product_purchased_quantity = [[NSString alloc] initWithFormat:@"%d笔", [PublicMethods getRandomNumber:10 to:100]];
    product.product_remaining_amount = [[NSString alloc] initWithFormat:@"%d.00元", [PublicMethods getRandomNumber:100000 to:1000000000]];
    product.product_gross = [[NSString alloc] initWithFormat:@"%d.00", [PublicMethods getRandomNumber:100000 to:1000000000]];
    product.product_deadline = @"2016年12月31日";
    product.product_repayment = @"一次性还清本息";
    product.product_is_sold_out = [PublicMethods getRandomNumber:0 to:1];
    
    switch (type)
    {
        case FinancialProductType_Personal:
        {
            product.product_title = [[NSString alloc] initWithFormat:@"个人贷%d", [PublicMethods getRandomNumber:123456 to:999999]];
        }
            break;
            
        case FinancialProductType_Enterprise:
        {
            product.product_title = [[NSString alloc] initWithFormat:@"中小企业贷%d号", [PublicMethods getRandomNumber:123456 to:999999]];
        }
            break;
            
        case FinancialProductType_Regular:
        {
            product.product_title = [[NSString alloc] initWithFormat:@"定期 招财宝%d", [PublicMethods getRandomNumber:1000 to:9999]];
        }
            break;
            
        default:
            break;
    }
    
    return product;
}

@end
