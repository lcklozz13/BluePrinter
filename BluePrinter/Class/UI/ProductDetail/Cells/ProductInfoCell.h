//
//  ProductInfoCell.h
//  LittleFawn
//
//  Created by baidu on 15/12/25.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductInfoCell : UITableViewCell
+ (CGFloat)cellHeight;
- (void)setProduct:(FinancialProduct *)product;
@end
