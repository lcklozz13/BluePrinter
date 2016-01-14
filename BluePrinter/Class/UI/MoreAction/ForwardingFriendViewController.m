//
//  ForwardingFriendViewController.m
//  LittleFawn
//
//  Created by baidu on 16/1/14.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "ForwardingFriendViewController.h"
#import "ShareManager.h"

@interface ForwardingFriendViewController ()
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@end

@implementation ForwardingFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"转发给好友"];
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self tableView:self.tableview registionClass:[UITableViewCell class] withReuseIdentifier:@"UITableViewCell" forCellOrHeaderFootViewFlag:YES];
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
    return 3;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [PublicMethods gs_colorWithHexString:@"727171"];
    cell.textLabel.font = [UIFont systemFontOfSize:17.0f];

    switch (indexPath.row)
    {
        case 0:
        {
            cell.imageView.image = [UIImage imageNamed:@"icon-weixin"];
            cell.textLabel.text = @"微信好友";
        }
            break;
            
        case 1:
        {
            cell.imageView.image = [UIImage imageNamed:@"icon-pengyouquan"];
            cell.textLabel.text = @"微信朋友圈";
        }
            break;
            
        case 2:
        {
            cell.imageView.image = [UIImage imageNamed:@"icon-weibo"];
            cell.textLabel.text = @"新浪微博";
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
    
    switch (indexPath.row)
    {
        case 0:
        {
            [SHARE_MANAGER shareWithEditor:SSDKPlatformSubTypeWechatSession
                        otherPlatformTypes:@[@(SSDKPlatformSubTypeWechatTimeline), @(SSDKPlatformTypeSinaWeibo)]
                                     title:@""
                                   content:@"我正在使用小鹿理财，是个理想的理财平台，推荐大家试一下。http://www.xiaolulicai.com.cn/tosearch.do?page=0&world"
                                    images:nil
                                       url:@"http://www.xiaolulicai.com.cn/tosearch.do?page=0&world"
                                     block:^(BOOL success)
             {
                 
             }];
        }
            break;
            
        case 1:
        {
            [SHARE_MANAGER shareWithEditor:SSDKPlatformSubTypeWechatTimeline
                        otherPlatformTypes:@[@(SSDKPlatformSubTypeWechatSession), @(SSDKPlatformTypeSinaWeibo)]
                                     title:@""
                                   content:@"我正在使用小鹿理财，是个理想的理财平台，推荐大家试一下。http://www.xiaolulicai.com.cn/tosearch.do?page=0&world"
                                    images:nil
                                       url:@"http://www.xiaolulicai.com.cn/tosearch.do?page=0&world"
                                     block:^(BOOL success)
             {
                 
             }];
        }
            break;
            
        case 2:
        {
            [SHARE_MANAGER shareWithEditor:SSDKPlatformTypeSinaWeibo
                        otherPlatformTypes:@[@(SSDKPlatformSubTypeWechatTimeline), @(SSDKPlatformSubTypeWechatSession)]
                                     title:@""
                                   content:@"我正在使用小鹿理财，是个理想的理财平台，推荐大家试一下。http://www.xiaolulicai.com.cn/tosearch.do?page=0&world"
                                    images:nil
                                       url:@"http://www.xiaolulicai.com.cn/tosearch.do?page=0&world"
                                     block:^(BOOL success)
             {
                 
             }];
        }
            break;
            
        default:
            break;
    }
}

@end
