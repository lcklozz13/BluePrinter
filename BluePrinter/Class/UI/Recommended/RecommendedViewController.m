//
//  RecommendedViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/24.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "RecommendedViewController.h"
#import "ViewControllerManager.h"
#import "ProductDetailViewController.h"

@interface RecommendedViewController ()
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UILabel *title4;
@property (nonatomic, strong) FinancialProduct  *curProduct;
- (void)setRecommendedProduct:(FinancialProduct *)product;
@end

@implementation RecommendedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"精品推荐"];
    [self setLeftBarButtonWithImageName:@"icon-personal- information" target:[[ViewControllerManager getInstance] getSlideMenuView] action:@selector(showLeft:)];
    [self setRightBarButtonWithImageName:@"icon-search" action:@selector(searchAction)];
    
    FinancialProduct *product = [[FinancialProduct alloc] init];
    product.product_type = FinancialProductType_Personal;
    product.product_title = @"个人贷859080";
    product.product_annual_rate = @"30.0";
    product.product_limit_time = @"12个月";
    product.product_purchase_amount = @"3000.00元";
    product.product_progress_rate = @"60";
    product.product_purchased_quantity = @"35笔";
    product.product_remaining_amount = @"12393400.00元";
    product.product_gross = @"123563400.00";
    product.product_deadline = @"2016年12月31日";
    product.product_repayment = @"一次性还清本息";
    
    self.curProduct = product;
    [self setRecommendedProduct:product];
}

- (void)setRecommendedProduct:(FinancialProduct *)product
{
    static CGFloat scale = 0;
    
    if (scale == 0)
    {
        scale = SCREEN_WIDTH/320.0f;
        [self.title1 setFont:[UIFont systemFontOfSize:14.0f*scale]];
        [self.title3 setFont:[UIFont systemFontOfSize:14.0f*scale]];
        [self.title4 setFont:[UIFont systemFontOfSize:14.0f*scale]];
    }
    
    
    NSAttributedString *rate = [[NSAttributedString alloc] initWithString:product.product_annual_rate attributes:[PublicMethods getTextAttributedWithForegroundColor:@"4f759a" fontSize:scale*50.0f]];
    NSAttributedString *Percent = [[NSAttributedString alloc] initWithString:@"%" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"4f759a" fontSize:25.0f*scale]];
    NSMutableAttributedString *ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:rate];
    [ratestring appendAttributedString:Percent];
    self.title2.attributedText = ratestring;
}

- (void)searchAction
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.parentViewController.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.navigationController.visibleViewController != self)
    {
        self.parentViewController.tabBarController.tabBar.hidden = YES;
    }
}

- (IBAction)buyAction:(id)sender
{
    ProductDetailViewController *view = [[ProductDetailViewController alloc] initWithProduct:self.curProduct];
    [self.navigationController pushViewController:view animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
