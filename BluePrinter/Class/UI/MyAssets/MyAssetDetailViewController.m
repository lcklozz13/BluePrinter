//
//  MyAssetDetailViewController.m
//  LittleFawn
//
//  Created by klozz on 16/1/2.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "MyAssetDetailViewController.h"
#import "MyAssetDetailCell.h"
#import "MyAssetDetailOtherCell.h"


@interface MyAssetDetailViewController ()
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@end

@implementation MyAssetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"资产详情"];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"MyAssetDetailCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"MyAssetDetailOtherCell" forCellOrHeaderFootViewFlag:YES];
    self.tableview.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [MyAssetDetailCell cellHeight];
    }
    else
    {
        return [MyAssetDetailOtherCell cellHeight];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MyAssetDetailCell" forIndexPath:indexPath];
        MyAssetDetailCell *cellTmp = (MyAssetDetailCell *)cell;
        cellTmp.totalAssetLab.text = DATA_MANAGER.userInfo.totalAsset;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MyAssetDetailOtherCell" forIndexPath:indexPath];
        
        if (indexPath.row == 1)
        {
            cell.textLabel.text = @"账户余额（元）";
            cell.detailTextLabel.text = DATA_MANAGER.userInfo.leaveMoney;
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"投资中金额（元）";
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d.00", [PublicMethods getRandomNumber:10000 to:1000000]];
        }
        else if (indexPath.row == 3)
        {
            cell.textLabel.text = @"投资券金额（元）";
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d.00", [PublicMethods getRandomNumber:10000 to:1000000]];
        }
        else if (indexPath.row == 4)
        {
            cell.textLabel.text = @"待结算收益（元）";
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d.00", [PublicMethods getRandomNumber:10000 to:1000000]];
        }
        else if (indexPath.row == 5)
        {
            cell.textLabel.text = @"已结算收益（元）";
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d.00", [PublicMethods getRandomNumber:10000 to:1000000]];
        }
    }
    
    return cell;
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 1)
//    {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        
//        switch (indexPath.row)
//        {
//            case 0:
//            {
//                
//            }
//                break;
//                
//            case 1:
//            {
//                
//            }
//                break;
//                
//            case 2:
//            {
//                
//            }
//                break;
//                
//            case 3:
//            {
//                
//            }
//                break;
//                
//            case 4:
//            {
//                
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }
//}

@end
