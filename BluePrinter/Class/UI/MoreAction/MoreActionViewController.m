//
//  MoreActionViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/24.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "MoreActionViewController.h"
#import "MoreLogoCell.h"
#import "MoreDetailCell.h"

@interface MoreActionViewController ()
@property (weak, nonatomic) IBOutlet    UITableView     *tableview;
@end

@implementation MoreActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"更多"];
    [self setLeftBarButtonWithImageName:@"icon-personal- information" target:[[ViewControllerManager getInstance] getSlideMenuView] action:@selector(showLeft:)];
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"MoreLogoCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"MoreDetailCell" forCellOrHeaderFootViewFlag:YES];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [MoreLogoCell cellHeight];
    }
    else
    {
        return [MoreDetailCell cellHeight];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0)
    {
        MoreLogoCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"MoreLogoCell" forIndexPath:indexPath];
        cell = cell1;
    }
    else
    {
        MoreLogoCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"MoreDetailCell" forIndexPath:indexPath];
        cell = cell1;
        
        switch (indexPath.row)
        {
            case 1:
            {
                cell1.imageView.image = [UIImage imageNamed:@"icon-transmit"];
                cell1.textLabel.text = @"转发好友";
            }
                break;
                
            case 2:
            {
                cell1.imageView.image = [UIImage imageNamed:@"icon-contact"];
                cell1.textLabel.text = @"联系我们";
            }
                break;
                
            case 3:
            {
                cell1.imageView.image = [UIImage imageNamed:@"icon-about us1"];
                cell1.textLabel.text = @"关于我们";
            }
                break;
                
            case 4:
            {
                cell1.imageView.image = [UIImage imageNamed:@"icon-suggestion"];
                cell1.textLabel.text = @"意见反馈";
            }
                break;
                
            case 5:
            {
                cell1.imageView.image = [UIImage imageNamed:@"icon-message"];
                cell1.textLabel.text = @"消息管理";
            }
                break;
                
            default:
                break;
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
