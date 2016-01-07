//
//  AddBankViewController.m
//  LittleFawn
//
//  Created by klozz on 16/1/7.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "AddBankViewController.h"
#import "AddBackFootView.h"
#import "AddBankCardCell.h"

@interface AddBankViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITableView    *tableview;
@property (nonatomic, weak) UITextField             *usernameTextField;
@property (nonatomic, weak) UITextField             *IDCardTextField;
@property (nonatomic, weak) UITextField             *bankCardTextField;
@end

@implementation AddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"添加银行卡"];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AddBankCardCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AddBackFootView" forCellOrHeaderFootViewFlag:NO];
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

- (void)saveAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

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
    return [AddBackFootView viewHeight];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    AddBackFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AddBackFootView"];
    
    [footView.saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AddBankCardCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddBankCardCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0)
    {
        [cell.titleLab setText:@"持卡人"];
        [cell.inputTextFiled setPlaceholder:@"请输入持卡人姓名"];
        [cell.inputTextFiled setDelegate:self];
        self.usernameTextField = cell.inputTextFiled;
        
        if (!cell.accessoryView)
        {
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-tips"]];
        }
    }
    else if (indexPath.row == 1)
    {
        [cell.titleLab setText:@"身份证"];
        [cell.inputTextFiled setPlaceholder:@"请输入持卡人身份证号"];
        [cell.inputTextFiled setDelegate:self];
        self.IDCardTextField = cell.inputTextFiled;
        
        if (cell.accessoryView)
        {
            cell.accessoryView = nil;
        }
    }
    else
    {
        [cell.titleLab setText:@"银行卡"];
        [cell.inputTextFiled setPlaceholder:@"请输入银行卡号码"];
        [cell.inputTextFiled setDelegate:self];
        self.bankCardTextField = cell.inputTextFiled;
        
        if (cell.accessoryView)
        {
            cell.accessoryView = nil;
        }
    }
    
    return cell;
    
}

@end
