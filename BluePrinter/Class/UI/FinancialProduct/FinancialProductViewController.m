//
//  FinancialProductViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/24.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "FinancialProductViewController.h"
#import "ProductDetailViewController.h"
#import "RegularProductCell.h"
#import "SearchViewController.h"

typedef NS_ENUM(NSUInteger, CurrentModel)
{
    CurrentModel_Hot,           //热门
    CurrentModel_Personal,      //个人投资
    CurrentModel_Enterprise,    //企业投资
    CurrentModel_Regular        //定期投资
};

@interface FinancialProductViewController ()
@property (weak, nonatomic) IBOutlet    UISegmentedControl      *segmented;
@property (weak, nonatomic) IBOutlet    UITableView             *tableview;
@property (nonatomic, assign) CurrentModel     curModel;

@property (nonatomic, strong) NSMutableArray        *hotArray;
@property (nonatomic, strong) NSMutableArray        *personalArray;
@property (nonatomic, strong) NSMutableArray        *enterpriseArray;
@property (nonatomic, strong) NSMutableArray        *regularArray;

- (IBAction)changeModel:(id)sender;
@end

@implementation FinancialProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"理财产品"];
    [self setLeftBarButtonWithImageName:@"icon-personal- information" target:[[ViewControllerManager getInstance] getSlideMenuView] action:@selector(showLeft:)];
    [self setRightBarButtonWithImageName:@"icon-search" action:@selector(searchAction)];
    
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.curModel = CurrentModel_Hot;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [PublicMethods gs_colorWithHexString:@"FA5156"], NSForegroundColorAttributeName,
                         [UIFont systemFontOfSize:17.0f], NSFontAttributeName, nil];
    [self.segmented setTitleTextAttributes:dic forState:UIControlStateSelected];
    dic = [NSDictionary dictionaryWithObjectsAndKeys:
           [PublicMethods gs_colorWithHexString:@"767676"], NSForegroundColorAttributeName,
           [UIFont systemFontOfSize:17.0f], NSFontAttributeName, nil];
    [self.segmented setTitleTextAttributes:dic forState:UIControlStateNormal];
    [self.segmented setTintColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"RegularProductCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
    
    [self initDatas];
}

//- (FinancialProduct *)createFinancialProductFromFinancialProductType:(FinancialProductType)type
//{
//    FinancialProduct *product = [[FinancialProduct alloc] init];
//    
//    product.product_type = type;
//    product.product_annual_rate = [[NSString alloc] initWithFormat:@"%d.00", [PublicMethods getRandomNumber:8 to:100]];
//    product.product_limit_time = [[NSString alloc] initWithFormat:@"%d月", [PublicMethods getRandomNumber:1 to:12]];
//    product.product_purchase_amount = [[NSString alloc] initWithFormat:@"%d元", [PublicMethods getRandomNumber:100 to:10000]];
//    product.product_progress_rate = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:0 to:100]];
//    product.product_purchased_quantity = [[NSString alloc] initWithFormat:@"%d笔", [PublicMethods getRandomNumber:10 to:100]];
//    product.product_remaining_amount = [[NSString alloc] initWithFormat:@"%d.00元", [PublicMethods getRandomNumber:100000 to:1000000000]];
//    product.product_gross = [[NSString alloc] initWithFormat:@"%d.00", [PublicMethods getRandomNumber:100000 to:1000000000]];
//    product.product_deadline = @"2016年12月31日";
//    product.product_repayment = @"一次性还清本息";
//    product.product_is_sold_out = [PublicMethods getRandomNumber:0 to:1];
//    
//    switch (type)
//    {
//        case FinancialProductType_Personal:
//        {
//            product.product_title = [[NSString alloc] initWithFormat:@"个人贷%d", [PublicMethods getRandomNumber:123456 to:999999]];
//        }
//            break;
//            
//        case FinancialProductType_Enterprise:
//        {
//            product.product_title = [[NSString alloc] initWithFormat:@"中小企业贷%d号", [PublicMethods getRandomNumber:123456 to:999999]];
//        }
//            break;
//            
//        case FinancialProductType_Regular:
//        {
//            product.product_title = [[NSString alloc] initWithFormat:@"定期 招财宝%d", [PublicMethods getRandomNumber:1000 to:9999]];
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    return product;
//}

- (void)initDatas
{
    self.hotArray = [NSMutableArray array];
    self.personalArray = [NSMutableArray array];
    self.enterpriseArray = [NSMutableArray array];
    self.regularArray = [NSMutableArray array];
    
    int hotcount = [PublicMethods getRandomNumber:5 to:10];
    
    for (int i=0; i<hotcount; i++)
    {
        FinancialProductType type = [PublicMethods getRandomNumber:0 to:2];
        [self.hotArray addObject:[FinancialProduct createFinancialProductFromFinancialProductType:type]];
    }
    
    int personalCount = [PublicMethods getRandomNumber:5 to:10];
    
    for (int i=0; i<personalCount; i++)
    {
        [self.personalArray addObject:[FinancialProduct createFinancialProductFromFinancialProductType:FinancialProductType_Personal]];
    }
    
    int enterpriseCount = [PublicMethods getRandomNumber:5 to:10];
    
    for (int i=0; i<enterpriseCount; i++)
    {
        [self.enterpriseArray addObject:[FinancialProduct createFinancialProductFromFinancialProductType:FinancialProductType_Enterprise]];
    }
    
    int regularCount = [PublicMethods getRandomNumber:5 to:10];
    
    for (int i=0; i<regularCount; i++)
    {
        [self.regularArray addObject:[FinancialProduct createFinancialProductFromFinancialProductType:FinancialProductType_Regular]];
    }
    
    [self.tableview reloadData];
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

- (IBAction)changeModel:(id)sender
{
    self.curModel = self.segmented.selectedSegmentIndex;
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchAction
{
    SearchViewController *view = [[SearchViewController alloc] init];
    
    [self.parentViewController presentViewController:view animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (self.curModel)
    {
        case CurrentModel_Hot:
            return [self.hotArray count];
            
        case CurrentModel_Personal:
            return self.personalArray.count;
            
        case CurrentModel_Enterprise:
            return self.enterpriseArray.count;
            
        case CurrentModel_Regular:
            return self.regularArray.count;
            
        default:
            break;
    }
    
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
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
    FinancialProduct *product = nil;
    
    switch (self.curModel)
    {
        case CurrentModel_Hot:
            product = self.hotArray[indexPath.section];
            break;
            
        case CurrentModel_Personal:
            product = self.personalArray[indexPath.section];
            break;
            
        case CurrentModel_Enterprise:
            product = self.enterpriseArray[indexPath.section];
            break;
            
        case CurrentModel_Regular:
            product = self.regularArray[indexPath.section];
            break;
            
        default:
            break;
    }
    
    if (product)
    {
        [cell setProduct:product];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FinancialProduct *product = nil;
    
    switch (self.curModel)
    {
        case CurrentModel_Hot:
            product = self.hotArray[indexPath.section];
            break;
            
        case CurrentModel_Personal:
            product = self.personalArray[indexPath.section];
            break;
            
        case CurrentModel_Enterprise:
            product = self.enterpriseArray[indexPath.section];
            break;
            
        case CurrentModel_Regular:
            product = self.regularArray[indexPath.section];
            break;
            
        default:
            break;
    }
    
    ProductDetailViewController *view = [[ProductDetailViewController alloc] initWithProduct:product];
    [self.navigationController pushViewController:view animated:YES];
}


@end
