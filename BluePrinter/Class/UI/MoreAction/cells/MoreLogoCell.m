//
//  MoreLogoCell.m
//  LittleFawn
//
//  Created by baidu on 16/1/11.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "MoreLogoCell.h"

@implementation MoreLogoCell

- (void)awakeFromNib {
    // Initialization code
    self.versionLab.text = [[NSString alloc] initWithFormat:@"版本号：%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 190.0f;
}

@end
