//
//  LoginFootView.h
//  BluePrinter
//
//  Created by klozz on 15/12/21.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginFootView : UITableViewHeaderFooterView
@property (nonatomic, weak) IBOutlet  UIButton      *loginBtn;
@property (nonatomic, weak) IBOutlet  UIButton      *forgetPwdBtn;
+ (CGFloat)viewHegiht;
@end
