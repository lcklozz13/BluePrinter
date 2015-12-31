//
//  RegisterFootView.h
//  BluePrinter
//
//  Created by klozz on 15/12/21.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterFootView : UITableViewHeaderFooterView
@property (nonatomic, weak) IBOutlet     UIButton       *registerBtn;
@property (nonatomic, weak) IBOutlet     UIButton       *argeenBtn;
+ (CGFloat)viewHegiht;
@end
