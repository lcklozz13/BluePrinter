//
//  PaymentCell1.m
//  LittleFawn
//
//  Created by baidu on 15/12/28.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "PaymentCell1.h"

@interface PaymentCell1 ()
@property (nonatomic, weak) IBOutlet    UILabel *title;
@property (nonatomic, weak) IBOutlet    UILabel *content;
@end

@implementation PaymentCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 78.0f;
}

- (void)setProduct:(FinancialProduct *)product
{
    self.title.text = product.product_title;
    self.content.text = [[NSString alloc] initWithFormat:@"%@元", product.paymentMoney];
}

@end
