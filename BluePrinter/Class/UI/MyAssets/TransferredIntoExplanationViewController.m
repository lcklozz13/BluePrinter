//
//  TransferredIntoExplanationViewController.m
//  LittleFawn
//
//  Created by baidu on 16/1/11.
//  Copyright © 2016年 com.xhj001. All rights reserved.
//

#import "TransferredIntoExplanationViewController.h"
#import "TransferredIntoExplanationCell.h"

@interface TransferredIntoExplanationViewController ()
@property (weak, nonatomic) IBOutlet    UITableView *tableview;
@property (assign, nonatomic) ViewType  curType;
@end

@implementation TransferredIntoExplanationViewController

- (id)initWithViewType:(ViewType)type
{
    self = [super init];
    
    if (self)
    {
        self.curType = type;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.curType == ViewTyp_turnInto)
    {
        self.title = @"转入说明";
    }
    else
    {
        self.title = @"转出说明";
    }
    
    [self tableView:self.tableview registionReuseIdentifierWithNibName:@"TransferredIntoExplanationCell" forCellOrHeaderFootViewFlag:YES];
    self.tableview.tableFooterView = [[UIView alloc] init];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TransferredIntoExplanationCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TransferredIntoExplanationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransferredIntoExplanationCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0)
    {
        [cell.textLabel setText:@"中国建设银行储蓄卡（尾号4587）"];
        [cell.detailTextLabel setText:@"单笔10，000 单日50，000 单月100，000"];
    }
    else if (indexPath.row == 1)
    {
        [cell.textLabel setText:@"中国工商银行储蓄卡（尾号4587）"];
        [cell.detailTextLabel setText:@"单笔10，000 单日50，000 单月100，000"];
    }
    
    return cell;
    
}

@end
