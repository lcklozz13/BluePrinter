//
//  AssetsInforCell.h
//  LittleFawn
//
//  Created by klozz on 16/1/1.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsInforCell : UITableViewCell
@property (weak, nonatomic) IBOutlet    UILabel     *totalAssetLab;
@property (weak, nonatomic) IBOutlet    UILabel     *balanceLab;
@property (weak, nonatomic) IBOutlet    UILabel     *incomeLab;
+ (CGFloat)cellHeight;
@end
