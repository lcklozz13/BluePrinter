//
//  RechargeConfirmCell.h
//  LittleFawn
//
//  Created by baidu on 15/12/31.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeConfirmCell : UITableViewCell
+ (CGFloat)cellHeight;
@property (weak, nonatomic) IBOutlet    UILabel *titleLab;
@property (weak, nonatomic) IBOutlet    UITextField *contentTextField;
@end
