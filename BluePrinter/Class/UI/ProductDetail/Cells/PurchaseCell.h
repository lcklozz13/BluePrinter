//
//  PurchaseCell.h
//  LittleFawn
//
//  Created by klozz on 15/12/27.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseCell : UITableViewCell
@property (nonatomic, weak) IBOutlet    UILabel         *titleLab;
@property (nonatomic, weak) IBOutlet    UITextField     *contentTextField;
+ (CGFloat)cellHeight;
@end
