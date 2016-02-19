//
//  RecommendedHeaderView.h
//  LittleFawn
//
//  Created by baidu on 16/2/19.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendedHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet    UIScrollView    *recommondView;
@property (nonatomic, weak) IBOutlet    UIButton        *leftBtn;
@property (nonatomic, weak) IBOutlet    UIButton        *rightBtn;

+ (CGFloat)ViewHeight;
@end
