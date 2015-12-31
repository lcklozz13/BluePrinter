//
//  LeftMenuFootView.m
//  BluePrinter
//
//  Created by klozz on 15/12/23.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "LeftMenuFootView.h"

@implementation LeftMenuFootView

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)callConsumerHotline:(id)sender
{
    UIApplication *share = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"tel://4001686868"];
    if ([share canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        [ShareFunction showToast:NSLocalizedString(@"该设备不能打电话", nil)];
    }
}

+ (CGFloat)cellHeight
{
    return 130.0f;
}

@end
