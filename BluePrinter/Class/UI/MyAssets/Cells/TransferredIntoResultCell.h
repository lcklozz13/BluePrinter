//
//  TransferredIntoResultCell.h
//  LittleFawn
//
//  Created by baidu on 16/1/11.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferredIntoResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet    UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet    UILabel     *titleLab;
@property (weak, nonatomic) IBOutlet    UILabel     *contentLab;
+ (CGFloat)cellHeight;
@end
