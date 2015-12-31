//
//  RechargeCell01.h
//  LittleFawn
//
//  Created by klozz on 15/12/30.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeCell01 : UITableViewCell
+ (CGFloat)cellHeight;
@property (weak, nonatomic) IBOutlet    UILabel *titleLab;
@property (weak, nonatomic) IBOutlet    UITextField *contentTextField;
@end
