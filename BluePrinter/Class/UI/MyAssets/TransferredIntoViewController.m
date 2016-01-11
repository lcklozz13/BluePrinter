//
//  TransferredIntoViewController.m
//  LittleFawn
//
//  Created by baidu on 16/1/11.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "TransferredIntoViewController.h"
#import "SelectBankViewController.h"
#import "TransferredIntoExplanationViewController.h"
#import "TransferredIntoResultViewController.h"
#import "InputPayPasswordViewController.h"
#import "TransferredBankCell.h"
#import "TransferredInputCell.h"
#import "TransferredFootView.h"
#import "TransferredHeaderView.h"


@interface TransferredIntoViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@property (assign, nonatomic) ViewType  curType;
@property (nonatomic, weak) UIButton    *continueBtn;
@property (weak, nonatomic) UITextField *moneyInputTextField;
@end

@implementation TransferredIntoViewController

- (id)initWithViewType:(ViewType)type
{
    self = [super init];
    
    if (self)
    {
        self.curType = type;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.curType == ViewTyp_turnInto)
    {
        self.title = @"转入";
    }
    else
    {
        self.title = @"转出";
    }
    
    [self setRightBarButtonWithTitle:@"限额说明" action:@selector(rightAction)];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransferredBankCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransferredInputCell" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransferredFootView" forCellOrHeaderFootViewFlag:NO];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransferredHeaderView" forCellOrHeaderFootViewFlag:NO];
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

- (void)rightAction
{
    TransferredIntoExplanationViewController *vc  = [[TransferredIntoExplanationViewController alloc] initWithViewType:self.curType];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)nextAction:(id)sender
{
    InputPayPasswordViewController *lockScreenController = [[InputPayPasswordViewController alloc] init];
    lockScreenController.compelection = ^()
    {
        TransferredIntoResultViewController *view = [[TransferredIntoResultViewController alloc] initWithViewType:self.curType money:self.moneyInputTextField.text];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1.0f;
    }
    else
    {
        return [TransferredHeaderView viewHeight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1.0f;
    }
    else
    {
        return [TransferredFootView viewHeight];
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil;
    }
    
    TransferredHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TransferredHeaderView"];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [TransferredBankCell cellHeight];
    }
    else
    {
        return [TransferredInputCell cellHeight];
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil;
    }
    
    TransferredFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TransferredFootView"];
    
    [footView.confromBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    if (_curType == ViewTyp_turnInto)
    {
        [footView.confromBtn setTitle:@"确认转入" forState:UIControlStateNormal];
    }
    else
    {
        [footView.confromBtn setTitle:@"确认转出" forState:UIControlStateNormal];
    }
    
    self.continueBtn = footView.confromBtn;
    
    
    NSAttributedString *rate = [[NSAttributedString alloc] initWithString:@"预计收益到帐时间" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"b5b5b6" fontSize:12.0f]];
    NSAttributedString *Percent = [[NSAttributedString alloc] initWithString:@"10-18（星期五）" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"fa5156" fontSize:12.0f]];
    NSMutableAttributedString *ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:rate];
    [ratestring appendAttributedString:Percent];
    [footView.inforLab setAttributedText:ratestring];
    
    [self textFieldDidChanged:nil];
    
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0)
    {
        TransferredBankCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"TransferredBankCell" forIndexPath:indexPath];
        cell = cell1;
    }
    else if (indexPath.section == 1)
    {
        TransferredInputCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"TransferredInputCell" forIndexPath:indexPath];
        cell = cell1;
        self.moneyInputTextField = cell1.moneyInput;
        self.moneyInputTextField.delegate = self;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        SelectBankViewController *view = [[SelectBankViewController alloc] init];
        view.selectedAction = ^(NSInteger index, id bankInfo)
        {
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
            TransferredBankCell *cell1 = [tableView cellForRowAtIndexPath:path];
            
            switch (index)
            {
                case 0:
                {
                    cell1.titleImageView.image = [UIImage imageNamed:@"icon-gongshang1"];
                }
                    break;
                    
                case 1:
                {
                    cell1.titleImageView.image = [UIImage imageNamed:@"icon-zhongyin"];
                }
                    break;
                    
                case 2:
                {
                    cell1.titleImageView.image = [UIImage imageNamed:@"icon-jianhang1"];
                }
                    break;
                    
                default:
                    break;
            }
            
            [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        };
        
        [self.navigationController pushViewController:view animated:YES];
    }
}

#pragma mark    - UITextFieldDelegate

- (void)textFieldDidChanged:(NSNotification *)notification
{
    self.continueBtn.enabled = self.moneyInputTextField.text.length > 0;
}

@end
