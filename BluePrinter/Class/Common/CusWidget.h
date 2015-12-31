//
//  CusWidget.h
//  Housekeeping
//
//  Created by ZengRuihui on 15/7/6.
//  Copyright (c) 2015年 窗外`. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark    UITableViewCellCus
@interface UITableViewCellCus : UITableViewCell

@property (assign, nonatomic) UIViewController *delegate;

- (void)resetWithData:(id)data;
+ (NSInteger)getCellHeight:(id)data;

@end

#pragma mark    UILineImageView 一条高度为0.5的线
@interface UILineImageView : UIImageView

@end

#pragma mark    UIButtonTile 按钮背景图片修改成平铺
@interface UIButtonTile : UIButton

@end

#pragma mark    UIImageViewTile 背景图片修改成平铺
@interface UIImageViewTile : UIImageView

@end

