//
//  LeftMenuCell.m
//  BluePrinter
//
//  Created by klozz on 15/11/3.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "LeftMenuCell.h"

@implementation LeftMenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.imageView.frame;
    frame.origin.x = 30;
    
    self.imageView.frame = frame;
    
    frame = self.textLabel.frame;
    frame.origin.x = self.imageView.frame.origin.x + self.imageView.frame.size.width + 19;
    self.textLabel.frame = frame;
    
    if (self.accessoryView)
    {
        frame = self.accessoryView.frame;
        frame.origin.x = 230.0f - frame.size.width;
        self.accessoryView.frame = frame;
    }
}

@end
