//
//  YT_TabBarController.m
//  interview
//
//  Created by 于波 on 16/3/20.
//  Copyright © 2016年 于波. All rights reserved.
//

#import "YT_TabBarController.h"
#import "YT_HomeController.h"
#import "YT_InvestorController.h"
#import "YT_CreateForMeController.h"
#import "YT_InvestorForMeController.h"
#import "YT_NavigationController.h"
#import "UITabBar+YBbadge.h"

@interface YT_TabBarController ()

@end

@implementation YT_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTabBarItem];
}

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //    childVC.tabBarItem.title = title;
    //    childVC.navigationItem.title = title;
    childVC.title = title;
    
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor grayColor];
    [childVC.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedDic = [NSMutableDictionary dictionary];
    selectedDic[NSForegroundColorAttributeName] = YT_ColorFromRGB(0x39a16a);
    [childVC.tabBarItem setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
    
    YT_NavigationController *nav = [[YT_NavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}

- (void)creatTabBarItem
{
    YT_HomeController *homeVC = [[YT_HomeController alloc] init];
    [self addChildVC:homeVC title:@"主页" image:@"zhuyehuise" selectedImage:@"zhuyelvse"];
    
    YT_InvestorController *investorVC = [[YT_InvestorController alloc] init];
    [self addChildVC:investorVC title:@"投资人" image:@"touzirenhuise" selectedImage:@"touzirenlvse"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"ID"] isEqualToString:@"touzi"]) {
        YT_InvestorForMeController *investorForMeVC = [[YT_InvestorForMeController alloc] init];
        [self addChildVC:investorForMeVC title:@"我" image:@"wohuise" selectedImage:@"wolvse"];
    }else{
        YT_CreateForMeController *createForMeVC = [[YT_CreateForMeController alloc] init];
        [self addChildVC:createForMeVC title:@"我" image:@"wohuise" selectedImage:@"wolvse"];
    }
    
    
}

@end
