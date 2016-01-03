//
//  AccumulatedEarningsDetailCell.m
//  LittleFawn
//
//  Created by klozz on 16/1/3.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "AccumulatedEarningsDetailCell.h"

@implementation AccumulatedEarningsDetailCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)cellHeight
{
    return 65.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProduct:(FinancialProduct *)product
{
    self.titleLab.text = product.product_title;
    
    NSString *income = [[NSString alloc] initWithFormat:@"%d.00元", [PublicMethods getRandomNumber:100000 to:1000000000]];
    
    NSAttributedString *rate = [[NSAttributedString alloc] initWithString:[income substringToIndex:[income length] - 1] attributes:[PublicMethods getTextAttributedWithForegroundColor:@"fa5156" fontSize:14.0f]];
    NSAttributedString *Percent = [[NSAttributedString alloc] initWithString:[income substringFromIndex:[income length] - 1] attributes:[PublicMethods getTextAttributedWithForegroundColor:@"727171" fontSize:14.0f]];
    NSMutableAttributedString *ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:rate];
    [ratestring appendAttributedString:Percent];
    [self.incomeLab setAttributedText:ratestring];
}

@end
