//
//  RegisterProtocolViewController.m
//  BluePrinter
//
//  Created by klozz on 15/12/23.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "RegisterProtocolViewController.h"

@interface RegisterProtocolViewController ()<UIWebViewDelegate>
@property (nonatomic, weak) IBOutlet        UIWebView       *webView;
@end

@implementation RegisterProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"协议"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cctv.com"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
