//
//  TransactionInquiryViewController.m
//  LittleFawn
//
//  Created by klozz on 16/1/4.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "TransactionInquiryViewController.h"
#import "TransactionInquiryDetailCell.h"
#import "TransactionInquiryRecordCell.h"

@interface TransactionInquiryViewController ()
@property (weak, nonatomic) IBOutlet UITableView    *tableview;
@property (nonatomic, strong) NSMutableArray        *recordArray;
@end

@implementation TransactionInquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"交易查询"];
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransactionInquiryDetailCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransactionInquiryRecordCell" forCellOrHeaderFootViewFlag:YES];
    
    [self initDatas];
}

- (void)initDatas
{
    _recordArray = [[NSMutableArray alloc] init];
    
    
    int hotcount = [PublicMethods getRandomNumber:5 to:10];
    
    for (int i=0; i<hotcount; i++)
    {
        FinancialProductType type = [PublicMethods getRandomNumber:0 to:2];
        [self.recordArray addObject:[FinancialProduct createFinancialProductFromFinancialProductType:type]];
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
    return self.recordArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [TransactionInquiryDetailCell cellHeight];
    }
    else
    {
        return [TransactionInquiryRecordCell cellHeight];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionInquiryDetailCell" forIndexPath:indexPath];
        //        TransactionInquiryDetailCell *cellTmp = (TransactionInquiryDetailCell *)cell;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionInquiryRecordCell" forIndexPath:indexPath];
        TransactionInquiryRecordCell *cellTmp = (TransactionInquiryRecordCell *)cell;
        FinancialProduct *product = self.recordArray[indexPath.row-1];
        [cellTmp setProduct:product];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0)
    {
        [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
        FinancialProduct *product = self.recordArray[indexPath.row-1];
    }
}
@end
