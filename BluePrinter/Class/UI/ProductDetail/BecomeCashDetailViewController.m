//
//  BecomeCashDetailViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/30.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "BecomeCashDetailViewController.h"
#import "BecomeCashDetailCell00.h"
#import "BecomeCashDetailCell10.h"
#import "BecomeCashDetailCell11.h"
#import "BecomeCashDetailFootView.h"
#import "AssetDetailsViewController.h"
#import "TransactionDetailViewController.h"

@interface BecomeCashDetailViewController ()
@property (nonatomic, weak) IBOutlet UITableView     *tableview;
@end

@implementation BecomeCashDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"BecomeCashDetailCell00" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"BecomeCashDetailCell10" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"BecomeCashDetailCell11" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"BecomeCashDetailFootView" forCellOrHeaderFootViewFlag:NO];
    [self setTitle:@"变现"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotoAssetDetailAction
{
    UIViewController *assetDetailHandle = nil;
    NSArray *controllers = [self.navigationController viewControllers];
    
    for (id viewcontroll in controllers)
    {
        if ([viewcontroll isKindOfClass:[AssetDetailsViewController class]])
        {
            assetDetailHandle = viewcontroll;
            break;
        }
    }
    
    if (!assetDetailHandle)
    {
        for (id viewcontroll in controllers)
        {
            if ([viewcontroll isKindOfClass:[TransactionDetailViewController class]])
            {
                assetDetailHandle = viewcontroll;
                break;
            }
        }
    }
    
    [self.navigationController popToViewController:assetDetailHandle animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            return [BecomeCashDetailCell00 cellHeight];
        }
            break;
            
        case 1:
        {
            return [BecomeCashDetailCell10 cellHeight];
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 1;
        }
            break;
            
        case 1:
        {
            return [BecomeCashDetailFootView viewHeight];
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    [view.contentView setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
    
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return nil;
        }
            break;
            
        case 1:
        {
            BecomeCashDetailFootView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BecomeCashDetailFootView"];
            [view.confirmBtn addTarget:self action:@selector(gotoAssetDetailAction) forControlEvents:UIControlEventTouchUpInside];
            
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 1;
        }
            break;
            
        case 1:
        {
            return 2;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BecomeCashDetailCell00" forIndexPath:indexPath];
        }
            break;
            
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"BecomeCashDetailCell10" forIndexPath:indexPath];
                }
                    break;
                    
                case 1:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"BecomeCashDetailCell11" forIndexPath:indexPath];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    
    // Configure the cell...
    
    return cell;
}

@end
