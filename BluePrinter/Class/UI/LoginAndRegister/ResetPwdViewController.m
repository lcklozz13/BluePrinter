//
//  ResetPwdViewController.m
//  BluePrinter
//
//  Created by klozz on 15/12/23.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "TextInputCell.h"
#import "ResetPwdFootView.h"
#import "AccountLoginViewController.h"

@interface ResetPwdViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet    UITableView     *tableView;
@property (nonatomic, weak) UITextField                 *username;
@property (nonatomic, weak) UITextField                 *pwd;
@property (nonatomic, weak) UITextField                 *pwd1;
@property (nonatomic, weak) UITextField                 *vertifyCode;
@property (nonatomic,strong) NSString                   *recvVertifyCode;
@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"忘记登陆密码"];
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"TextInputCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"ResetPwdFootView" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableView registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)compeletionAction
{
    NSString *phone = self.username.text;
    if (![ShareFunction checkPhoneNumInput:phone]) {
        [ShareFunction showToast:NSLocalizedString(@"请输入正确的手机号码", nil)];
        return;
    }
    
    NSString *code = self.vertifyCode.text;
    if (![code isEqualToString:self.recvVertifyCode]) {
        [ShareFunction showToast:NSLocalizedString(@"输入的验证码不正确", nil)];
        return;
    }
    
    NSString *password = self.pwd.text;
    if (password.length < 8 || password.length > 32) {
        [ShareFunction showToast:NSLocalizedString(@"请输入8-32位字母数字组合", nil)];
        return;
    }
    
    if (![password isEqualToString:self.pwd1.text]) {
        [ShareFunction showToast:NSLocalizedString(@"两次输入的密码不一致", nil)];
        return;
    }
    
    //TODO:重置成功进入登陆界面
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    UIViewController *loginViewController = nil;
    
    for (UIViewController *controll in viewControllers)
    {
        if ([controll isKindOfClass:[AccountLoginViewController class]])
        {
            loginViewController = controll;
            
            break;
        }
    }
    
    if (loginViewController)
    {
        [self.navigationController popToViewController:loginViewController animated:YES];
    }
}

- (void)getVertifyCode
{
    self.recvVertifyCode = @"1234";
    [ShareFunction showToast:NSLocalizedString(@"验证码已发送到您的手机", nil)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextInputCell" forIndexPath:indexPath];
    
    switch (indexPath.row)
    {
        case 0:
        {
            [cell.inputTextField setLeftViewMode:UITextFieldViewModeAlways];
            UIImage *leftImage = [UIImage imageNamed:@"icon-person"];
            UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, leftImage.size.width+30, leftImage.size.height)];
            leftView.contentMode = UIViewContentModeScaleAspectFit;
            [leftView setImage:leftImage];
            [cell.inputTextField setLeftView:leftView];
            self.username = cell.inputTextField;
            [cell.inputTextField setPlaceholder:@"请输入手机号"];
            [cell.inputTextField setKeyboardType:UIKeyboardTypePhonePad];
            cell.inputTextField.delegate = self;
        }
            break;
            
        case 1:
        {
            [cell.inputTextField setLeftViewMode:UITextFieldViewModeAlways];
            UIImage *leftImage = [UIImage imageNamed:@"icon-code"];
            UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, leftImage.size.width+30, leftImage.size.height)];
            leftView.contentMode = UIViewContentModeScaleAspectFit;
            [leftView setImage:leftImage];
            [cell.inputTextField setLeftView:leftView];
            self.vertifyCode = cell.inputTextField;
            [cell.inputTextField setPlaceholder:@"请输入验证码"];
            cell.inputTextField.delegate = self;
            
            
            [cell.inputTextField setRightViewMode:UITextFieldViewModeAlways];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
            [button setBackgroundColor:[PublicMethods gs_colorWithHexString:@"#dcdddd"]];
            [button setTitle:@"获取" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(getVertifyCode) forControlEvents:UIControlEventTouchUpInside];
            [cell.inputTextField setRightView:button];
        }
            break;
            
        case 2:
        {
            [cell.inputTextField setLeftViewMode:UITextFieldViewModeAlways];
            UIImage *leftImage = [UIImage imageNamed:@"icon-password"];
            UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, leftImage.size.width+30, leftImage.size.height)];
            leftView.contentMode = UIViewContentModeScaleAspectFit;
            [leftView setImage:leftImage];
            [cell.inputTextField setLeftView:leftView];
            self.pwd = cell.inputTextField;
            [cell.inputTextField setPlaceholder:@"请输入新密码"];
            [cell.inputTextField setSecureTextEntry:YES];
            cell.inputTextField.delegate = self;
        }
            break;
            
        case 3:
        {
            [cell.inputTextField setLeftViewMode:UITextFieldViewModeAlways];
            UIImage *leftImage = [UIImage imageNamed:@"icon-password"];
            UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, leftImage.size.width+30, leftImage.size.height)];
            leftView.contentMode = UIViewContentModeScaleAspectFit;
            [leftView setImage:leftImage];
            [cell.inputTextField setLeftView:leftView];
            self.pwd1 = cell.inputTextField;
            [cell.inputTextField setPlaceholder:@"请再次输入新密码"];
            [cell.inputTextField setSecureTextEntry:YES];
            cell.inputTextField.delegate = self;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    ResetPwdFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ResetPwdFootView"];
    
    footView.compeletionBtn.clipsToBounds = YES;
    footView.compeletionBtn.layer.borderColor = [UIColor clearColor].CGColor;
    footView.compeletionBtn.layer.borderWidth = 1.0f;
    footView.compeletionBtn.layer.cornerRadius = 5.0f;
    [footView.compeletionBtn addTarget:self action:@selector(compeletionAction) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [ResetPwdFootView viewHegiht];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}
@end
