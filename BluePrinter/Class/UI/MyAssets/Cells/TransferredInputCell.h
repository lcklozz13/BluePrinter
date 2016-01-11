//
//  TransferredInputCell.h
//  LittleFawn
//
//  Created by baidu on 16/1/11.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferredInputCell : UITableViewCell
@property (nonatomic, weak) IBOutlet    UITextField *moneyInput;
+ (CGFloat)cellHeight;
@end
