//
//  PurchaseViewController.m
//  LittleFawn
//
//  Created by klozz on 15/12/27.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "PurchaseViewController.h"
#import "PurchaseCell.h"
#import "PurchaseFootView.h"
#import "PurchaseProtocolViewController.h"
#import "RechargeViewController.h"

@interface PurchaseViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet        UITableView *tableview;
@property (nonatomic, strong) FinancialProduct          *curProduct;
@property (nonatomic, weak) UITextField                 *moneyInput;
@property (nonatomic, weak) UIButton                    *continueBtn;
@end

@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"购买"];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"PurchaseCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"PurchaseFootView" forCellOrHeaderFootViewFlag:NO];
    [self.view setBackgroundColor:[PublicMethods gs_colorWithHexString:@"E4E4E4"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
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

- (void)continuesAction
{
    if ([self.moneyInput.text floatValue] > [DATA_MANAGER.userInfo.leaveMoney floatValue])
    {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"你的账户余额不足，请充值。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去充值", nil];
        alertview.tag = 10086;
        [alertview show];
        return;
    }
    
    self.curProduct.paymentMoney = [[NSString alloc] initWithFormat:@"%@", self.moneyInput.text];
    PurchaseProtocolViewController *view = [[PurchaseProtocolViewController alloc] initWithProduct:self.curProduct];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)argeenAction
{
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //TODO:充值
        RechargeViewController *view = [[RechargeViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
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
#pragma mark - Table view delagate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [PurchaseFootView viewHeight];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    PurchaseFootView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PurchaseFootView"];
    [view.agreenBtn addTarget:self action:@selector(argeenAction) forControlEvents:UIControlEventTouchUpInside];
    [view.continueBtn addTarget:self action:@selector(continuesAction) forControlEvents:UIControlEventTouchUpInside];
    self.continueBtn = view.continueBtn;
    self.continueBtn.enabled = self.moneyInput.text.length > 0;
    
    return view;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PurchaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PurchaseCell" forIndexPath:indexPath];
    
    switch (indexPath.row)
    {
        case 0:
        {
            cell.titleLab.text = @"产品名称";
            cell.contentTextField.text = self.curProduct.product_title;
            [cell.contentTextField setEnabled:NO];
        }
            break;
            
        case 1:
        {
            cell.titleLab.text = @"产品类型";
            cell.contentTextField.text = @"个人贷";
            [cell.contentTextField setEnabled:NO];
        }
            break;
            
        case 2:
        {
            cell.titleLab.text = @"购买金额";
            cell.contentTextField.placeholder = @"100.00元起";
            [cell.contentTextField setKeyboardType:UIKeyboardTypeNumberPad];
            [cell.contentTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
            cell.contentTextField.delegate = self;
            self.moneyInput = cell.contentTextField;
            
        }
            break;
            
        default:
            break;
    }
    // Configure the cell...
    
    return cell;
}


#pragma mark    - UITextFieldDelegate

- (void)textFieldDidChanged:(NSNotification *)notification
{
    self.continueBtn.enabled = self.moneyInput.text.length > 0;
}
@end
