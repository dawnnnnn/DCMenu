//
//  ViewController.m
//  DNPullDownMenu
//
//  Created by dawnnnnn on 15/12/18.
//  Copyright © 2015年 dawnnnnn. All rights reserved.
//

#import "ViewController.h"
#import "DNPullDownMenu.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (nonatomic, strong) DNPullDownMenu *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    NSArray *arr = @[@"全部", @"签到奖励", @"邀请好友奖励", @"兑换(零钱)"];
    self.menu = [[DNPullDownMenu alloc]initWithItems:arr];
    __weak typeof(&*self) weakSelf = self;
    self.menu.itemSelected = ^(NSInteger tag) {
        NSLog(@"选择了第%ld个",tag);
        __strong typeof(&*weakSelf) strongSelf = weakSelf;
        [strongSelf.titleBtn setTitle:arr[tag] forState:UIControlStateNormal];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pullMenu:(id)sender {
    
    if (self.menu.isOpen) {
        [self.menu close];
    }
    else {
        [self.menu open:self.view];
        [self.view sendSubviewToBack:self.myTableView];
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hahaha" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
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
