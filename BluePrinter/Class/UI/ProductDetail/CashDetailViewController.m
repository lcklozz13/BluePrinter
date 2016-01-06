//
//  CashDetailViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/30.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "CashDetailViewController.h"
#import "CashDetailCell00.h"
#import "CashDetailCell01.h"
#import "CashDetailCell1.h"
#import "CashDetailFootView.h"
#import "AssetDetailsViewController.h"
#import "TransactionDetailViewController.h"

@interface CashDetailViewController ()<UIAlertViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView     *tableview;
@end

@implementation CashDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"变现详情"];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"CashDetailCell00" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"CashDetailCell01" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"CashDetailCell1" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"CashDetailFootView" forCellOrHeaderFootViewFlag:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)canncalCashAction:(id)sender
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是否要取消变现？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    alertview.tag = 10010;
    [alertview show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10010 && buttonIndex == 1)
    {
        //取消变现后，剩余未变现金额将取消变现交易，已成交金额已转入你的余额宝。
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"取消变现后，剩余未变现金额将取消变现交易，已成交金额已转入你的余额宝。" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        alertview.tag = 10086;
        [alertview show];
    }
    else if (alertView.tag == 10086 && buttonIndex == 1)
    {
        UIViewController *assetDetailHandle = nil;
        NSArray *controllers = [self.navigationController viewControllers];
        
        for (id viewcontroll in controllers)
        {
            if ([viewcontroll isKindOfClass:[AssetDetailsViewController class]])
            {
                assetDetailHandle = viewcontroll;
                break;
            }
        }
        
        if (!assetDetailHandle)
        {
            for (id viewcontroll in controllers)
            {
                if ([viewcontroll isKindOfClass:[TransactionDetailViewController class]])
                {
                    assetDetailHandle = viewcontroll;
                    break;
                }
            }
        }
        
        [self.navigationController popToViewController:assetDetailHandle animated:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return 10.0f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            if (indexPath.row == 0)
            {
                return [CashDetailCell00 cellHeight];
            }
            else
            {
                return [CashDetailCell01 cellHeight];
            }
        }
            break;
            
        case 1:
        {
            return [CashDetailCell1 cellHeight];
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 1;
        }
            break;
            
        case 1:
        {
            return [CashDetailFootView viewHeight];
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil;
    }
    else
    {
        UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
        [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
        
        return view;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return nil;
        }
            break;
            
        case 1:
        {
            CashDetailFootView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CashDetailFootView"];
            
            return view;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 2;
        }
            break;
            
        case 1:
        {
            return 4;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section)
    {
        case 0:
        {
            if (indexPath.row == 0)
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"CashDetailCell00" forIndexPath:indexPath];
            }
            else
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"CashDetailCell01" forIndexPath:indexPath];
            }
        }
            break;
            
        case 1:
        {
            CashDetailCell1 *cell1 = nil;
            
            switch (indexPath.row)
            {
                case 0:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"CashDetailCell1" forIndexPath:indexPath];
                    cell1 = (CashDetailCell1 *)cell;
                    cell1.textLabel.text = @"变现利率";
                    cell1.detailTextLabel.text = @"6.3%";
                }
                    break;
                    
                case 1:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"CashDetailCell1" forIndexPath:indexPath];
                    cell1 = (CashDetailCell1 *)cell;
                    cell1.textLabel.text = @"手续费（元）";
                    cell1.detailTextLabel.text = @"0.00";
                }
                    break;
                    
                case 2:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"CashDetailCell1" forIndexPath:indexPath];
                    cell1 = (CashDetailCell1 *)cell;
                    cell1.textLabel.text = @"变现申请时间";
                    cell1.detailTextLabel.text = @"2015-12-12";
                }
                    break;
                    
                case 3:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"CashDetailCell1" forIndexPath:indexPath];
                    cell1 = (CashDetailCell1 *)cell;
                    cell1.textLabel.text = @"到期应付利息（元）";
                    cell1.detailTextLabel.text = @"0.00";
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    
    // Configure the cell...
    
    return cell;
}
@end
