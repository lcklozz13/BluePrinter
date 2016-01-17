//
//  AboutUsViewController.m
//  LittleFawn
//
//  Created by baidu on 16/1/14.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UIWebViewDelegate>
@property (nonatomic, weak) IBOutlet        UIWebView       *webView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"关于我们"];
    // Do any additional setup after loading the view from its nib.
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baiwanmoney.com"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction
{
    if (self.navigationController.viewControllers.count == 1)
    {
        [self.parentViewController dismissViewControllerAnimated:YES completion:^{
            [[ViewControllerManager getInstance] setLoginSuccessBackViewController:nil];
        }];
    }
    else
    {
        [super backAction];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [LoadingHUD hide];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [LoadingHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [LoadingHUD hide];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [LoadingHUD hide];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
