//
//  SearchViewController.m
//  LittleFawn
//
//  Created by klozz on 16/1/16.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property (strong,nonatomic) NSMutableArray  *dataList;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (nonatomic, weak) IBOutlet UITableView    *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar    *searchBar;
@property (nonatomic, assign) BOOL  isKeyboardShowed;
@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isKeyboardShowed = NO;
    UIButton *cancelButton;
    UIView *topView = self.searchBar.subviews[0];
    for (UIView *subView in topView.subviews)
    {
        NSLog(@"%@", NSStringFromClass([subView class]));
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")])
        {
            cancelButton = (UIButton*)subView;
        }
    }
    
    if (cancelButton)
    {
        //Set the new title of the cancel button
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    self.searchList = [NSMutableArray arrayWithObjects:@"广发纯债债券A", @"易方达安心回报债券A", @"广发纯债债券A", @"易方达安心回报债券A", nil];
    
    if (!self.dataList)
    {
        self.dataList = [NSMutableArray arrayWithCapacity:100];
        
        for (NSInteger i=0; i<100; i++)
        {
            [self.dataList addObject:[NSString stringWithFormat:@"广发纯债债券A-%ld",(long)i]];
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.searchBar becomeFirstResponder];
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
    
    CGRect r = self.tableView.frame;
    r.size.height -= keyboardSize.height;
    [self.tableView setFrame:r];
}

//键盘隐藏消息
- (void)keyboardWasHide:(NSNotification *)notif
{
    self.isKeyboardShowed = NO;
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    CGRect r = self.tableView.frame;
    r.size.height += keyboardSize.height;
    [self.tableView setFrame:r];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView Delegate and DataSource
//设置区域
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *flag = @"cellFlag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        [cell.textLabel setTextColor:[PublicMethods gs_colorWithHexString:@"fa5156"]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    [cell.textLabel setText:self.searchList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self searchBarCancelButtonClicked:nil];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"搜索Begin");
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"搜索End");
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
    
    if (self.searchList!= nil)
    {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
}
@end
