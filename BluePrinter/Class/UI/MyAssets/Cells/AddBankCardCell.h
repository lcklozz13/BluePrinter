//
//  AddBankCardCell.h
//  LittleFawn
//
//  Created by klozz on 16/1/7.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBankCardCell : UITableViewCell
@property (nonatomic, weak) IBOutlet    UILabel *titleLab;
@property (nonatomic, weak) IBOutlet    UITextField *inputTextFiled;

+ (CGFloat)cellHeight;
@end
