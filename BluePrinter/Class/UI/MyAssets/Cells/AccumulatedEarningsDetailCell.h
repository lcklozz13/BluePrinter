//
//  AccumulatedEarningsDetailCell.h
//  LittleFawn
//
//  Created by klozz on 16/1/3.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccumulatedEarningsDetailCell : UITableViewCell
@property (nonatomic, weak) IBOutlet    UILabel *titleLab;
@property (nonatomic, weak) IBOutlet    UILabel *incomeLab;
+ (CGFloat)cellHeight;
- (void)setProduct:(FinancialProduct *)product;
@end
