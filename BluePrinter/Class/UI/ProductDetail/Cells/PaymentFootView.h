//
//  PaymentHeadView.h
//  LittleFawn
//
//  Created by baidu on 15/12/28.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentFootView : UITableViewHeaderFooterView
@property (nonatomic, weak) IBOutlet    UIButton    *confirmPaymentBtn;
+ (CGFloat)viewHeight;
@end
