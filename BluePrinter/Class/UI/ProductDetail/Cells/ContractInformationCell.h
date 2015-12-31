//
//  ContractInformationCell.h
//  LittleFawn
//
//  Created by baidu on 15/12/25.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickButtonWithIndex)(NSInteger);
@interface ContractInformationCell : UITableViewCell
@property (nonatomic, copy)clickButtonWithIndex clickCallback;
+ (CGFloat)cellHeight;
@end
