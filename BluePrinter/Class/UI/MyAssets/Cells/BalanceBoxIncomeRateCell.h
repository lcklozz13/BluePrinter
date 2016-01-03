//
//  BalanceBoxIncomeRateCell.h
//  LittleFawn
//
//  Created by klozz on 16/1/2.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNLineChart.h"

@interface BalanceBoxIncomeRateCell : UITableViewCell
@property (nonatomic, weak) IBOutlet PNLineChart * lineChart;
+ (CGFloat)cellHeight;
@end
