//
//  SelectBankViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/28.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "SelectBankViewController.h"
#import "SelectBankCell.h"

@interface SelectBankViewController ()
@property (nonatomic, weak) IBOutlet    UITableView *tableview;
@end

@implementation SelectBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"选择银行卡"];
    [self tableView:self.tableview registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"SelectBankCell" forCellOrHeaderFootViewFlag:YES];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectBankCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.row)
    {
        case 2:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"icon-jianhang"]];
            [cell.textLabel setText:@"中国建设银行"];
            [cell.detailTextLabel setText:@"尾号4569  快捷"];
        }
            break;
            
        case 1:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"icon-zhaoshang"]];
            [cell.textLabel setText:@"招商银行"];
            [cell.detailTextLabel setText:@"尾号4569  快捷"];
        }
            break;
            
        case 0:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"icon-gongshang"]];
            [cell.textLabel setText:@"中国工商银行"];
            [cell.detailTextLabel setText:@"尾号4569  快捷"];
        }
            break;
            
        default:
            break;
    }
    // Configure the cell...
    
    return cell;
}
@end
