//
//  ProductDetailViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/25.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductDescriptionCell.h"
#import "ProductHeadView.h"
#import "ProductInfoCell.h"
#import "ProductProfitCell.h"
#import "ContractInformationCell.h"
#import "LoginOrRegisterViewController.h"
#import "ProductsContractViewController.h"
#import "RiskDisclosureViewController.h"
#import "PurchaseViewController.h"

@interface ProductDetailViewController ()
@property (nonatomic, weak) IBOutlet    UITableView     *tableView;
@property (nonatomic, weak) IBOutlet    UIButton        *purcahseBtn;
@property (nonatomic, strong) FinancialProduct          *curProduct;
- (IBAction)purchaseAction:(id)sender;
@end

@implementation ProductDetailViewController

- (id)initWithProduct:(FinancialProduct *)product
{
    self = [super init];
    
    if (self)
    {
        self.curProduct = product;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"ProductHeadView" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"ProductDescriptionCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"ProductInfoCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"ProductProfitCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"ContractInformationCell" forCellOrHeaderFootViewFlag:YES];
    
    [self setTitle:@"产品详情"];
    
    if (!DATA_MANAGER.isLogin)
    {
        [self.purcahseBtn setTitle:@"请登录" forState:UIControlStateNormal];
    }
    else
    {
        [self.purcahseBtn setTitle:@"购买" forState:UIControlStateNormal];
    }
    
    [self.purcahseBtn setEnabled:!self.curProduct.product_is_sold_out];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:NOTIF_REQUEST_LOGIN_SUCCESS object:nil];
}

- (void)loginSuccess
{
    [self.purcahseBtn setTitle:@"购买" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)purchaseAction:(id)sender
{
    if (DATA_MANAGER.isLogin)
    {
        //TODO:go to purchase product
        PurchaseViewController *view = [[PurchaseViewController alloc] initWithProduct:self.curProduct];
        [self.navigationController pushViewController:view animated:YES];
    }
    else
    {
        [[ViewControllerManager getInstance] setLoginSuccessBackViewController:self];
        LoginOrRegisterViewController *view = [[LoginOrRegisterViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfRows
{
    if (!self.curProduct)
    {
        return 0;
    }
    
    return 4;
}


#pragma mark - Table view delagate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [ProductHeadView viewHeight];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ProductHeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ProductHeadView"];
    [view setProduct:self.curProduct];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfRows];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            return [ProductProfitCell cellHeight];
        }
            break;
            
        case 1:
        {
            return [ProductInfoCell cellHeight];
        }
            break;
            
        case 2:
        {
            return [ContractInformationCell cellHeight];
        }
            break;
            
        case 3:
        {
            return [ProductDescriptionCell cellHeight];
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    switch (indexPath.row)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ProductProfitCell" forIndexPath:indexPath];
            [((ProductProfitCell *)cell) setProduct:self.curProduct];
        }
            break;
            
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ProductInfoCell" forIndexPath:indexPath];
            [((ProductInfoCell *)cell) setProduct:self.curProduct];
        }
            break;
            
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ContractInformationCell" forIndexPath:indexPath];
            ((ContractInformationCell *)cell).clickCallback = ^(NSInteger index)
            {
                if (index == 0)
                {
                    //TODO:产品合同
                    ProductsContractViewController *view = [[ProductsContractViewController alloc] init];
                    [self.navigationController pushViewController:view animated:YES];
                }
                else
                {
                    //TODO:风险提示
                    RiskDisclosureViewController *view = [[RiskDisclosureViewController alloc] init];
                    [self.navigationController pushViewController:view animated:YES];
                }
            };
        }
            break;
            
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDescriptionCell" forIndexPath:indexPath];
        }
            break;
            
        default:
            break;
    }
    // Configure the cell...
    
    return cell;
}

@end
