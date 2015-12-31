//
//  RechargeConfirmationViewController.m
//  LittleFawn
//
//  Created by klozz on 15/12/30.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "RechargeConfirmationViewController.h"
#import "RechargeCell01.h"
#import "RechargeConfirmationFooter1.h"
#import "RechargeConfirmationFooter2.h"
#import "RechargeConfirmationHeader.h"
#import "RechargeConfirmCell.h"
#import "PurchaseViewController.h"

@interface RechargeConfirmationViewController ()<UITextFieldDelegate, UIAlertViewDelegate>
@property (nonatomic, weak) IBOutlet    UITableView *tableview;
@property (nonatomic, weak) UITextField *phoneNumber;
@property (nonatomic, weak) UITextField *vertifyCode;
@property (nonatomic, weak) UITextField *becomeEditTextField;
@property (nonatomic, assign) BOOL  isKeyboardShowed;
@end

@implementation RechargeConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"充值信息确认"];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"RechargeCell01" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"RechargeConfirmCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"RechargeConfirmationFooter1" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"RechargeConfirmationFooter2" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"RechargeConfirmationHeader" forCellOrHeaderFootViewFlag:NO];
    self.isKeyboardShowed = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark keyboad show or hide notification
//键盘弹出事件
- (void)keyboardWasShown:(NSNotification *)notif
{
    if (self.isKeyboardShowed)
    {
        return;
    }
    
    self.isKeyboardShowed = YES;
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    CGRect r = self.tableview.frame;
    r.size.height -= keyboardSize.height;
    [self.tableview setFrame:r];
    CGPoint point = [self.becomeEditTextField.superview convertPoint:self.becomeEditTextField.frame.origin toView:self.tableview];
    point.x = 0;
    
    if (point.y + r.size.height > self.tableview.contentSize.height)
    {
        point.y = self.tableview.contentSize.height - r.size.height;
    }
    
    [self.tableview setContentOffset:point animated:NO];
}

