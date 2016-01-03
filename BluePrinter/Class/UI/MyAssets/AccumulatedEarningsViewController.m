//
//  AccumulatedEarningsViewController.m
//  LittleFawn
//
//  Created by klozz on 16/1/3.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "AccumulatedEarningsViewController.h"
#import "AccumulatedEarningsTitleCell.h"
#import "AccumulatedEarningsDetailCell.h"

@interface AccumulatedEarningsViewController ()
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@property (nonatomic, strong) NSMutableArray    *accumulatedEarningsArray;
@end

@implementation AccumulatedEarningsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"累计收益"];
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AccumulatedEarningsTitleCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AccumulatedEarningsDetailCell" forCellOrHeaderFootViewFlag:YES];
    [self initDatas];
}

- (void)initDatas
{
    _accumulatedEarningsArray = [[NSMutableArray alloc] init];
    
    
    int hotcount = [PublicMethods getRandomNumber:5 to:10];
    
    for (int i=0; i<hotcount; i++)
    {
        FinancialProductType type = [PublicMethods getRandomNumber:0 to:2];
        [self.accumulatedEarningsArray addObject:[FinancialProduct createFinancialProductFromFinancialProductType:type]];
    }
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.accumulatedEarningsArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [AccumulatedEarningsTitleCell cellHeight];
    }
    else
    {
        return [AccumulatedEarningsDetailCell cellHeight];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AccumulatedEarningsTitleCell" forIndexPath:indexPath];
//        AccumulatedEarningsTitleCell *cellTmp = (AccumulatedEarningsTitleCell *)cell;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AccumulatedEarningsDetailCell" forIndexPath:indexPath];
        AccumulatedEarningsDetailCell *cellTmp = (AccumulatedEarningsDetailCell *)cell;
        FinancialProduct *product = self.accumulatedEarningsArray[indexPath.row-1];
        [cellTmp setProduct:product];
    }
    
    return cell;
    
}

@end
