//
//  ProductHeadView.m
//  LittleFawn
//
//  Created by baidu on 15/12/25.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "ProductHeadView.h"

@interface ProductHeadView ()
@property (nonatomic, weak) IBOutlet    UIImageView *titleImageView;
@property (nonatomic, weak) IBOutlet    UILabel     *titleLab;
@end

@implementation ProductHeadView

- (void)awakeFromNib {
    // Initialization code

}

- (void)setProduct:(FinancialProduct *)product
{
    switch (product.product_type)
    {
        case FinancialProductType_Enterprise:
        {
            [self.titleImageView setImage:[UIImage imageNamed:@"icon-company"]];
        }
            break;
            
        case FinancialProductType_Personal:
        {
            [self.titleImageView setImage:[UIImage imageNamed:@"icon-personal"]];
        }
            break;
            
        case FinancialProductType_Regular:
        {
            [self.titleImageView setImage:[UIImage imageNamed:@"icon-regular"]];
        }
            break;
            
        default:
            break;
    }
    
    [self.titleLab setText:product.product_title];
}

+ (CGFloat)viewHeight
{
    return 40.0f;
}

@end
