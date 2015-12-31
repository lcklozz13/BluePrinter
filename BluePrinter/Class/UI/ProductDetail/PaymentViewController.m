//
//  PaymentViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/28.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "PaymentViewController.h"
#import "SelectBankViewController.h"
#import "InputPayPasswordViewController.h"
#import "OrderViewController.h"
#import "PaymentCell1.h"
#import "PaymentCell2.h"
#import "PaymentCell3.h"
#import "PaymentFootView.h"

@interface PaymentViewController ()
@property (nonatomic, weak) IBOutlet    UITableView *tableview;
@property (nonatomic, strong) FinancialProduct          *curProduct;
@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"PaymentCell1" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"PaymentCell2" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"PaymentCell3" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"PaymentFootView" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableview registionClass:[UITableViewHeaderFooterView class] withReuseIdentifier:@"UITableViewHeaderFooterView" forCellOrHeaderFootViewFlag:NO];
    [self setTitle:@"支付订单"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithProduct:(FinancialProduct *)product
{
    self = [super init];
    
    if (self)
    {
        self.curProduct = product;
    }
    
    return self;
}

- (void)morePaymentAction
{
    SelectBankViewController *view = [[SelectBankViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)confirmPaymentAction
{
    InputPayPasswordViewController *lockScreenController = [[InputPayPasswordViewController alloc] init];
    lockScreenController.compelection = ^()
    {
        OrderViewController *view = [[OrderViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    };
    
    UINavigationController *nav = [ViewControllerManager createNavigationWithRootViewController:lockScreenController];
    
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        nav.providesPresentationContextTransitionStyle = YES;
        nav.definesPresentationContext = YES;
        nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:nav animated:NO completion:nil];
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
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
    switch (section)
    {
        case 0:
        {
            return 10;
        }
            break;
            
        case 1:
        {
            return 10;
        }
            break;
            
        case 2:
        {
            return 1;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2)
    {
        return [PaymentFootView viewHeight];
    }
    
    return 1;
    
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
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
            
            return view;
        }
            break;
            
        case 1:
        {
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[PublicMethods gs_colorWithHexString:@"EFEFEF"]];
            
            return view;
        }
            break;
            
        case 2:
        {
            PaymentFootView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PaymentFootView"];
            [view.confirmPaymentBtn addTarget:self action:@selector(confirmPaymentAction) forControlEvents:UIControlEventTouchUpInside];
            
            return view;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            return [PaymentCell1 cellHeight];
        }
            break;
            
        case 1:
        {
            return [PaymentCell2 cellHeight];
        }
            break;
            
        case 2:
        {
            return [PaymentCell3 cellHeight];
        }
            break;
            
        default:
            break;
    }
    
    return 0;
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
            
        case 2:
        {
            return 1;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    
    switch (indexPath.section)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentCell1" forIndexPath:indexPath];
            [((PaymentCell1 *)cell) setProduct:self.curProduct];
        }
            break;
            
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentCell2" forIndexPath:indexPath];
            
            switch (indexPath.row)
            {
                case 0:
                {
                    [cell.imageView setImage:[UIImage imageNamed:@"icon-jianhang"]];
                    [cell.textLabel setText:@"中国建设银行  **6358"];
                    [cell.detailTextLabel setText:@"已绑定银行卡，直接付款"];
                }
                    break;
                    
                case 1:
                {
                    [cell.imageView setImage:[UIImage imageNamed:@"icon-zhaoshang"]];
                    [cell.textLabel setText:@"招商银行    **1158"];
                    [cell.detailTextLabel setText:@"已绑定银行卡，直接付款"];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentCell3" forIndexPath:indexPath];
            [((PaymentCell3 *)cell).moreBtn addTarget:self action:@selector(morePaymentAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
            
        default:
            break;
    }
    // Configure the cell...
    
    return cell;
}

@end
