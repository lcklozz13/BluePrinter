//
//  InputPayPasswordViewController.m
//  LittleFawn
//
//  Created by klozz on 15/12/28.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "InputPayPasswordViewController.h"

@interface InputPayPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet    UIView      *inputPwdView;
@property (nonatomic, weak) IBOutlet    UIView      *showSuccessView;

@property (nonatomic, weak) IBOutlet    UITextField *pwd0;
@property (nonatomic, weak) IBOutlet    UITextField *pwd1;
@property (nonatomic, weak) IBOutlet    UITextField *pwd2;
@property (nonatomic, weak) IBOutlet    UITextField *pwd3;
@property (nonatomic, weak) IBOutlet    UITextField *pwd4;
@property (nonatomic, weak) IBOutlet    UITextField *pwd5;


- (IBAction)closeViewAction:(id)sender;
- (IBAction)forgetPwdAction:(id)sender;
@end

@implementation InputPayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.showSuccessView setHidden:YES];
    [self.pwd0 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd3 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd4 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd5 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeViewAction:(id)sender
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        
//        if (!sender)
        {
            if (self.compelection)
            {
                self.compelection();
            }
        }
    }];
}

- (IBAction)forgetPwdAction:(id)sender
{
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 1)
    {
        textField.text = [textField.text substringToIndex:1];
    }
    else if (textField.text.length == 1)
    {
        if (self.pwd0 == textField)
        {
            [self.pwd1 becomeFirstResponder];
        }
        else if (self.pwd1 == textField)
        {
            [self.pwd2 becomeFirstResponder];
        }
        else if (self.pwd2 == textField)
        {
            [self.pwd3 becomeFirstResponder];
        }
        else if (self.pwd3 == textField)
        {
            [self.pwd4 becomeFirstResponder];
        }
        else if (self.pwd4 == textField)
        {
            [self.pwd5 becomeFirstResponder];
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0)
    {
        return YES;
    }
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    
    if (existedLength - selectedLength + replaceLength > 1)
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.pwd5)
    {
        //TODO:提交，校验交易
        [self.inputPwdView setHidden:YES];
        [self.showSuccessView setHidden:NO];
        [self.view endEditing:YES];
        [self performSelector:@selector(closeViewAction:) withObject:nil afterDelay:3];
        
        return YES;
    }
    
    return NO;
}

@end
