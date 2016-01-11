//
//  SelectBankViewController.h
//  LittleFawn
//
//  Created by baidu on 15/12/28.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^didSelectBankAction)(NSInteger index, id bankInfo);

@interface SelectBankViewController : BaseViewController
@property (nonatomic, copy) didSelectBankAction selectedAction;
@end
