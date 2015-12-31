//
//  PaymentCell2.m
//  LittleFawn
//
//  Created by baidu on 15/12/28.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "PaymentCell2.h"

@interface PaymentCell2 ()
@property (nonatomic, strong) UIImageView *customAssessoryView;
@end

@implementation PaymentCell2

- (void)awakeFromNib {
    // Initialization code
    UIImage *image = [UIImage imageNamed:@"icon-success"];
    _customAssessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 19)];
    [_customAssessoryView setImage:image];
    self.accessoryView = _customAssessoryView;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    UIImage *image = nil;
    
    if (selected)
    {
        image = [UIImage imageNamed:@"icon-success1"];
    }
    else
    {
        image = [UIImage imageNamed:@"icon-gray-circle"];
    }
    
    [_customAssessoryView setImage:image];
}

+ (CGFloat)cellHeight
{
    return 64.0f;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGRect frame = self.imageView.frame;
    
    frame.origin.y = self.textLabel.frame.origin.y + (self.textLabel.frame.size.height - frame.size.height) / 2.0f;
    
    self.imageView.frame = frame;
}
@end
