//
//  InputTextForChangeCell.h
//  LittleFawn
//
//  Created by klozz on 16/1/8.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputTextForChangeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet    UILabel *titleLab;
@property (weak, nonatomic) IBOutlet    UITextField *inputTextField;
+ (CGFloat)cellHeight;
@end
