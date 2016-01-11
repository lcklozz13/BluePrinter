//
//  TransferredFootView.h
//  LittleFawn
//
//  Created by baidu on 16/1/11.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferredFootView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet    UIButton    *confromBtn;
@property (weak, nonatomic) IBOutlet    UILabel     *inforLab;
+ (CGFloat)viewHeight;
@end
