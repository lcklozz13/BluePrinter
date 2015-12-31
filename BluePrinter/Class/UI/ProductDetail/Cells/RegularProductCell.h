//
//  RegularProductCell.h
//  MobileExperienceStore
//
//  Created by klozz on 15/12/5.
//  Copyright © 2015年 91. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegularProductCell : UITableViewCell
+ (CGFloat)getCellHeight;
- (void)setProduct:(FinancialProduct *)product;
@end
