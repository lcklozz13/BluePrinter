//
//  SelectBankCell.m
//  LittleFawn
//
//  Created by klozz on 15/12/28.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "SelectBankCell.h"

@implementation SelectBankCell

- (void)awakeFromNib {
    // Initialization code
    [self.textLabel setTextColor:[PublicMethods gs_colorWithHexString:@"727171"]];
    [self.detailTextLabel setTextColor:[PublicMethods gs_colorWithHexString:@"b5b5b6"]];
    [self.textLabel setFont:[UIFont systemFontOfSize:17.0]];
    [self.detailTextLabel setFont:[UIFont systemFontOfSize:14.0]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
