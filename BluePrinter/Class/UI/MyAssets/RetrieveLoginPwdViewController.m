//
//  RetrieveLoginPwdViewController.m
//  LittleFawn
//
//  Created by klozz on 16/1/8.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "RetrieveLoginPwdViewController.h"
#import "InputTextForChangeCell.h"
#import "AddBackFootView.h"

@interface RetrieveLoginPwdViewController ()<UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@property (weak, nonatomic) UIButton        *continueBtn;
@property (weak, nonatomic) UITextField     *phoneTextField;
@property (weak, nonatomic) UITextField     *vertifyTextField;
@property (weak, nonatomic) UITextField     *IDTextField;
@property (nonatomic,strong) NSString                   *recvVertifyCode;
@end

@implementation RetrieveLoginPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"找回交易密码";
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"InputTextForChangeCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AddBackFootView" forCellOrHeaderFootViewFlag:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)getVertifyCode
{
    self.recvVertifyCode = @"1234";
    [ShareFunction showToast:NSLocalizedString(@"验证码已发送到您的手机", nil)];
}

- (void)nextAction:(id)sender
{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的交易密码是:12345" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
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
        [cell.titleLab setText:@"手机"];
        [cell.inputTextField setPlaceholder:@"请输入预留手机号"];
        cell.inputTextField.delegate = self;
        self.phoneTextField = cell.inputTextField;
    }
    else if (indexPath.row == 1)
    {
        [cell.titleLab setText:@"验证码"];
        [cell.inputTextField setPlaceholder:@"请输入验证码"];
        cell.inputTextField.delegate = self;
        self.vertifyTextField = cell.inputTextField;
        [cell.inputTextField setRightViewMode:UITextFieldViewModeAlways];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 51)];
        [button setBackgroundColor:[PublicMethods gs_colorWithHexString:@"#dcdddd"]];
        [button setTitle:@"获取" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(getVertifyCode) forControlEvents:UIControlEventTouchUpInside];
        [cell.inputTextField setRightView:button];
    }
    else if (indexPath.row == 2)
    {
        [cell.titleLab setText:@"身份证号"];
        [cell.inputTextField setPlaceholder:@"请输入身份证号"];
        cell.inputTextField.delegate = self;
        self.IDTextField = cell.inputTextField;
    }
    
    return cell;
    
}

#pragma mark    - UITextFieldDelegate

- (void)textFieldDidChanged:(NSNotification *)notification
{
    self.continueBtn.enabled = (self.phoneTextField.text.length > 0 && self.vertifyTextField.text.length > 0  && self.IDTextField.text.length > 0);
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
