//
//  DeleteBankCardCell.h
//  LittleFawn
//
//  Created by klozz on 16/1/7.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeleteBankCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet    UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet    UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet    UILabel *bankcardIDLab;
+ (CGFloat)cellHeight;
@end
