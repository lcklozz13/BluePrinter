//
//  RechargeViewController.m
//  LittleFawn
//
//  Created by klozz on 15/12/30.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeConfirmationViewController.h"
#import "RechargeCell01.h"
#import "RechargeFootView.h"

@interface RechargeViewController ()
@property (nonatomic, weak) IBOutlet    UITableView *tableview;
@property (nonatomic, weak) UITextField     *rechargeTextField;
@property (nonatomic, weak) UITextField     *nameTextField;
@property (nonatomic, weak) UITextField     *IDTextField;
@property (nonatomic, weak) UITextField     *bankCardTextField;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"RechargeFootView" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"RechargeCell01" forCellOrHeaderFootViewFlag:YES];
    [self setTitle:@"充值"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkLimitAction
{
    
}

- (void)rechargeAction
{
    if ([self.rechargeTextField.text length] == 0)
    {
        [ShareFunction showToast:NSLocalizedString(@"请输入金额", @"")];
        return;
    }
    
    if ([self.nameTextField.text length] == 0)
    {
        [ShareFunction showToast:NSLocalizedString(@"请输入银行卡绑定的姓名", @"")];
        return;
    }
    
    if ([self.IDTextField.text length] == 0)
    {
        [ShareFunction showToast:NSLocalizedString(@"请输入身份证号", @"")];
        return;
    }
    
    if ([self.bankCardTextField.text length] == 0)
    {
        [ShareFunction showToast:NSLocalizedString(@"请输入银行卡号", @"")];
        return;
    }
    
    RechargeConfirmationViewController *view = [[RechargeConfirmationViewController alloc] init];
    view.rechargeMoney = self.rechargeTextField.text;
    view.username = self.nameTextField.text;
    view.IDNumber = self.IDTextField.text;
    view.bankCardNumber = self.bankCardTextField.text;
    
    [self.navigationController pushViewController:view animated:YES];
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
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RechargeCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"RechargeCell01" forIndexPath:indexPath];
    
    switch (indexPath.row)
    {
        case 0:
        {
            [cell.titleLab setText:@"账户余额"];
            [cell.contentTextField setUserInteractionEnabled:NO];
            cell.contentTextField.text = [[NSString alloc] initWithFormat:@"%.2f", [DATA_MANAGER.userInfo.leaveMoney floatValue]];
        }
            break;
            
        case 1:
        {
            [cell.titleLab setText:@"金额"];
            [cell.contentTextField setUserInteractionEnabled:YES];
            cell.contentTextField.placeholder = @"最低充值1元";
            [cell.contentTextField setKeyboardType:UIKeyboardTypeNumberPad];
            self.rechargeTextField = cell.contentTextField;
        }
            break;
            
        case 2:
        {
            [cell.titleLab setText:@"姓名"];
            [cell.contentTextField setUserInteractionEnabled:YES];
            cell.contentTextField.placeholder = @"请输入真实姓名";
            self.nameTextField = cell.contentTextField;
        }
            break;
            
        case 3:
        {
            [cell.titleLab setText:@"身份证"];
            [cell.contentTextField setUserInteractionEnabled:YES];
            cell.contentTextField.placeholder = @"请输入身份证号码";
            self.IDTextField = cell.contentTextField;
        }
            break;
            
        case 4:
        {
            [cell.titleLab setText:@"银行卡"];
            [cell.contentTextField setUserInteractionEnabled:YES];
            [cell.contentTextField setKeyboardType:UIKeyboardTypeNumberPad];
            cell.contentTextField.placeholder = @"请输入银行卡号";
            self.bankCardTextField = cell.contentTextField;
        }
            break;
            
            
        default:
            break;
    }
    
    
    // Configure the cell...
    
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    RechargeFootView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RechargeFootView"];
    [view.checkLimitBtn addTarget:self action:@selector(checkLimitAction) forControlEvents:UIControlEventTouchUpInside];
    [view.rechargeBtn addTarget:self action:@selector(rechargeAction) forControlEvents:UIControlEventTouchUpInside];
    return view;
}
@end
