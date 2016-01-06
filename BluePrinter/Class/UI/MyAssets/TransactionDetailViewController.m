//
//  TransactionDetailViewController.m
//  LittleFawn
//
//  Created by klozz on 16/1/4.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "TransactionDetailViewController.h"
#import "BecomeCashViewController.h"
#import "TransactionHistoryDetailCell.h"
#import "TransactionTotalIncomeCell.h"
#import "TransactionHistoryCell.h"
#import "TransactionDateFootView.h"


@interface TransactionDetailViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableview;
@property (nonatomic, strong) FinancialProduct *curProduct;
- (IBAction)becomeCashAction:(id)sender;
@end

@implementation TransactionDetailViewController

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
    [self setTitle:@"交易明细"];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransactionHistoryDetailCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransactionTotalIncomeCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransactionHistoryCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransactionDateFootView" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableview registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)becomeCashAction:(id)sender
{
    BecomeCashViewController *view = [[BecomeCashViewController alloc] init];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [TransactionDateFootView viewHeight];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    TransactionDateFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TransactionDateFootView"];
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [TransactionTotalIncomeCell cellHeight];
    }
    else if (indexPath.row == 1)
    {
        return [TransactionHistoryCell cellHeight];
    }
    else
    {
        return [TransactionHistoryDetailCell cellHeight];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionTotalIncomeCell" forIndexPath:indexPath];
    }
    else if (indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionHistoryCell" forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionHistoryDetailCell" forIndexPath:indexPath];
    }
    
    return cell;
    
}

@end
