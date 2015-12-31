//
//  RegularProductCell.m
//  MobileExperienceStore
//
//  Created by klozz on 15/12/5.
//  Copyright © 2015年 91. All rights reserved.
//

#import "RegularProductCell.h"

@interface RegularProductCell ()
@property (nonatomic, weak) IBOutlet  UIImageView   *titleImageView;
@property (nonatomic, weak) IBOutlet  UILabel       *titleLab;
@property (nonatomic, weak) IBOutlet  UIImageView   *saleOutImageView;
@property (nonatomic, weak) IBOutlet  UILabel       *rateLab;
@property (nonatomic, weak) IBOutlet  UILabel       *limitTimeLab;

@end

@implementation RegularProductCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)getCellHeight
{
    return 180.0f;
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
    
    [self.saleOutImageView setHidden:!product.product_is_sold_out];
    
    [self.titleLab setText:product.product_title];
    
    
    NSAttributedString *rate = [[NSAttributedString alloc] initWithString:product.product_annual_rate attributes:[PublicMethods getTextAttributedWithForegroundColor:@"fa5156" fontSize:30.0f]];
    NSAttributedString *Percent = [[NSAttributedString alloc] initWithString:@"%" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"fa5156" fontSize:15.0f]];
    NSMutableAttributedString *ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:rate];
    [ratestring appendAttributedString:Percent];
    [self.rateLab setAttributedText:ratestring];
    
    rate = [[NSAttributedString alloc] initWithString:[product.product_limit_time substringToIndex:[product.product_limit_time length] - 1] attributes:[PublicMethods getTextAttributedWithForegroundColor:@"494B4B" fontSize:20.0f]];
    Percent = [[NSAttributedString alloc] initWithString:[product.product_limit_time substringFromIndex:[product.product_limit_time length] - 1] attributes:[PublicMethods getTextAttributedWithForegroundColor:@"B5B6B6" fontSize:10.0f]];
    ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:rate];
    [ratestring appendAttributedString:Percent];
    [self.limitTimeLab setAttributedText:ratestring];
}

@end
