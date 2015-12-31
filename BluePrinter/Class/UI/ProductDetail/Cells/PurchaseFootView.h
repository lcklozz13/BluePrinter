//
//  PurchaseFootView.h
//  LittleFawn
//
//  Created by klozz on 15/12/27.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseFootView : UITableViewHeaderFooterView
@property (nonatomic, weak) IBOutlet        UIButton        *agreenBtn;
@property (nonatomic, weak) IBOutlet        UIButton        *continueBtn;
+ (CGFloat)viewHeight;
@end
