//
//  AccountInforCell.h
//  LittleFawn
//
//  Created by klozz on 16/1/1.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountInforCell : UITableViewCell
@property (nonatomic, weak) IBOutlet    UIImageView     *headerView;
@property (nonatomic, weak) IBOutlet    UILabel         *nicknameLab;
@property (nonatomic, weak) IBOutlet    UILabel         *accountIDLab;
@property (nonatomic, weak) IBOutlet    UILabel         *bankInforLab;
+ (CGFloat)cellHeight;
@end
