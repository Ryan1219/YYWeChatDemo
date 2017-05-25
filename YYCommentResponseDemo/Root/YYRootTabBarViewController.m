//
//  YYRootTabBarViewController.m
//  YYCommentResponseDemo
//
//  Created by Ryan on 2017/5/25.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYRootTabBarViewController.h"
#import "YYBaseNavViewController.h"

#define kClassKey @"classNameString"
#define kTitleKey @"classTitleStirng"
#define kImageKey @"classImageString"
#define kSelectImageKey @"SelectImageStirng"

@interface YYRootTabBarViewController ()

@end

@implementation YYRootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 字典数组
    NSArray *childArray = @[
                            @{
                                kClassKey:@"YYHomeViewController",
                                kTitleKey:@"微信",
                                kImageKey:@"tabbar_home",
                                kSelectImageKey : @"tabbar_home_select"
                                },
                            @{
                                kClassKey:@"YYAddressBookViewController",
                                kTitleKey:@"通讯录",
                                kImageKey:@"tabbar_contacts",
                                kSelectImageKey : @"tabbar_contacts_select"
                                },
                            @{
                                kClassKey:@"YYDiscoverViewController",
                                kTitleKey:@"发现",
                                kImageKey:@"tabbar_discover",
                                kSelectImageKey : @"tabbar_discover_select"
                                },
                            @{
                                kClassKey:@"YYMeViewController",
                                kTitleKey:@"我",
                                kImageKey:@"tabbar_me",
                                kSelectImageKey : @"tabbar_me_select"
                                }
                            ];
    
    [childArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dict = obj;
        UIViewController *viewCtrl = [[NSClassFromString(dict[kClassKey]) alloc] init];
        viewCtrl.title = dict[kTitleKey];
        
        YYBaseNavViewController *nav = [[YYBaseNavViewController alloc] initWithRootViewController:viewCtrl];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImageKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelectImageKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:kThemeColor} forState:UIControlStateSelected];
        [self addChildViewController:nav];
        
    }];
}


@end








































