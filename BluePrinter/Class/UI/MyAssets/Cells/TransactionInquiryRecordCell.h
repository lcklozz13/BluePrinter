//
//  TransactionInquiryRecordCell.h
//  LittleFawn
//
//  Created by klozz on 16/1/4.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionInquiryRecordCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel    *titleLab;
@property (nonatomic, weak) IBOutlet UILabel    *timeLab;
+ (CGFloat)cellHeight;
- (void)setProduct:(FinancialProduct *)product;
@end
