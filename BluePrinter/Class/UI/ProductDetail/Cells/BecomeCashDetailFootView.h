//
//  BecomeCashDetailFootView.h
//  LittleFawn
//
//  Created by baidu on 15/12/30.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BecomeCashDetailFootView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *canBecomeLab;
@property (weak, nonatomic) IBOutlet UIButton *howCalculateBtn;
@property (weak, nonatomic) IBOutlet UIButton *argeenBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
+ (CGFloat)viewHeight;
@end
