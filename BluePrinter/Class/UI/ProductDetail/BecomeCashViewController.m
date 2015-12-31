//
//  BecomeCashViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/29.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "BecomeCashViewController.h"
#import "BecomeCashCell.h"
#import "RealizableRecordCell.h"
#import "BecomeCashDetailViewController.h"
#import "CashDetailViewController.h"

typedef NS_ENUM(NSInteger, CashModel)
{
    CashModel_CanBecome,
    CashModel_BecomeRecord
};

@interface BecomeCashViewController ()
@property (weak, nonatomic) IBOutlet    UISegmentedControl      *segmented;
@property (weak, nonatomic) IBOutlet    UITableView             *tableview;
@property (nonatomic, assign) CashModel     curModel;
- (IBAction)changeModel:(id)sender;
@end

@implementation BecomeCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"BecomeCashCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"RealizableRecordCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
    [self setTitle:@"变现"];
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.curModel = CashModel_CanBecome;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [PublicMethods gs_colorWithHexString:@"FA5156"], NSForegroundColorAttributeName,
                         [UIFont systemFontOfSize:17.0f], NSFontAttributeName, nil];
    [self.segmented setTitleTextAttributes:dic forState:UIControlStateSelected];
    dic = [NSDictionary dictionaryWithObjectsAndKeys:
           [PublicMethods gs_colorWithHexString:@"767676"], NSForegroundColorAttributeName,
           [UIFont systemFontOfSize:17.0f], NSFontAttributeName, nil];
    [self.segmented setTitleTextAttributes:dic forState:UIControlStateNormal];
    [self.segmented setTintColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeModel:(id)sender
{
    self.curModel = self.segmented.selectedSegmentIndex;
    [self.tableview reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.curModel == CashModel_BecomeRecord)
    {
        return 7;
    }
    else
    {
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.curModel == CashModel_BecomeRecord)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RealizableRecordCell" forIndexPath:indexPath];
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BecomeCashCell" forIndexPath:indexPath];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.curModel == CashModel_BecomeRecord)
    {
        CashDetailViewController *view = [[CashDetailViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }
    else
    {
        BecomeCashDetailViewController *view = [[BecomeCashDetailViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }
}

@end
