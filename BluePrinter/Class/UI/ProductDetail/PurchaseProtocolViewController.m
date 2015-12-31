//
//  PurchaseProtocolViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/28.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "PurchaseProtocolViewController.h"
#import "PaymentViewController.h"

@interface PurchaseProtocolViewController ()<UIWebViewDelegate>
@property (nonatomic, weak) IBOutlet    UIWebView       *webview;
@property (nonatomic, strong) FinancialProduct          *curProduct;
- (IBAction)agreenAction:(id)sender;
@end

@implementation PurchaseProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"产品合同"];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.yahoo.com"]]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [LoadingHUD hide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithProduct:(FinancialProduct *)product
{
    self = [super init];
    
    if (self)
    {
        self.curProduct = product;
    }
    
    return self;
}

- (IBAction)agreenAction:(id)sender
{
    PaymentViewController *view = [[PaymentViewController alloc] initWithProduct:self.curProduct];
    [self.navigationController pushViewController:view animated:YES];
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
