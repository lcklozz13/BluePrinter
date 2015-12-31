//
//  RegisterFootView.m
//  BluePrinter
//
//  Created by klozz on 15/12/21.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "RegisterFootView.h"

@implementation RegisterFootView

- (void)awakeFromNib {
    // Initialization code
    NSAttributedString *rate0 = [[NSAttributedString alloc] initWithString:@"同意《" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"b5b5b6" fontSize:11.0f]];
    NSAttributedString *Percent = [[NSAttributedString alloc] initWithString:@"小鹿理财协议" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"4f759a" fontSize:11.0f]];
    NSAttributedString *rate1 = [[NSAttributedString alloc] initWithString:@"》" attributes:[PublicMethods getTextAttributedWithForegroundColor:@"b5b5b6" fontSize:11.0f]];
    NSMutableAttributedString *ratestring = [[NSMutableAttributedString alloc] initWithAttributedString:rate0];
    [ratestring appendAttributedString:Percent];
    [ratestring appendAttributedString:rate1];
    [self.argeenBtn setAttributedTitle:ratestring forState:UIControlStateNormal];
}

+ (CGFloat)viewHegiht
{
    return 150.0f;
}
@end
