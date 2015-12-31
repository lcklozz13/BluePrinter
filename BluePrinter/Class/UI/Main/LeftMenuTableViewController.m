//
//  LeftMenuTableViewController.m
//  BluePrinter
//
//  Created by baidu on 15/10/27.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "LeftMenuTableViewController.h"
#import "SlideMenuViewController.h"
#import "BaseViewController.h"
#import "PublicMethods.h"
#import "LeftMenuHeadView.h"
#import "LeftMenuFootView.h"
#import "LeftMenuCell.h"
#import <UIImageView+WebCache.h>

@interface LeftMenuTableViewController ()

@end

@implementation LeftMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:UICOLOR_RGB(102, 97, 97, 1)];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    UINib *nib = [UINib nibWithNibName:@"LeftMenuHeadView" bundle:[NSBundle mainBundle]];
    
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"LeftMenuHeadView"];
    
    nib = [UINib nibWithNibName:@"LeftMenuFootView" bundle:[NSBundle mainBundle]];
    
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"LeftMenuFootView"];
    
    nib = [UINib nibWithNibName:@"LeftMenuCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LeftMenuCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessCallback) name:NOTIF_REQUEST_LOGIN_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutCallback) name:NOTIF_LOGOUT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoUpdateCallback) name:NOTIF_REQUEST_USER_INFO_UPDATE_SUCCESS object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userInfoUpdateCallback
{
    [self.tableView reloadData];
}


#pragma mark - Table view delagate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [LeftMenuHeadView cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [LeftMenuFootView cellHeight];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LeftMenuHeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LeftMenuHeadView"];
    if (DATA_MANAGER.isLogin) {
        view.nickname.text = DATA_MANAGER.userInfo.nickname;
        [view.assets setText:[[NSString alloc] initWithFormat:@"%.2f", [DATA_MANAGER.userInfo.leaveMoney floatValue]]];
//        [view.headVew sd_setImageWithURL:[NSURL URLWithString:DATA_MANAGER.userInfo.headPic] placeholderImage:[UIImage imageNamed:@"photoDefault"]];
    }
    else {
        view.nickname.text = @"未登陆";
        [view.assets setText:@"0.00"];
//        view.headVew.image = [UIImage imageNamed:@"photoDefault"];
    }
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    LeftMenuFootView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LeftMenuFootView"];
    
    return view;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftMenuCell" forIndexPath:indexPath];
    
    
    [self setCell:cell contentWithIndexPath:indexPath];
    // Configure the cell...
    
    return cell;
}

- (void)setCell:(LeftMenuCell *)cell contentWithIndexPath:(NSIndexPath *)path
{
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    [cell.contentView bringSubviewToFront:cell.separatorLine];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    switch (path.row)
    {
        case 0:
        {
            if (!DATA_MANAGER.isLogin)
            {
                [cell.imageView setImage:[UIImage imageNamed:@"icon-loading"]];
                [cell.textLabel setText:NSLocalizedString(@"登陆/注册", nil)];
            }
            else
            {
                [cell.imageView setImage:[UIImage imageNamed:@"icon-password1"]];
                [cell.textLabel setText:NSLocalizedString(@"密码管理", nil)];
            }
        }
            break;
            
        case 1:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"icon-night"]];
            [cell.textLabel setText:NSLocalizedString(@"夜间模式", nil)];
        }
            break;
            
        case 2:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"icon-about us"]];
            [cell.textLabel setText:NSLocalizedString(@"关于我们", nil)];
        }
            break;
            
        case 3:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"icon-invest"]];
            [cell.textLabel setText:NSLocalizedString(@"我要投资", nil)];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //显示根视图控制器
    SlideMenuViewController *viewController = (SlideMenuViewController *)[[UIApplication sharedApplication].keyWindow rootViewController];
    [viewController showRootController:YES];

//    if (!DATA_MANAGER.isLogin) {
//        //未登录 跳到登录界面
//        LoginAccController *loginView = [[LoginAccController alloc] init];
//        [(UINavigationController *)viewController.rootViewController pushViewController:loginView animated:YES];
//        return;
//    }
    
    UIViewController *vc = nil;
//    switch (indexPath.row) {
//        case 0:
//            vc = [[SelectCustomProductsViewController alloc] init];
//            break;
//        case 1:
//            vc = [[DesignerStoresViewController alloc] init];
//            break;
//        case 2:
//            vc = [[MyCreationViewController alloc] init];
//            break;
//        case 3:
//            vc = [[ShoppingCartTableViewController alloc] init];
//            break;
//        case 4:
//            vc = [[MyOrdersViewController alloc] init];
//            break;
//        case 5:
//            vc = [[SettingViewController alloc] init];
//            break;
//        case 6:
//            vc = [[HelpMainTableViewController alloc] init];
//            break;
//        default:
//            vc = nil;
//        break;
//    }
    if (vc)
        [(UINavigationController *)viewController.rootViewController pushViewController:vc animated:NO];
}


#pragma mark    - 通知

- (void)loginSuccessCallback
{
    [self.tableView reloadData];
}

- (void)logoutCallback
{
    [self.tableView reloadData];
}

@end
