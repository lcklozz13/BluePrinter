//
//  LeftMenuHeadView.h
//  BluePrinter
//
//  Created by klozz on 15/11/2.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuHeadView : UITableViewHeaderFooterView
@property (nonatomic, weak) IBOutlet UIImageView    *headVew;
@property (nonatomic, weak) IBOutlet UILabel        *nickname;
@property (nonatomic, weak) IBOutlet UILabel        *assetsTitle;
@property (nonatomic, weak) IBOutlet UILabel        *assets;
+ (CGFloat)cellHeight;
@end
