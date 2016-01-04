//
//  TransactionInquiryRecordCell.m
//  LittleFawn
//
//  Created by klozz on 16/1/4.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "TransactionInquiryRecordCell.h"

@implementation TransactionInquiryRecordCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProduct:(FinancialProduct *)product
{
    self.titleLab.text = product.product_title;
}

+ (CGFloat)cellHeight
{
    return 65.0f;
}

@end
