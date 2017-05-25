//
//  YYBaseNavViewController.m
//  YYCommentResponseDemo
//
//  Created by Ryan on 2017/5/25.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYBaseNavViewController.h"

@interface YYBaseNavViewController ()

@end

@implementation YYBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationBar.barStyle = UIBarStyleBlack;
    
    CGFloat rgb = 0.1;
    self.navigationBar.barTintColor =  [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
    
    //    UINavigationBar *bar = [UINavigationBar appearance];
//    CGFloat rgb = 0.1;
//    bar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
//    bar.tintColor = [UIColor whiteColor];
//    bar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count >= 1) {
        
        viewController.hidesBottomBarWhenPushed = true;
    }
    
    [super pushViewController:viewController animated:true];
}

@end



























