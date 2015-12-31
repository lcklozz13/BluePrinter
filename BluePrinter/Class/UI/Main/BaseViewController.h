//
//  BaseViewController.h
//  BluePrinter
//
//  Created by klozz on 15/10/27.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)setLeftBarButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;
- (void)setLeftBarButtonWithImageName:(NSString *)imageName action:(SEL)action;

- (void)setRightBarButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;
- (void)setRightBarButtonWithImageName:(NSString *)imageName action:(SEL)action;

- (void)setRightBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (void)setRightBarButtonWithTitle:(NSString *)title action:(SEL)action;



- (void)tableView:(UITableView *)aTableView registionReuseIdentifierWithNibName:(NSString *)nibName forCellOrHeaderFootViewFlag:(BOOL)isCell;
- (void)tableView:(UITableView *)aTableView registionClass:(Class)aClass withReuseIdentifier:(NSString *)reuseIdentifier forCellOrHeaderFootViewFlag:(BOOL)isCell;
- (void)backAction;
@end
