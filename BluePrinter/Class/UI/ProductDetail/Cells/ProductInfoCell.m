//
//  ProductInfoCell.m
//  LittleFawn
//
//  Created by baidu on 15/12/25.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "ProductInfoCell.h"

@interface ProductInfoCell ()
@property (nonatomic, weak) IBOutlet    UILabel     *productGrossLab;
@property (nonatomic, weak) IBOutlet    UILabel     *productDeadlineLab;
@property (nonatomic, weak) IBOutlet    UILabel     *productRepaymentLab;
@end

@implementation ProductInfoCell
/*
 product_gross;
 product_deadline;
 product_repayment;
 */

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 210.0f;
}


- (void)setProduct:(FinancialProduct *)product
{
    self.productGrossLab.text = [[NSString alloc] initWithFormat:@"%@元", product.product_gross];
    self.productDeadlineLab.text = product.product_deadline;
    self.productRepaymentLab.text = product.product_repayment;
}
@end
