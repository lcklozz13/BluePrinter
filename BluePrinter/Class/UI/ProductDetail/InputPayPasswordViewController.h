//
//  InputPayPasswordViewController.h
//  LittleFawn
//
//  Created by klozz on 15/12/28.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^compeletionAction)();

@interface InputPayPasswordViewController : BaseViewController
@property (nonatomic, copy) compeletionAction compelection;
@end
