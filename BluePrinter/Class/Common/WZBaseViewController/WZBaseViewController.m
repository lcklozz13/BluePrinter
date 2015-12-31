//
//  WZBaseViewController.m
//  TuanXin
//
//  Created by 窗外` on 13-12-18.
//  Copyright (c) 2013年 窗外`. All rights reserved.
//

#import "WZBaseViewController.h"
#import "MJRefresh.h"

#define kLoadingTag 122501101

@interface WZBaseViewController ()
{
    NSString *_sLogStr;
    
    UIView *_topBgView;
    
    NSMutableArray *_refreshTableViewAry;
}

@property (copy, nonatomic) NSString *sLogStr;

@end

@implementation WZBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GRAY_COLOR_BG;
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, 64)];
    topBgView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:topBgView];

    if (SYSTEM_VERSION >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    
    [self setReturnBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view sendSubviewToBack:_topBgView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    if (![[self.navigationController viewControllers] containsObject: self]) {
        //出栈操作
        [self releaseData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleDefault;
//}
//
//- (BOOL)prefersStatusBarHidden
//{
//    return NO;
//}

//这里保存添加了下拉上拉刷新控件的列表 在返回时统一释放
- (void)addRefreshTableView:(UITableView *)tv
{
    _refreshTableViewAry = _refreshTableViewAry ? _refreshTableViewAry : [NSMutableArray array];
    [_refreshTableViewAry addObject:tv];
}

//视图pop后要做的操作
- (void)releaseData
{
    NSLog(@"出栈");
    
    //释放下拉上拉刷新控件
    for (UITableView *tv in _refreshTableViewAry) {
        [tv removeFooter];
        [tv removeHeader];
    }
    [_refreshTableViewAry removeAllObjects];
    _refreshTableViewAry = nil;
}


#pragma mark    - 导航栏顶部按钮

- (void)setReturnBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 32);
    [btn setImage:[UIImage imageNamed:@"header_back"] forState:UIControlStateNormal];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    [btn setTitleColor:GRAY_COLOR forState:UIControlStateNormal];
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [btn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = back;
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setLeftBarBtnWithTitle:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 32);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBarCallback:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    _leftBtn = btn;
}

- (void)setRightBarBtnWithTitle:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 32);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBarCallback:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    _rightBtn = btn;
}

- (void)setRightBarBtnWithImage:(NSString *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 32, 32);
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBarCallback:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    _rightBtn = btn;
}

- (void)rightBarCallback:(UIButton *)btn
{
}
- (void)leftBarCallback:(UIButton *)btn
{
}


#pragma mark    - 加载

- (void)startLoading
{
    UIImageView *view = (UIImageView *)[self.view viewWithTag:kLoadingTag];
    if (view == nil) {
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_red"]];
        view.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT - 84)/2);
        view.tag = kLoadingTag;
        [self.view addSubview:view];
    }
    [self.view bringSubviewToFront:view];
    
    [view startRotationAnimationWithDuration:1];
}

- (void)stopLoading
{
    UIImageView *view = (UIImageView *)[self.view viewWithTag:kLoadingTag];
    [view removeFromSuperview];
}

@end

