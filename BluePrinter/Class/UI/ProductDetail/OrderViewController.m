//
//  OrderViewController.m
//  LittleFawn
//
//  Created by klozz on 15/12/28.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell1.h"
#import "OrderCell2.h"
#import "OrderCell3.h"
#import "AssetDetailsViewController.h"

@interface OrderViewController ()
@property (nonatomic, weak) IBOutlet UITableView     *tableview;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableview.tableFooterView = [[UIView alloc] init];
    
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"OrderCell1" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"OrderCell2" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"OrderCell3" forCellOrHeaderFootViewFlag:YES];
    
    [self setRightBarButtonWithTitle:@"查看" action:@selector(reviewOrder)];
    [self setTitle:@"订单"];
}

- (void)reviewOrder
{
    AssetDetailsViewController *view = [[AssetDetailsViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
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
    return 10.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.row)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell1" forIndexPath:indexPath];
        }
            break;
            
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell2" forIndexPath:indexPath];
        }
            break;
            
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell3" forIndexPath:indexPath];
        }
            break;
            
        default:
            break;
    }
    // Configure the cell...
    
    return cell;
}
@end
