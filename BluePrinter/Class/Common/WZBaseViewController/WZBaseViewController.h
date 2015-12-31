//
//  WZBaseViewController.h
//  TuanXin
//
//  Created by 窗外` on 13-12-18.
//  Copyright (c) 2013年 窗外`. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZBaseViewController : UIViewController

//这里保存添加了下拉上拉刷新控件的列表 在返回时统一释放
- (void)addRefreshTableView:(UITableView *)tv;


#pragma mark    - 导航栏顶部按钮

@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;

- (void)setReturnBtn;
- (void)popViewController;
//视图pop后要做的操作
- (void)releaseData;

//添加导航栏右上角按钮
- (void)setRightBarBtnWithTitle:(NSString *)title;
- (void)setRightBarBtnWithImage:(NSString *)image;
//添加导航栏左上角按钮
- (void)setLeftBarBtnWithTitle:(NSString *)title;
//左右按钮回调
- (void)rightBarCallback:(UIButton *)btn;
- (void)leftBarCallback:(UIButton *)btn;


#pragma mark    - 加载
//加载
- (void)startLoading;
- (void)stopLoading;

@end


