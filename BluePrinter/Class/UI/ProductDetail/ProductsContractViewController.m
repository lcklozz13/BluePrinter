//
//  ProductsContractViewController.m
//  LittleFawn
//
//  Created by klozz on 15/12/26.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "ProductsContractViewController.h"

@interface ProductsContractViewController ()<UIWebViewDelegate>
@property (nonatomic, weak) IBOutlet        UIWebView       *webView;
@end

@implementation ProductsContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"产品合同"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.sina.com"]]];
    
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
