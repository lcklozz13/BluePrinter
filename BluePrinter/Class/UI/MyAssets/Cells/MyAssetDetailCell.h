//
//  MyAssetDetailCell.h
//  LittleFawn
//
//  Created by klozz on 16/1/2.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAssetDetailCell : UITableViewCell
@property (nonatomic, weak) IBOutlet    UILabel *totalAssetLab;
+ (CGFloat)cellHeight;
@end
