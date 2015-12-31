//
//  RechargeFootView.h
//  LittleFawn
//
//  Created by klozz on 15/12/30.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeFootView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIButton   *rechargeBtn;
@property (weak, nonatomic) IBOutlet UIButton   *checkLimitBtn;
+ (CGFloat)viewHeight;
@end
