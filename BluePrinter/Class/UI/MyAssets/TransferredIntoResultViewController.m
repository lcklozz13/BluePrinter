//
//  TransferredIntoResultViewController.m
//  LittleFawn
//
//  Created by baidu on 16/1/11.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "TransferredIntoResultViewController.h"
#import "BalanceBoxViewController.h"
#import "TransferredIntoResultCell.h"

@interface TransferredIntoResultViewController ()
@property (nonatomic, weak) IBOutlet  UITableView *tableview;
@property (assign, nonatomic) ViewType  curType;
@property (nonatomic, strong) NSString      *curMoney;
@end

@implementation TransferredIntoResultViewController

- (id)initWithViewType:(ViewType)type money:(NSString *)money
{
    self = [super init];
    
    if (self)
    {
        self.curType = type;
        self.curMoney = money;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"结果详情";
    
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransferredIntoResultCell" forCellOrHeaderFootViewFlag:YES];
    self.tableview.tableFooterView = [[UIView alloc] init];
}

- (void)backAction
{
    NSArray *vcs = self.navigationController.viewControllers;
    UIViewController *backVc = nil;
    
    for (UIViewController *vc in vcs)
    {
        if ([vc isKindOfClass:[BalanceBoxViewController class]])
        {
            backVc = vc;
            break;
        }
    }
    
    if (backVc)
    {
        [self.navigationController popToViewController:backVc animated:YES];
    }
    else
    {
        [super backAction];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TransferredIntoResultCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransferredIntoResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransferredIntoResultCell" forIndexPath:indexPath];
    
    if (self.curType == ViewTyp_turnInto)
    {
        cell.titleLab.text = @"成功转入";
        cell.contentLab.text = [[NSString alloc] initWithFormat:@"成功转入%@至余额宝", self.curMoney];
    }
    else
    {
        cell.titleLab.text = @"成功转出";
        cell.contentLab.text = [[NSString alloc] initWithFormat:@"成功转出%@至余额宝", self.curMoney];
    }
    
    return cell;
    
}

@end
