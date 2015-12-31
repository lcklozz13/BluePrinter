//
//  AssetDetailsViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/29.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "AssetDetailsViewController.h"
#import "AssetDetailCell00.h"
#import "AssetDetailCell01.h"
#import "AssetDetailCell10.h"
#import "AssetDetailCell11.h"
#import "AssetDetailCell20.h"
#import "AssetDetailCell30.h"
#import "AssetDetailsHeadView.h"
#import "BecomeCashViewController.h"


@interface AssetDetailsViewController ()
@property (nonatomic, weak) IBOutlet    UITableView     *tableview;
- (IBAction)becomeCashAction:(id)sender;
@end

@implementation AssetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"资产详情"];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AssetDetailsHeadView" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableview registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
    
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AssetDetailCell00" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AssetDetailCell01" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AssetDetailCell10" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AssetDetailCell11" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AssetDetailCell20" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"AssetDetailCell30" forCellOrHeaderFootViewFlag:YES];
    [self.tableview setTableFooterView:[[UIView alloc] init]];
}

- (void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)becomeCashAction:(id)sender
{
    BecomeCashViewController *view = [[BecomeCashViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view delagate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
             return [AssetDetailsHeadView viewHeight];
        }
            break;
            
        case 1:
        {
            return 10;
        }
            break;
            
        case 2:
        {
            return 10;
        }
            break;
            
        case 3:
        {
            return 10;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            AssetDetailsHeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AssetDetailsHeadView"];
            
            return view;
        }
            break;
            
        case 1:
        {
            UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
            [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
            
            return view;
        }
            break;
            
        case 2:
        {
            UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
            [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
            
            return view;
        }
            break;
            
        case 3:
        {
            UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
            [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
            
            return view;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 2;
        }
            break;
            
        case 1:
        {
            return 2;
        }
            break;
            
        case 2:
        {
            return 1;
        }
            break;
            
        case 3:
        {
            return 1;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                return [AssetDetailCell00 cellHeight];
            }
                break;
                
            case 1:
            {
                return [AssetDetailCell01 cellHeight];
            }
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                return [AssetDetailCell10 cellHeight];
            }
                break;
                
            case 1:
            {
                return [AssetDetailCell11 cellHeight];
            }
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 2)
    {
        return [AssetDetailCell20 cellHeight];
    }
    else if (indexPath.section == 3)
    {
        return [AssetDetailCell30 cellHeight];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"AssetDetailCell00" forIndexPath:indexPath];
            }
                break;
                
            case 1:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"AssetDetailCell01" forIndexPath:indexPath];
            }
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"AssetDetailCell10" forIndexPath:indexPath];
            }
                break;
                
            case 1:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"AssetDetailCell11" forIndexPath:indexPath];
            }
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AssetDetailCell20" forIndexPath:indexPath];
    }
    else if (indexPath.section == 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AssetDetailCell30" forIndexPath:indexPath];
    }
    // Configure the cell...
    
    return cell;
}

@end