//键盘隐藏消息
- (void)keyboardWasHide:(NSNotification *)notif
{
    self.isKeyboardShowed = NO;
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    CGRect r = self.tableview.frame;
    r.size.height += keyboardSize.height;
    [self.tableview setFrame:r];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getVertifyCode
{
    
}

- (void)vertifyAction:(id)sender
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"恭喜你，充值成功！" message:@"你现在可以去支付订单" delegate:self cancelButtonTitle:@"去支付" otherButtonTitles:nil, nil];
    alertview.tag = 10010;
    [alertview show];
    DATA_MANAGER.userInfo.leaveMoney = [[NSString alloc] initWithFormat:@"%.2f", [DATA_MANAGER.userInfo.leaveMoney floatValue]+[self.rechargeMoney floatValue]];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_REQUEST_LOGIN_SUCCESS object:nil];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10010)
    {
        PurchaseViewController *assetDetailHandle = nil;
        NSArray *controllers = [self.navigationController viewControllers];
        
        for (id viewcontroll in controllers)
        {
            if ([viewcontroll isKindOfClass:[PurchaseViewController class]])
            {
                assetDetailHandle = viewcontroll;
                break;
            }
        }
        
        [self.navigationController popToViewController:assetDetailHandle animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return [RechargeConfirmationHeader viewHeight];
    }
    else
    {
        return 1.0f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RechargeCell01 cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 1;
        }
            break;
            
        case 1:
        {
            return [RechargeConfirmationFooter1 viewHeight];
        }
            break;
            
        case 2:
        {
            return [RechargeConfirmationFooter2 viewHeight];
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        RechargeConfirmationHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RechargeConfirmationHeader"];
        
        return view;
    }
    else
    {
        return nil;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return nil;
        }
            break;
            
        case 1:
        {
            RechargeConfirmationFooter1 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RechargeConfirmationFooter1"];
            
            return view;
        }
            break;
            
        case 2:
        {
            RechargeConfirmationFooter2 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RechargeConfirmationFooter2"];
            
            return view;
        }
            
        default:
            break;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 1;
        }
            break;
            
        case 1:
        {
            return 1;
        }
            break;
            
        case 2:
        {
            return 4;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeCell01" forIndexPath:indexPath];
            RechargeCell01 *cell1 = (RechargeCell01 *)cell;

            [cell1.titleLab setText:@"小鹿充值"];
            [cell1.contentTextField setUserInteractionEnabled:NO];
            cell1.contentTextField.text = [[NSString alloc] initWithFormat:@"%.2f元", [self.rechargeMoney floatValue]];
            [cell1.contentTextField setFont:[UIFont systemFontOfSize:27.0f]];
            [cell1.contentTextField setTextColor:[PublicMethods gs_colorWithHexString:@"727171"]];
        }
            break;
            
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeCell01" forIndexPath:indexPath];
            RechargeCell01 *cell1 = (RechargeCell01 *)cell;

            [cell1.titleLab setText:@"卡号"];
            [cell1.contentTextField setUserInteractionEnabled:NO];
            cell1.contentTextField.text = self.bankCardNumber;
            [cell1.contentTextField setFont:[UIFont systemFontOfSize:17.0f]];
            [cell1.contentTextField setTextColor:[PublicMethods gs_colorWithHexString:@"727171"]];
        }
            break;
            
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeConfirmCell" forIndexPath:indexPath];
            RechargeConfirmCell *cell1 = (RechargeConfirmCell *)cell;
            
            switch (indexPath.row)
            {
                case 0:
                {
                    [cell1.titleLab setText:@"姓名"];
                    [cell1.contentTextField setUserInteractionEnabled:NO];
                    cell1.contentTextField.text = self.username;
                    [cell1.contentTextField setFont:[UIFont systemFontOfSize:17.0f]];
                    [cell1.contentTextField setTextColor:[PublicMethods gs_colorWithHexString:@"727171"]];
                }
                    break;
                    
                case 1:
                {
                    [cell1.titleLab setText:@"身份证"];
                    [cell1.contentTextField setUserInteractionEnabled:NO];
                    cell1.contentTextField.text = self.IDNumber;
                    [cell1.contentTextField setFont:[UIFont systemFontOfSize:17.0f]];
                    [cell1.contentTextField setTextColor:[PublicMethods gs_colorWithHexString:@"727171"]];
                }
                    break;
                    
                case 2:
                {
                    [cell1.titleLab setText:@"手机号"];
                    [cell1.contentTextField setUserInteractionEnabled:YES];
                    [cell1.contentTextField setFont:[UIFont systemFontOfSize:17.0f]];
                    [cell1.contentTextField setTextColor:[PublicMethods gs_colorWithHexString:@"727171"]];
                    [cell1.contentTextField setKeyboardType:UIKeyboardTypePhonePad];
                    self.phoneNumber = cell1.contentTextField;
                    cell1.contentTextField.delegate = self;
                    cell1.contentTextField.placeholder = @"请输入银行预留手机号";
                }
                    break;
                    
                case 3:
                {
                    [cell1.titleLab setText:@"验证码"];
                    [cell1.contentTextField setUserInteractionEnabled:YES];
                    [cell1.contentTextField setFont:[UIFont systemFontOfSize:17.0f]];
                    [cell1.contentTextField setTextColor:[PublicMethods gs_colorWithHexString:@"727171"]];
                    
                    [cell1.contentTextField setRightViewMode:UITextFieldViewModeAlways];
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 49)];
                    [button setBackgroundColor:[PublicMethods gs_colorWithHexString:@"#dcdddd"]];
                    [button setTitle:@"获取" forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(getVertifyCode) forControlEvents:UIControlEventTouchUpInside];
                    [cell1.contentTextField setRightView:button];
                    self.vertifyCode = cell1.contentTextField;
                    cell1.contentTextField.delegate = self;
                    cell1.contentTextField.placeholder = @"请输入短信验证码";
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    
    // Configure the cell...
    
    return cell;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.becomeEditTextField = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.vertifyCode)
    {
        //TODO:提交，校验交易
        [self.view endEditing:YES];
        [self performSelector:@selector(vertifyAction:) withObject:nil afterDelay:0.25];
        
        return YES;
    }
    
    return NO;
}
@end
