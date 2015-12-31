//
//  ContractInformationCell.m
//  LittleFawn
//
//  Created by baidu on 15/12/25.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "ContractInformationCell.h"

@implementation ContractInformationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 100.0f;
}

- (IBAction)click1:(id)sender
{
    if (self.clickCallback) {
        self.clickCallback(0);
    }
}

- (IBAction)click2:(id)sender
{
    if (self.clickCallback) {
        self.clickCallback(1);
    }
}

@end
