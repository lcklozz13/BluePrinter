//
//  AccumulatedEarningsTitleCell.h
//  LittleFawn
//
//  Created by klozz on 16/1/3.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccumulatedEarningsTitleCell : UITableViewCell
@property (nonatomic, weak) IBOutlet    UILabel *totalEarningsLab;
@property (nonatomic, weak) IBOutlet    UILabel *totalEarningsRateLab;
+ (CGFloat)cellHeight;
@end
