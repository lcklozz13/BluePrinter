//
//  BalanceBoxViewController.m
//  LittleFawn
//
//  Created by klozz on 16/1/2.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "BalanceBoxViewController.h"
#import "TransferredIntoViewController.h"
#import "BalanceBoxIncomeRateCell.h"
#import "BalanceBoxOtherCell.h"
#import "PNChartDelegate.h"
#import "PNChart.h"

@interface BalanceBoxViewController ()<PNChartDelegate>
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
- (IBAction)turnIntoAction:(id)sender;
- (IBAction)turnOutAction:(id)sender;
@end

@implementation BalanceBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"余额宝"];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"BalanceBoxIncomeRateCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"BalanceBoxOtherCell" forCellOrHeaderFootViewFlag:YES];
    self.tableview.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)turnIntoAction:(id)sender
{
    TransferredIntoViewController *view = [[TransferredIntoViewController alloc] initWithViewType:ViewTyp_turnInto];
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)turnOutAction:(id)sender
{
    TransferredIntoViewController *view = [[TransferredIntoViewController alloc] initWithViewType:ViewType_turnOut];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 5;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [BalanceBoxOtherCell cellHeight];
    }
    else
    {
        return [BalanceBoxIncomeRateCell cellHeight];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"BalanceBoxOtherCell" forIndexPath:indexPath];
        
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"总余额（元）";
            cell.detailTextLabel.text = DATA_MANAGER.userInfo.leaveMoney;
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"万份收益（元）";
            cell.detailTextLabel.text = DATA_MANAGER.userInfo.leaveMoney;
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"累计收益（元）";
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d.00", [PublicMethods getRandomNumber:10000 to:1000000]];
        }
        else if (indexPath.row == 3)
        {
            cell.textLabel.text = @"近一周收益（元）";
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d.00", [PublicMethods getRandomNumber:10000 to:1000000]];
        }
        else if (indexPath.row == 4)
        {
            cell.textLabel.text = @"近一月收益（元）";
            cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d.00", [PublicMethods getRandomNumber:10000 to:1000000]];
        }
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"BalanceBoxIncomeRateCell" forIndexPath:indexPath];
        BalanceBoxIncomeRateCell *cellTmp = (BalanceBoxIncomeRateCell *)cell;
        [cellTmp.lineChart setXLabels:@[@"12月20日",@"21",@"22",@"23",@"24",@"25",@"26"]];
        // Line Chart #1
        NSArray * data01Array = @[@60.1, @50.1, @70.4, @54.2, @19.2, @27.2, @76.2];
        PNLineChartData *data01 = [PNLineChartData new];
        data01.color = [UIColor orangeColor];
        data01.alpha = 1.0f;
        data01.itemCount = data01Array.count;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        cellTmp.lineChart.chartData = @[data01];
        [cellTmp.lineChart strokeChart];
        cellTmp.lineChart.delegate = self;
    }
    
    return cell;
    
}

#pragma mark - PNChartDelegate
/**
 * Callback method that gets invoked when the user taps on the chart line.
 */
- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex
{
    
}

/**
 * Callback method that gets invoked when the user taps on a chart line key point.
 */
- (void)userClickedOnLineKeyPoint:(CGPoint)point
                        lineIndex:(NSInteger)lineIndex
                       pointIndex:(NSInteger)pointIndex
{
    
}

/**
 * Callback method that gets invoked when the user taps on a chart bar.
 */
- (void)userClickedOnBarAtIndex:(NSInteger)barIndex
{
    
}

@end
