//
//  ProductProfitCell.m
//  LittleFawn
//
//  Created by baidu on 15/12/25.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "ProductProfitCell.h"
#define PROGRESS_START_TAG      1001

@interface ProductProfitCell ()
@property (weak, nonatomic) IBOutlet UILabel *annualRateLab;
@property (weak, nonatomic) IBOutlet UILabel *limitTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *purchaseAmountLab;
@property (weak, nonatomic) IBOutlet UILabel *progressRateLab;
@property (weak, nonatomic) IBOutlet UILabel *purchasedQuantityLab;
@property (weak, nonatomic) IBOutlet UILabel *remainingAmountLab;

@end

@implementation ProductProfitCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 277.0f;
}

- (void)setProduct:(FinancialProduct *)product
{
    //@"fa5156"
    //@"b5b5b6"
    //@"727171"
    NSAttributedString *rate = [[NSAttributedString alloc] initWithString:product.product_annual_rate attributes:[PublicMethods getTextAttributedWithForegroundColor:@"fa5156" fontSize:79.0f]];
    NSAttributedString *Percent = [[NSAttributedString alloc] initWithString:@"%" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"fa5156" fontSize:37.0f]];
    NSMutableAttributedString *ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:rate];
    [ratestring appendAttributedString:Percent];
    self.annualRateLab.attributedText = ratestring;
    
    NSAttributedString *limit = [[NSAttributedString alloc] initWithString:@"产品期限" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"b5b5b6" fontSize:14.0f]];
    NSAttributedString *limitTime = [[NSAttributedString alloc] initWithString:product.product_limit_time attributes:[PublicMethods getTextAttributedWithForegroundColor:@"b5b5b6" fontSize:14.0f]];
    ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:limit];
    [ratestring appendAttributedString:limitTime];
    self.limitTimeLab.attributedText = ratestring;
    
    NSAttributedString *purchaseAmount = [[NSAttributedString alloc] initWithString:@"起购金额" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"b5b5b6" fontSize:14.0f]];
    NSAttributedString *amount = [[NSAttributedString alloc] initWithString:product.product_purchase_amount attributes:[PublicMethods getTextAttributedWithForegroundColor:@"b5b5b6" fontSize:14.0f]];
    ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:purchaseAmount];
    [ratestring appendAttributedString:amount];
    self.purchaseAmountLab.attributedText = ratestring;
    
    NSAttributedString *progress = [[NSAttributedString alloc] initWithString:product.product_progress_rate attributes:[PublicMethods getTextAttributedWithForegroundColor:@"fa5156" fontSize:20.0f]];
    Percent = [[NSAttributedString alloc] initWithString:@"%" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"fa5156" fontSize:9.0f]];
    ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:progress];
    [ratestring appendAttributedString:Percent];
    self.progressRateLab.attributedText = ratestring;
    
    NSAttributedString *purchasedQuantity = [[NSAttributedString alloc] initWithString:@"已购买:" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"b5b5b6" fontSize:14.0f]];
    NSAttributedString *Quantity = [[NSAttributedString alloc] initWithString:product.product_purchased_quantity attributes:[PublicMethods getTextAttributedWithForegroundColor:@"727171" fontSize:14.0f]];
    ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:purchasedQuantity];
    [ratestring appendAttributedString:Quantity];
    self.purchasedQuantityLab.attributedText = ratestring;
    
    NSAttributedString *remainingAmount = [[NSAttributedString alloc] initWithString:@"剩余:" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"b5b5b6" fontSize:14.0f]];
    NSAttributedString *Amount = [[NSAttributedString alloc] initWithString:product.product_remaining_amount attributes:[PublicMethods getTextAttributedWithForegroundColor:@"727171" fontSize:14.0f]];
    ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:remainingAmount];
    [ratestring appendAttributedString:Amount];
    self.remainingAmountLab.attributedText = ratestring;
    
    UIImageView *progressImage = nil;
    int progressValue = [product.product_progress_rate intValue] / 10;
    
    for (int i=0; i<10; i++)
    {
        progressImage = [self.contentView viewWithTag:PROGRESS_START_TAG+i];
        [progressImage setHighlighted:progressValue > i ? YES : NO];
    }
}

@end
/*
 product_annual_rate;
 product_limit_time;
 product_purchase_amount;
 product_progress_rate;
 product_purchased_quantity;
 product_remaining_amount;
 */