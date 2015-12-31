//
//  GuidViewController.m
//  LittleFawn
//
//  Created by baidu on 15/12/21.
//  Copyright © 2015年 com.xhj001. All rights reserved.
//

#import "GuidViewController.h"

@interface GuidViewController ()
@property (nonatomic, weak) IBOutlet   UIScrollView         *myScrollView;
@end

@implementation GuidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initScrollView];
}

- (void)initScrollView
{
    CGSize Screen = [UIScreen mainScreen].bounds.size;
    [self.myScrollView setContentSize:CGSizeMake(Screen.width * 3, Screen.height)];
    
    for (int i=0; i<3; i++)
    {
        UIImageView *leadView = [[UIImageView alloc] initWithFrame:CGRectMake(i*Screen.width, 0, Screen.width, Screen.height)];
        [leadView setImage:[UIImage imageNamed:[[NSString alloc] initWithFormat:@"lead%d",i+1]]];
        
        if (i == 2)
        {
            UIImage *bg = [UIImage imageNamed:@"btn-lead"];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((Screen.width-bg.size.width)/2, Screen.height-86-bg.size.height, bg.size.width, bg.size.height)];
            [button setBackgroundImage:bg forState:UIControlStateNormal];
            [button setTitle:@"开启自由理财" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
            [button addTarget:self action:@selector(gotoMain) forControlEvents:UIControlEventTouchUpInside];
            [leadView addSubview:button];
            leadView.userInteractionEnabled = YES;
        }
        
        [self.myScrollView addSubview:leadView];
    }
}

- (void)gotoMain
{
    [[PublicMethods getKeyWindow] setRootViewController:[[ViewControllerManager getInstance] getRootViewController]];
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

@end
