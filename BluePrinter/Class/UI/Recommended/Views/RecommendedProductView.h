//
//  RecommendedProductView.h
//  LittleFawn
//
//  Created by baidu on 16/2/17.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FinancialProduct;

@interface RecommendedProductView : UIControl
- (FinancialProduct *)getCurRecommendedProduct;
- (id)initWithFrame:(CGRect)frame financialProduct:(FinancialProduct *)product;
@end
