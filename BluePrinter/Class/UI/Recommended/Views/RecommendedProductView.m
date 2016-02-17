//
//  RecommendedProductView.m
//  LittleFawn
//
//  Created by baidu on 16/2/17.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "RecommendedProductView.h"

@interface RecommendedProductView ()
@property (nonatomic, strong) FinancialProduct  *curProduct;
- (void)initViews;

@end

@implementation RecommendedProductView
@synthesize curProduct;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (FinancialProduct *)getCurRecommendedProduct
{
    return self.curProduct;
}

- (void)initViews
{
    UIImageView *cricle = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-178.0f)/2.0, 15.0f, 178.0f, 178.0f)];
    [cricle setImage:[UIImage imageNamed:@"icon-circle"]];
    [self addSubview:cricle];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-126.0f)/2.0, 46.0f, 126, 21)];
    [title setFont:[UIFont systemFontOfSize:14.0f]];
    [title setTextColor:[PublicMethods gs_colorWithHexString:@"4F759A"]];
    [title setText:@"1元领26888元"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:title];
    
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-160.0f)/2.0, 75.0f, 160, 57)];
    NSAttributedString *rate = [[NSAttributedString alloc] initWithString:curProduct.product_annual_rate attributes:[PublicMethods getTextAttributedWithForegroundColor:@"4f759a" fontSize:50.0f]];
    NSAttributedString *Percent = [[NSAttributedString alloc] initWithString:@"%" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"4f759a" fontSize:25.0f]];
    NSMutableAttributedString *ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:rate];
    [ratestring appendAttributedString:Percent];
    title1.attributedText = ratestring;
    [title1 setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:title1];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-126.0f)/2.0, 140, 126, 21)];
    [title2 setFont:[UIFont systemFontOfSize:14.0f]];
    [title2 setTextColor:[PublicMethods gs_colorWithHexString:@"4F759A"]];
    [title2 setText:@"新手理财计划5"];
    [self addSubview:title2];
    [title2 setTextAlignment:NSTextAlignmentCenter];
    
    UILabel *title3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 201, self.frame.size.width, 21)];
    [title3 setFont:[UIFont systemFontOfSize:14.0f]];
    [title3 setTextColor:[PublicMethods gs_colorWithHexString:@"484747"]];
    [title3 setText:@"期限5天"];
    [self addSubview:title3];
    [title3 setTextAlignment:NSTextAlignmentCenter];
}

- (id)initWithFrame:(CGRect)frame financialProduct:(FinancialProduct *)product
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.curProduct = product;
        [self initViews];
    }
    
    return self;
}

@end
