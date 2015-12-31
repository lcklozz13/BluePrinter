//
//  BaseViewController.m
//  BluePrinter
//
//  Created by klozz on 15/10/27.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation UIScrollView (UITouchEvent)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.navigationController)
    {
        [self setLeftBarButtonWithImageName:@"icon-arrow-l-1" action:@selector(backAction)];
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setTitle:NSLocalizedStringWithDefaultValue(@"base_view_title", nil,[NSBundle mainBundle], @"Base",nil)];
}

- (void)setLeftBarButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width + 11, image.size.height + 5)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:item];
}

- (void)setLeftBarButtonWithImageName:(NSString *)imageName action:(SEL)action
{
    [self setLeftBarButtonWithImageName:imageName target:self action:action];
}

- (void)setRightBarButtonWithImageName:(NSString *)imageName action:(SEL)action
{
    [self setRightBarButtonWithImageName:imageName target:self action:action];
}

- (void)setRightBarButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width + 11, image.size.height + 5)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)setRightBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    NSMutableDictionary *attr = [[NSMutableDictionary alloc] init];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:14.0f];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    CGSize size = [title sizeWithAttributes:attr];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width + 11, size.height + 6)];
    [button setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:attr] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setRightBarButtonWithTitle:(NSString *)title action:(SEL)action
{
    [self setRightBarButtonWithTitle:title target:self action:action];
}

- (void)tableView:(UITableView *)aTableView registionReuseIdentifierWithNibName:(NSString *)nibName forCellOrHeaderFootViewFlag:(BOOL)isCell
{
    UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]];
    
    if (nib)
    {
        if (isCell)
        {
            [aTableView registerNib:nib forCellReuseIdentifier:nibName];
        }
        else
        {
            [aTableView registerNib:nib forHeaderFooterViewReuseIdentifier:nibName];
        }
    }
}

- (void)tableView:(UITableView *)aTableView registionClass:(Class)aClass withReuseIdentifier:(NSString *)reuseIdentifier forCellOrHeaderFootViewFlag:(BOOL)isCell
{
    if (isCell)
    {
        [aTableView registerClass:aClass forCellReuseIdentifier:reuseIdentifier];
    }
    else
    {
        [aTableView registerClass:aClass forHeaderFooterViewReuseIdentifier:reuseIdentifier];
    }
}

- (void)backAction
{
    if (self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark    - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

@end
