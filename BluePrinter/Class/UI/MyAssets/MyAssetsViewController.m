//
//  MyAssetsViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/24.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "MyAssetsViewController.h"
#import "AccountInforCell.h"
#import "AssetsInforCell.h"
#import "OtherInforCell.h"
#import "AccountInfoViewController.h"
#import "LoginOrRegisterViewController.h"

@interface MyAssetsViewController ()
@property (weak, nonatomic) IBOutlet    UITableView     *tableview;
@end

@implementation MyAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"我的资产"];
    [self setLeftBarButtonWithImageName:@"icon-personal- information" target:[[ViewControllerManager getInstance] getSlideMenuView] action:@selector(showLeft:)];
    
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AccountInforCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AssetsInforCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"OtherInforCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
    self.tableview.tableFooterView = [[UIView alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessCallback) name:NOTIF_REQUEST_LOGIN_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutCallback) name:NOTIF_LOGOUT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoUpdateCallback) name:NOTIF_REQUEST_USER_INFO_UPDATE_SUCCESS object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.parentViewController.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.navigationController.visibleViewController != self)
    {
        self.parentViewController.tabBarController.tabBar.hidden = YES;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 5;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [AccountInforCell cellHeight];
    }
    else if (indexPath.section == 1)
    {
        return [AssetsInforCell cellHeight];
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
        cell = [tableView dequeueReusableCellWithIdentifier:@"AccountInforCell" forIndexPath:indexPath];
        AccountInforCell *cellTmp =(AccountInforCell *)cell;
        
        if (!DATA_MANAGER.isLogin)
        {
            [cellTmp.headerView setImage:[UIImage imageNamed:@"icon-header1"]];
            [cellTmp.nicknameLab setText:@"请先登陆账号"];
            cellTmp.accountIDLab.text = @"";
        }
        else
        {
            [cellTmp.nicknameLab setText:[[NSString alloc] initWithFormat:@"%@，您好！", DATA_MANAGER.userInfo.nickname]];
            cellTmp.accountIDLab.text = DATA_MANAGER.userInfo.accountID;
            cellTmp.bankInforLab.text = DATA_MANAGER.userInfo.bankInfor;
        }
    }
    else if (indexPath.section == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AssetsInforCell" forIndexPath:indexPath];
        AssetsInforCell *cellTmp =(AssetsInforCell *)cell;
        
        if (!DATA_MANAGER.isLogin)
        {
            cellTmp.totalAssetLab.text = @"0.00";
            cellTmp.balanceLab.text = @"0.00";
            cellTmp.incomeLab.text = @"0.00";
        }
        else
        {
            cellTmp.totalAssetLab.text = DATA_MANAGER.userInfo.totalAsset;
            cellTmp.balanceLab.text = DATA_MANAGER.userInfo.balance;
            cellTmp.incomeLab.text = DATA_MANAGER.userInfo.income;
        }
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"OtherInforCell" forIndexPath:indexPath];
        
        if (indexPath.row == 0)
        {
            cell.imageView.image = [UIImage imageNamed:@"icon-yuebao"];
            cell.textLabel.text = @"余额宝";
        }
        else if (indexPath.row == 1)
        {
            cell.imageView.image = [UIImage imageNamed:@"icon-lczj"];
            cell.textLabel.text = @"理财资金";
        }
        else if (indexPath.row == 2)
        {
            cell.imageView.image = [UIImage imageNamed:@"icon-income"];
            cell.textLabel.text = @"收益查询";
        }
        else if (indexPath.row == 3)
        {
            cell.imageView.image = [UIImage imageNamed:@"icon-trade"];
            cell.textLabel.text = @"交易查询";
        }
        else if (indexPath.row == 4)
        {
            cell.imageView.image = [UIImage imageNamed:@"icon-acccount"];
            cell.textLabel.text = @"我的账户";
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (!DATA_MANAGER.isLogin) {
            //未登录 跳到登录界面
            LoginOrRegisterViewController *view = [[LoginOrRegisterViewController alloc] init];
            
            [[ViewControllerManager getInstance] setLoginSuccessBackViewController:self];
            [self.navigationController pushViewController:view animated:YES];
            
            return;
        }
        
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
                AccountInfoViewController *view = [[AccountInfoViewController alloc] init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark    - 通知

- (void)loginSuccessCallback
{
    [self.tableview reloadData];
}

- (void)logoutCallback
{
    [self.tableview reloadData];
}

- (void)userInfoUpdateCallback
{
    [self.tableview reloadData];
}
@end
