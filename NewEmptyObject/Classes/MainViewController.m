//
//  MainViewController.m
//  NewEmptyObject
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MallViewController.h"
#import "MineViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)launchFirstController{
    //有几个tabbar就创建几个文件夹,比如首页,商城,我的,要英文对应,都继承自NewEmptyBaseViewController
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"首页"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"首页选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *mallNav = [[UINavigationController alloc] initWithRootViewController:[[MallViewController alloc] init]];
    mallNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"商城" image:[[UIImage imageNamed:@"商城"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"商城选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:[[MineViewController alloc] init]];
    mineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"我的"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"我的选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.viewControllers = @[homeNav, mallNav, mineNav];
    for (UITabBarItem *item in self.tabBar.items) {
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor] ,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    self.tabBar.translucent = NO;
    self.selectedIndex = 0;
    _APP.window.rootViewController = self;
    [_APP.window makeKeyAndVisible];
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
