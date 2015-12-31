//
//  RegisterAccountViewController.m
//  BluePrinter
//
//  Created by klozz on 15/12/23.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "RegisterAccountViewController.h"
#import "TextInputCell.h"
#import "RegisterFootView.h"
#import "RegisterProtocolViewController.h"
#import "AccountLoginViewController.h"

@interface RegisterAccountViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet    UITableView     *tableView;
@property (nonatomic, weak) UITextField                 *username;
@property (nonatomic, weak) UITextField                 *pwd;
@property (nonatomic, weak) UITextField                 *vertifyCode;
@property (nonatomic, strong) NSString                  *recvVertifyCode;
@end

@implementation RegisterAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"注册"];
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"TextInputCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"RegisterFootView" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableView registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
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

- (void)getVertifyCode
{
    self.recvVertifyCode = @"1234";
    [ShareFunction showToast:NSLocalizedString(@"验证码已发送到您的手机", nil)];
}

- (void)argeenAction
{
    RegisterProtocolViewController *view = [[RegisterProtocolViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)registerAction
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
    
    //TODO:注册成功进入购买界面
    
    DATA_MANAGER.isLogin = YES;
    DATA_MANAGER.userInfo.nickname = self.username.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_REQUEST_LOGIN_SUCCESS object:nil];
    //TODO:前往购买界面
    [self.navigationController popToViewController:[[ViewControllerManager getInstance] loginSuccessBackViewController] animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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
            [cell.inputTextField setPlaceholder:@"请设置6-18位字符串密码"];
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
    RegisterFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RegisterFootView"];
    
    footView.registerBtn.clipsToBounds = YES;
    footView.registerBtn.layer.borderColor = [UIColor clearColor].CGColor;
    footView.registerBtn.layer.borderWidth = 1.0f;
    footView.registerBtn.layer.cornerRadius = 5.0f;
    [footView.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footView.argeenBtn addTarget:self action:@selector(argeenAction) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [RegisterFootView viewHegiht];
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
