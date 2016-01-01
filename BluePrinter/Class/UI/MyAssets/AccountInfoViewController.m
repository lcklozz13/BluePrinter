//
//  AccountInfoViewController.m
//  LittleFawn
//
//  Created by klozz on 16/1/2.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "OtherInforCell.h"
#import "MyAccountCell.h"

@interface AccountInfoViewController ()
@property (nonatomic, weak) IBOutlet    UITableView     *tableview;
@end

@implementation AccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"我的账户"];
    
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"MyAccountCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"OtherInforCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
    self.tableview.tableFooterView = [[UIView alloc] init];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 5;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [MyAccountCell cellHeight];
    }
    else
    {
        return [OtherInforCell cellHeight];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MyAccountCell" forIndexPath:indexPath];
        MyAccountCell *cellTmp = (MyAccountCell *)cell;
        cellTmp.accountIDLab.text = DATA_MANAGER.userInfo.accountID;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"OtherInforCell" forIndexPath:indexPath];
        
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"添加银行卡";
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"解绑银行卡";
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"修改登录密码";
        }
        else if (indexPath.row == 3)
        {
            cell.textLabel.text = @"找回交易密码";
        }
        else if (indexPath.row == 4)
        {
            cell.textLabel.text = @"修改交易密码";
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        switch (indexPath.row)
        {
            case 0:
            {
                
            }
                break;
                
            case 1:
            {
                
            }
                break;
                
            case 2:
            {
                
            }
                break;
                
            case 3:
            {
                
            }
                break;
                
            case 4:
            {
                
            }
                break;
                
            default:
                break;
        }
    }
}

@end
