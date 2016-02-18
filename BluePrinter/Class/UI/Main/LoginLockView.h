//
//  LoginLockView.h
//  LittleFawn
//
//  Created by baidu on 16/2/18.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginLockViewDelegate <NSObject>

- (void)gestureLockViewDidEndWithPasscode:(NSString *)passcode;

@end

@interface LoginLockView : UIView
@property (nonatomic, weak) id<LoginLockViewDelegate>delegate;
@end
