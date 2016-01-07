//
//  DeleteBankCardViewController.m
//  LittleFawn
//
//  Created by klozz on 16/1/7.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "DeleteBankCardViewController.h"
#import "DeleteBankCardCell.h"
#import "AddBackFootView.h"

@interface DeleteBankCardViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@property (nonatomic, strong) NSIndexPath       *selectedIndexPath;
@property (nonatomic, assign) NSInteger         bankcardCount;
@end

@implementation DeleteBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"解绑银行卡"];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"DeleteBankCardCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AddBackFootView" forCellOrHeaderFootViewFlag:NO];
    
    self.bankcardCount = 3;
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

- (void)unbandingAction:(id)sender
{
    if (!self.selectedIndexPath)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请选择一张需要解绑定的银行卡" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定解绑该银行卡吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"解除绑定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if (self.bankcardCount > 0) {
            self.bankcardCount--;
            self.selectedIndexPath = nil;
            [self.tableview reloadData];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bankcardCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [AddBackFootView viewHeight];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DeleteBankCardCell cellHeight];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    AddBackFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AddBackFootView"];
    
    [footView.saveBtn addTarget:self action:@selector(unbandingAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView.saveBtn setTitle:@"解除绑定" forState:UIControlStateNormal];
    
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DeleteBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeleteBankCardCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0)
    {
        [cell.titleImageView setImage:[UIImage imageNamed:@"icon-jianhang1"]];
    }
    else if (indexPath.row == 1)
    {
        [cell.titleImageView setImage:[UIImage imageNamed:@"icon-zhongyin"]];
    }
    else
    {
        [cell.titleImageView setImage:[UIImage imageNamed:@"icon-gongshang1"]];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
}
@end
