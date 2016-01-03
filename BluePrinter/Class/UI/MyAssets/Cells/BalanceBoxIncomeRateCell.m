//
//  BalanceBoxIncomeRateCell.m
//  LittleFawn
//
//  Created by klozz on 16/1/2.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "BalanceBoxIncomeRateCell.h"

@implementation BalanceBoxIncomeRateCell

- (void)awakeFromNib {
    // Initialization code
    
    self.lineChart.xLabelColor = [PublicMethods gs_colorWithHexString:@"727171"];
    self.lineChart.yLabelColor = [PublicMethods gs_colorWithHexString:@"727171"];
    self.lineChart.axisColor = [PublicMethods gs_colorWithHexString:@"727171"];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    self.lineChart.showCoordinateAxis = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 100.0;
    self.lineChart.yFixedValueMin = 0.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 240.0f;
}

@end
