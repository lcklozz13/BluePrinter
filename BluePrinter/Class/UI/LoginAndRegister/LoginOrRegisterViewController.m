//
//  LoginOrRegisterViewController.m
//  MobileExperienceStore
//
//  Created by klozz on 15/12/13.
//  Copyright © 2015年 91. All rights reserved.
//

#import "LoginOrRegisterViewController.h"
#import "RegisterAccountViewController.h"
#import "AccountLoginViewController.h"

@interface LoginOrRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)registerAction:(id)sender;
- (IBAction)loginAction:(id)sender;

@end

@implementation LoginOrRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.registerBtn.clipsToBounds = YES;
    self.registerBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.registerBtn.layer.borderWidth = 1.0f;
    self.registerBtn.layer.cornerRadius = 5.0f;
    
    self.loginBtn.clipsToBounds = YES;
    self.loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginBtn.layer.borderWidth = 1.0f;
    self.loginBtn.layer.cornerRadius = 5.0f;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerAction:(id)sender {
    RegisterAccountViewController *view = [[RegisterAccountViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)loginAction:(id)sender {
    AccountLoginViewController *view = [[AccountLoginViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}
@end
