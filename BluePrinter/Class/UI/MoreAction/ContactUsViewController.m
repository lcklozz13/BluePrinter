//
//  ContactUsViewController.m
//  LittleFawn
//
//  Created by baidu on 16/1/14.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "ContactUsViewController.h"
#import "ContactUsCell.h"

@interface ContactUsViewController ()
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"联系我们"];
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"ContactUsCell" forCellOrHeaderFootViewFlag:YES];
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
    return 4;
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
    
    ContactUsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactUsCell" forIndexPath:indexPath];
    
    switch (indexPath.row)
    {
        case 0:
        {
            cell.titleLab.text = @"客服热线";
            cell.contentLab.text = @"0871-6500230";
        }
            break;
            
        case 1:
        {
            cell.titleLab.text = @"客服邮箱";
            cell.contentLab.text = @"xiaolu@licai.com";
        }
            break;
            
        case 2:
        {
            cell.titleLab.text = @"微信服务号";
            cell.contentLab.text = @"xiaolulicai";
        }
            break;
            
        case 3:
        {
            cell.titleLab.text = @"微信订阅号";
            cell.contentLab.text = @"xiaolulicai";
        }
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

@end
