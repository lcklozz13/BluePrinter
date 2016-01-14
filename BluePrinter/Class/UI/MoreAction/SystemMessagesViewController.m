//
//  SystemMessagesViewController.m
//  LittleFawn
//
//  Created by baidu on 16/1/14.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "SystemMessagesViewController.h"
#import "MessagesDetailViewController.h"

@interface SystemMessagesViewController ()
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@end

@implementation SystemMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"系统消息"];
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
    cell.textLabel.text = @"您获得了一张理财金";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessagesDetailViewController *vc = [[MessagesDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
