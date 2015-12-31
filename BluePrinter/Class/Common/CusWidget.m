//
//  CusWidget.m
//  Housekeeping
//
//  Created by ZengRuihui on 15/7/6.
//  Copyright (c) 2015年 窗外`. All rights reserved.
//

#import "CusWidget.h"

#pragma mark    UITableViewCellCus
@implementation UITableViewCellCus

- (void)resetWithData:(id)data
{
}

+ (NSInteger)getCellHeight:(id)data
{
    return 44;
}

@end

#pragma mark    UILineImageView 一条高度为0.5的线
@implementation UILineImageView

- (void)awakeFromNib
{
    self.height = 0.5f;
    if (self.contentMode == UIViewContentModeBottom) {
        //显示在底部 坐标加0.5
        self.originy += 0.5;
        self.contentMode = UIViewContentModeScaleToFill;
    }
    self.image = [UIImage imageNamed:@"line"];
}

@end

#pragma mark    UIButtonTile 按钮背景图片修改成平铺
@implementation UIButtonTile

- (void)awakeFromNib
{
    UIImage *bg = [self backgroundImageForState:UIControlStateNormal];
    if (bg) {
        bg = [bg stretchableImageWithLeftCapWidth:bg.size.width/2 topCapHeight:bg.size.height/2];
        [self setBackgroundImage:bg forState:UIControlStateNormal];
    }
    
    bg = [self backgroundImageForState:UIControlStateHighlighted];
    if (bg) {
        bg = [bg stretchableImageWithLeftCapWidth:bg.size.width/2 topCapHeight:bg.size.height/2];
        [self setBackgroundImage:bg forState:UIControlStateHighlighted];
    }
}

@end

#pragma mark    UIImageViewTile 背景图片修改成平铺
@implementation UIImageViewTile

- (void)awakeFromNib
{
    UIImage *bg = self.image;
    if (bg) {
        bg = [bg stretchableImageWithLeftCapWidth:bg.size.width/2 topCapHeight:bg.size.height/2];
        self.image = bg;
    }
}

@end