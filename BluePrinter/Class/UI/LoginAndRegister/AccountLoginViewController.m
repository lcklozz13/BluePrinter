//
//  AccountLoginViewController.m
//  BluePrinter
//
//  Created by klozz on 15/12/23.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "AccountLoginViewController.h"
#import "RegisterAccountViewController.h"
#import "ResetPwdViewController.h"
#import "TextInputCell.h"
#import "LoginFootView.h"
#import "LeftMenuTableViewController.h"

@interface AccountLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet    UITableView     *tableView;
@property (nonatomic, weak) UITextField                 *username;
@property (nonatomic, weak) UITextField                 *pwd;

@end

@implementation AccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"登陆"];
    [self setRightBarButtonWithTitle:@"注册" action:@selector(registerAccountAction:)];
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"TextInputCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableView registionReuseIdentifierWithNibName:@"LoginFootView" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableView registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
    [self.view setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    self.username.text = [DATA_MANAGER getLoginAccount];
}

- (void)registerAccountAction:(id)sender
{
    RegisterAccountViewController *view = [[RegisterAccountViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)resetPwdAction
{
    ResetPwdViewController *view = [[ResetPwdViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)loginAction
{
    if (self.username.text.length == 0) {
        [ShareFunction showToast:NSLocalizedString(@"请输入登录账号", @"")];
        return;
    }
    if (self.pwd.text.length == 0) {
        [ShareFunction showToast:NSLocalizedString(@"请输入登录密码", @"")];
        return;
    }
    
    [self.view endEditing:YES];
    //MARK:login test
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://qznl.qz-software.com/auth/login"]];
    [request setHTTPMethod:@"POST"];

    NSString *postString = [[NSString alloc] initWithFormat:@"uname=%@&pwd=%@&captcha=", self.username.text, self.pwd.text];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", string);
    }];
    
//    [NET_DATA_MANAGER requestLoginWithAccount:self.username.text password:self.pwd.text completion:^(NetResponse *response) {
//        
//    }];
    
    //TODO:获取到账户信息
    DATA_MANAGER.isLogin = YES;
    DATA_MANAGER.userInfo = [[UserInfo alloc] init];
    DATA_MANAGER.userInfo.nickname = self.username.text;
    DATA_MANAGER.userInfo.leaveMoney = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:1000 to:1000000]];
    DATA_MANAGER.userInfo.accountID = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:10000000 to:100000000]];
    DATA_MANAGER.userInfo.bankInfor = @"云南建行分行";
    DATA_MANAGER.userInfo.totalAsset = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:10000 to:1000000]];
    DATA_MANAGER.userInfo.balance = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:10000 to:1000000]];
    DATA_MANAGER.userInfo.income = [[NSString alloc] initWithFormat:@"%d", [PublicMethods getRandomNumber:10000 to:1000000]];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_REQUEST_LOGIN_SUCCESS object:nil];
    
    if ([[[ViewControllerManager getInstance] loginSuccessBackViewController] isKindOfClass:[LeftMenuTableViewController class]])
    {
        [self.parentViewController dismissViewControllerAnimated:YES completion:^{
            [[ViewControllerManager getInstance] setLoginSuccessBackViewController:nil];
        }];
    }
    else
    {
        //TODO:前往购买界面
        [self.navigationController popToViewController:[[ViewControllerManager getInstance] loginSuccessBackViewController] animated:YES];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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
//            [cell.inputTextField setKeyboardType:UIKeyboardTypePhonePad];
            cell.inputTextField.delegate = self;
        }
            break;
            
        case 1:
        {
            [cell.inputTextField setLeftViewMode:UITextFieldViewModeAlways];
            UIImage *leftImage = [UIImage imageNamed:@"icon-password"];
            UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, leftImage.size.width+30, leftImage.size.height)];
            leftView.contentMode = UIViewContentModeScaleAspectFit;
            [leftView setImage:leftImage];
            [cell.inputTextField setLeftView:leftView];
            self.pwd = cell.inputTextField;
            [cell.inputTextField setSecureTextEntry:YES];
            [cell.inputTextField setPlaceholder:@"请输入登陆密码"];
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
    LoginFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LoginFootView"];
    
    footView.loginBtn.clipsToBounds = YES;
    footView.loginBtn.layer.borderColor = [UIColor clearColor].CGColor;
    footView.loginBtn.layer.borderWidth = 1.0f;
    footView.loginBtn.layer.cornerRadius = 5.0f;
    [footView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footView.forgetPwdBtn addTarget:self action:@selector(resetPwdAction) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [LoginFootView viewHegiht];
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
