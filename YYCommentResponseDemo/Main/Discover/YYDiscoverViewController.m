//
//  YYDiscoverViewController.m
//  YYCommentResponseDemo
//
//  Created by Ryan on 2017/5/25.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYDiscoverViewController.h"
#import "YYCommentViewController.h"

@interface YYDiscoverViewController () <UITableViewDelegate,UITableViewDataSource>

/* <#description#> */
@property (nonatomic,strong) YYCommentViewController *commentCtrl;

/* <#description#> */
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation YYDiscoverViewController

- (YYCommentViewController *)commentCtrl {
    if (_commentCtrl == nil) {
        _commentCtrl = [[YYCommentViewController alloc] init];
    }
    return _commentCtrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.view);//可以使头部不分离
    }];
}

//MARK:- TableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *discoverCellIdentifier = @"discoverCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:discoverCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:discoverCellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"discover_showalbum"];
                cell.textLabel.text = @"朋友圈";
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"discover_code"];
                cell.textLabel.text = @"扫一扫";
            } else {
                cell.imageView.image = [UIImage imageNamed:@"discover_shake"];
                cell.textLabel.text = @"摇一摇";
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"discover_location"];
                cell.textLabel.text = @"附近的人";
            }
            break;
        case 3:
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"discover_shake"];
                cell.textLabel.text = @"购物";
            } else {
                cell.imageView.image = [UIImage imageNamed:@"discover_game"];
                cell.textLabel.text = @"游戏";
            }
            break;
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 42;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return kAlmostZero;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:self.commentCtrl animated:true];
    }
}


@end








































