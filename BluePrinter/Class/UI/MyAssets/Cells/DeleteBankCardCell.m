//
//  DeleteBankCardCell.m
//  LittleFawn
//
//  Created by klozz on 16/1/7.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "DeleteBankCardCell.h"

@implementation DeleteBankCardCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [self.selectedImageView setHighlighted:selected];
}

+ (CGFloat)cellHeight
{
    return 70.0f;
}

@end
