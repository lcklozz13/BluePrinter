//
//  ChangeTransactionPwdViewController.m
//  LittleFawn
//
//  Created by klozz on 16/1/8.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "ChangeTransactionPwdViewController.h"
#import "InputTextForChangeCell.h"
#import "AddBackFootView.h"

@interface ChangeTransactionPwdViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@property (weak, nonatomic) UIButton        *continueBtn;
@property (weak, nonatomic) UITextField     *oldPwdTextField;
@property (weak, nonatomic) UITextField     *newestPwdTextField;
@property (weak, nonatomic) UITextField     *renewPwdField;
@property (nonatomic,strong) NSString                   *recvVertifyCode;
@end

@implementation ChangeTransactionPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改交易密码";
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"InputTextForChangeCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AddBackFootView" forCellOrHeaderFootViewFlag:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)nextAction:(id)sender
{
    [self.view endEditing:YES];
    [ShareFunction showToast:NSLocalizedString(@"修改成功", @"")];
    [self performSelector:@selector(backAction) withObject:nil afterDelay:1];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [InputTextForChangeCell cellHeight];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    AddBackFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AddBackFootView"];
    
    [footView.saveBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView.saveBtn setTitle:@"确认" forState:UIControlStateNormal];
    self.continueBtn = footView.saveBtn;
    [self textFieldDidChanged:nil];
    
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InputTextForChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InputTextForChangeCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0)
    {
        [cell.titleLab setText:@"原密码"];
        [cell.inputTextField setPlaceholder:@"请输入原密码"];
        cell.inputTextField.delegate = self;
        self.oldPwdTextField = cell.inputTextField;
    }
    else if (indexPath.row == 1)
    {
        [cell.titleLab setText:@"新密码"];
        [cell.inputTextField setPlaceholder:@"请输入新密码"];
        cell.inputTextField.delegate = self;
        self.newestPwdTextField = cell.inputTextField;
    }
    else if (indexPath.row == 2)
    {
        [cell.titleLab setText:@"确认密码"];
        [cell.inputTextField setPlaceholder:@"请在此输入新密码"];
        cell.inputTextField.delegate = self;
        self.renewPwdField = cell.inputTextField;
    }
    
    return cell;
    
}

#pragma mark    - UITextFieldDelegate

- (void)textFieldDidChanged:(NSNotification *)notification
{
    self.continueBtn.enabled = (self.oldPwdTextField.text.length > 0 && self.newestPwdTextField.text.length > 0  && self.renewPwdField.text.length > 0);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
