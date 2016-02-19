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
#import "SearchViewController.h"
#import "RecommendedProductView.h"

#import "ProductDetailViewController.h"
#import "RegularProductCell.h"
#import "RecommendedHeaderView.h"

@interface RecommendedViewController ()<UIScrollViewDelegate>
//@property (weak, nonatomic) IBOutlet UILabel *title1;
//@property (weak, nonatomic) IBOutlet UILabel *title2;
//@property (weak, nonatomic) IBOutlet UILabel *title3;
//@property (weak, nonatomic) IBOutlet UILabel *title4;

@property (nonatomic, strong) NSMutableArray            *hotArray;

@property (weak, nonatomic) IBOutlet    UITableView     *tableView;
@property (weak, nonatomic) IBOutlet    UIScrollView    *recommondView;
@property (nonatomic, weak) IBOutlet    UIButton        *leftBtn;
@property (nonatomic, weak) IBOutlet    UIButton        *rightBtn;
@property (nonatomic, assign) int                       page;


@property (nonatomic, strong) NSMutableArray  *curRecommondProductArray;
- (void)setRecommendedProducts;
@end

@implementation RecommendedViewController
@synthesize curRecommondProductArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"精品推荐"];
    [self setLeftBarButtonWithImageName:@"icon-personal- information" target:[[ViewControllerManager getInstance] getSlideMenuView] action:@selector(showLeft:)];
    [self setRightBarButtonWithImageName:@"icon-search" action:@selector(searchAction)];
    
//    FinancialProduct *product = [[FinancialProduct alloc] init];
//    product.product_type = FinancialProductType_Personal;
//    product.product_title = @"个人贷859080";
//    product.product_annual_rate = @"30.0";
//    product.product_limit_time = @"12个月";
//    product.product_purchase_amount = @"3000.00元";
//    product.product_progress_rate = @"60";
//    product.product_purchased_quantity = @"35笔";
//    product.product_remaining_amount = @"12393400.00元";
//    product.product_gross = @"123563400.00";
//    product.product_deadline = @"2016年12月31日";
//    product.product_repayment = @"一次性还清本息";
    
//    self.curProduct = product;
//    [self setRecommendedProduct:product];
    
//    [self setRecommendedProducts];
    
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"RegularProductCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableView registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"RecommendedHeaderView" forCellOrHeaderFootViewFlag:NO];
    [self initDatas];
}

- (void)initDatas
{
    self.hotArray = [NSMutableArray array];
    
    int hotcount = [PublicMethods getRandomNumber:5 to:10];
    
    for (int i=0; i<hotcount; i++)
    {
        FinancialProductType type = [PublicMethods getRandomNumber:0 to:2];
        [self.hotArray addObject:[FinancialProduct createFinancialProductFromFinancialProductType:type]];
    }
    
    [self.tableView reloadData];
}


- (void)showForwordItem
{
    self.page -= 1;
    [self.recommondView setContentOffset:CGPointMake(self.recommondView.frame.size.width * self.page, 0) animated:YES];
}

- (void)showNextItem
{
    self.page += 1;
    [self.recommondView setContentOffset:CGPointMake(self.recommondView.frame.size.width * self.page, 0) animated:YES];
}

- (void)setRecommendedProducts
{
    if (curRecommondProductArray)
    {
        return;
    }
    
    curRecommondProductArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[PublicMethods getRandomNumber:1 to:5]; i++)
    {
        FinancialProductType type = [PublicMethods getRandomNumber:0 to:2];
        [curRecommondProductArray addObject:[FinancialProduct createFinancialProductFromFinancialProductType:type]];
    }
    
    CGSize size = CGSizeMake(SCREEN_SIZE.width, self.recommondView.frame.size.height);
    int index = 0;
    
    for (FinancialProduct *product in curRecommondProductArray)
    {
        CGRect frame = CGRectMake(index*size.width, 0, size.width, size.height);
        
        RecommendedProductView *view = [[RecommendedProductView alloc] initWithFrame:frame financialProduct:product];
        [self.recommondView addSubview:view];
        [view addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
        index++;
    }
    
    [self.recommondView setContentSize:CGSizeMake(size.width*index, size.height)];
    
    self.page = 0;
    [self.leftBtn addTarget:self action:@selector(showForwordItem) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(showNextItem) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)setRecommendedProduct:(FinancialProduct *)product
//{
//    static CGFloat scale = 0;
//    
//    if (scale == 0)
//    {
//        scale = SCREEN_WIDTH/320.0f;
//        [self.title1 setFont:[UIFont systemFontOfSize:14.0f*scale]];
//        [self.title3 setFont:[UIFont systemFontOfSize:14.0f*scale]];
//        [self.title4 setFont:[UIFont systemFontOfSize:14.0f*scale]];
//    }
//    
//    
//    NSAttributedString *rate = [[NSAttributedString alloc] initWithString:product.product_annual_rate attributes:[PublicMethods getTextAttributedWithForegroundColor:@"4f759a" fontSize:scale*50.0f]];
//    NSAttributedString *Percent = [[NSAttributedString alloc] initWithString:@"%" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"4f759a" fontSize:25.0f*scale]];
//    NSMutableAttributedString *ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:rate];
//    [ratestring appendAttributedString:Percent];
//    self.title2.attributedText = ratestring;
//}

- (void)searchAction
{
    SearchViewController *view = [[SearchViewController alloc] init];
    
    [self.parentViewController presentViewController:view animated:YES completion:nil];
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

- (void)buyAction:(RecommendedProductView *)sender
{
    ProductDetailViewController *view = [[ProductDetailViewController alloc] initWithProduct:[sender getCurRecommendedProduct]];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)setPage:(int)newPage
{
    _page = newPage;
    [self.leftBtn setEnabled:_page==0?NO:YES];
    
    if ([curRecommondProductArray count] == 0 || _page == [curRecommondProductArray count] - 1)
    {
        [self.rightBtn setEnabled:NO];
    }
    else
    {
        [self.rightBtn setEnabled:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.page = scrollView.contentOffset.x / scrollView.frame.size.width;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [RecommendedHeaderView ViewHeight];
    }
    
    return 4.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.hotArray count];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        RecommendedHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RecommendedHeaderView"];
        view.recommondView.delegate = self;
        self.recommondView = view.recommondView;
        self.leftBtn = view.leftBtn;
        self.rightBtn = view.rightBtn;
        
        [self setRecommendedProducts];
        
        return view;
    }
    
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RegularProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegularProductCell" forIndexPath:indexPath];
    FinancialProduct *product = self.hotArray[indexPath.section];
    
    if (product)
    {
        [cell setProduct:product];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FinancialProduct *product = self.hotArray[indexPath.section];
    
    ProductDetailViewController *view = [[ProductDetailViewController alloc] initWithProduct:product];
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
