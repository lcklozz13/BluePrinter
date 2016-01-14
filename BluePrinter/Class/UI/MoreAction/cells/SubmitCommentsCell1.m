//
//  SubmitCommentsCell1.m
//  LittleFawn
//
//  Created by baidu on 16/1/14.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "SubmitCommentsCell1.h"

@implementation SubmitCommentsCell1

- (void)awakeFromNib {
    // Initialization code
    self.inpuntView.layer.borderColor = [PublicMethods gs_colorWithHexString:@"777777"].CGColor;
    self.inpuntView.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 207.0f;
}

@end
