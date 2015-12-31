//
//  RiskDisclosureViewController.m
//  LittleFawn
//
//  Created by klozz on 15/12/27.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "RiskDisclosureViewController.h"

@interface RiskDisclosureViewController ()
@property (nonatomic, weak) IBOutlet        UIWebView       *webview;
@end

@implementation RiskDisclosureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"风险提示"];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.163.com"]]];
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

@end
