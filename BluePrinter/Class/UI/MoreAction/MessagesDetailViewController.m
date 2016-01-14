//
//  MessagesDetailViewController.m
//  LittleFawn
//
//  Created by baidu on 16/1/14.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "MessagesDetailViewController.h"
#import "MessagesDetailCell1.h"
#import "MessagesDetailCell2.h"

@interface MessagesDetailViewController ()
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@end

@implementation MessagesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"消息详情";
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"MessagesDetailCell1" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"MessagesDetailCell2" forCellOrHeaderFootViewFlag:YES];
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
    return 2;
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
    switch (indexPath.row)
    {
        case 0:
        {
            return [MessagesDetailCell1 cellHeight];
        }
            break;
            
        case 1:
        {
            return [MessagesDetailCell2 cellHeight];
        }
            break;
            
        default:
            break;
    }
    
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;

    switch (indexPath.row)
    {
        case 0:
        {
            MessagesDetailCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"MessagesDetailCell1" forIndexPath:indexPath];
            cell = cell1;
        }
            break;
            
        case 1:
        {
            MessagesDetailCell2 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"MessagesDetailCell2" forIndexPath:indexPath];
            cell = cell1;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

@end
