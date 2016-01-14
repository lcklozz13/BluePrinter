//
//  SubmitCommentsViewController.m
//  LittleFawn
//
//  Created by baidu on 16/1/14.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "SubmitCommentsViewController.h"
#import "SubmitCommentsCell1.h"
#import "SubmitCommentsCell2.h"
#import "SubmitCommentsCell3.h"
#import "SubmitCommentsCell4.h"
#import "SubmitCommentsFootView.h"

@interface SubmitCommentsViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@property (nonatomic, weak) UIButton    *commitBtn;
@property (nonatomic, weak) UITextField *usenameTextFiled;
@property (nonatomic, weak) UITextField *phoneTextFiled;
@property (nonatomic, weak) UITextView  *commentTextView;
@property (nonatomic, assign) BOOL  isKeyboardShowed;
@property (nonatomic, weak) UIView  *becomeEditTextField;
@end

@implementation SubmitCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _isKeyboardShowed = NO;
    [self setTitle:@"提交意见"];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"SubmitCommentsCell1" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"SubmitCommentsCell2" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"SubmitCommentsCell3" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"SubmitCommentsCell4" forCellOrHeaderFootViewFlag:YES];
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"SubmitCommentsFootView" forCellOrHeaderFootViewFlag:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark keyboad show or hide notification
//键盘弹出事件
- (void)keyboardWasShown:(NSNotification *)notif
{
    if (self.isKeyboardShowed)
    {
        return;
    }
    
    self.isKeyboardShowed = YES;
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    CGRect r = self.tableview.frame;
    r.size.height -= keyboardSize.height;
    [self.tableview setFrame:r];
    CGPoint point = [self.becomeEditTextField.superview convertPoint:self.becomeEditTextField.frame.origin toView:self.tableview];
    point.x = 0;
    
    if (point.y + r.size.height > self.tableview.contentSize.height)
    {
        point.y = self.tableview.contentSize.height - r.size.height;
    }
    
    [self.tableview setContentOffset:point animated:NO];
}

//键盘隐藏消息
- (void)keyboardWasHide:(NSNotification *)notif
{
    self.isKeyboardShowed = NO;
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    CGRect r = self.tableview.frame;
    r.size.height += keyboardSize.height;
    [self.tableview setFrame:r];
}

- (void)commitAction
{
    if ([self.usenameTextFiled.text length] == 0) {
        [ShareFunction showToast:NSLocalizedString(@"用户名不能为空", nil)];
        return;
    }
    
    if ([self.usenameTextFiled.text length] > 40) {
        [ShareFunction showToast:NSLocalizedString(@"输入的用户名太长", nil)];
        return;
    }
    
    if ([self.usenameTextFiled.text length] == 0) {
        [ShareFunction showToast:NSLocalizedString(@"电话号码不能为空", nil)];
        return;
    }
    
    if ([self.phoneTextFiled.text length] > 40) {
        [ShareFunction showToast:NSLocalizedString(@"输入的电话号码太长", nil)];
        return;
    }
    
    [ShareFunction showToast:NSLocalizedString(@"提交成功", nil)];
    [self performSelector:@selector(backAction) withObject:nil afterDelay:1];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            return [SubmitCommentsCell1 cellHeight];
        }
            break;
            
        case 1:
        {
            return [SubmitCommentsCell2 cellHeight];
        }
            break;
            
        case 2:
        {
            return [SubmitCommentsCell3 cellHeight];
        }
            break;
            
        case 3:
        {
            return [SubmitCommentsCell4 cellHeight];
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
            SubmitCommentsCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"SubmitCommentsCell1" forIndexPath:indexPath];
            cell = cell1;
            self.commentTextView = cell1.inpuntView;
            self.commentTextView.delegate = self;
        }
            break;
            
        case 1:
        {
            SubmitCommentsCell2 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"SubmitCommentsCell2" forIndexPath:indexPath];
            cell = cell1;
            self.usenameTextFiled = cell1.inputTextField;
            self.usenameTextFiled.delegate = self;
        }
            break;
            
        case 2:
        {
            SubmitCommentsCell3 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"SubmitCommentsCell3" forIndexPath:indexPath];
            cell = cell1;
            self.phoneTextFiled = cell1.inputTextField;
            self.phoneTextFiled.delegate = self;
        }
            break;
            
        case 3:
        {
            SubmitCommentsCell4 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"SubmitCommentsCell4" forIndexPath:indexPath];
            cell = cell1;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [SubmitCommentsFootView viewHeight];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    SubmitCommentsFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SubmitCommentsFootView"];
    self.commitBtn = footView.commitBtn;
    [self textViewDidChange:_commentTextView];
    [self.commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.becomeEditTextField = textField;
    return YES;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.becomeEditTextField = textView;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] > 0)
    {
        [self.commitBtn setEnabled:YES];
        
        if ([textView.text length] >= 200)
        {
            [textView setText:[textView.text substringToIndex:199]];
        }
    }
    else
    {
        [self.commitBtn setEnabled:NO];
    }
}

@end
