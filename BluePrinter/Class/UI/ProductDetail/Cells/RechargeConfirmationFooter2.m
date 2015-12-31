//
//  RechargeConfirmationFooter2.m
//  LittleFawn
//
//  Created by baidu on 15/12/31.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "RechargeConfirmationFooter2.h"

@implementation RechargeConfirmationFooter2

- (void)awakeFromNib {
    // Initialization code
    NSAttributedString *rate = [[NSAttributedString alloc] initWithString:@"同意" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"727171" fontSize:14.0f]];
    NSAttributedString *Percent = [[NSAttributedString alloc] initWithString:@"《支付服务协议》" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"4F759A" fontSize:14.0f]];
    NSMutableAttributedString *ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:rate];
    [ratestring appendAttributedString:Percent];
    [self.argeenBtn setAttributedTitle:ratestring forState:UIControlStateNormal];
}

+ (CGFloat)viewHeight
{
    return 45.0f;
}

@end
