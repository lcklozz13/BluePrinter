//
//  MyAccountCell.h
//  LittleFawn
//
//  Created by klozz on 16/1/2.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountCell : UITableViewCell
@property (nonatomic, weak) IBOutlet    UIImageView *headerView;
@property (nonatomic, weak) IBOutlet    UILabel     *replacementNameLab;
@property (nonatomic, weak) IBOutlet    UILabel     *accountIDLab;
+ (CGFloat)cellHeight;
@end
