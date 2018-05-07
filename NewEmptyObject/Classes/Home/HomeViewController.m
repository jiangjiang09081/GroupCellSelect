//
//  HomeViewController.m
//  NewEmptyObject
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomLeftView.h"
@interface HomeViewController ()

@property (nonatomic, strong) CustomLeftView *tabView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSub];
    // Do any additional setup after loading the view.
}

- (void)addSub{
    _dataArr = @[@{@"image" : @"商城", @"select" : @"商城选中", @"name": @"首页"},
                 @{@"image" : @"商城", @"select" : @"商城选中",@"name": @"创建"},
                 @{@"image" : @"商城", @"select" : @"商城选中",@"name": @"查找"},
                 @{@"image" : @"商城", @"select" : @"商城选中",@"name": @"设置"},
                 @{@"image" : @"商城", @"select" : @"商城选中",@"name": @"退出"}];
    _tabView = [[CustomLeftView alloc] initWithFrame:CGRectMake(0, 0, kAdaptor(80), MainHeight)];
    _tabView.backgroundColor = HEXCOLOR(0xecebf0);
    _tabView.array = _dataArr;
    _tabView.selectIndex = 2;
    _tabView.selectIndexBlock = ^(NSInteger index) {
        //点击哪个对应哪个按钮
    };
    [self.view addSubview:_tabView];
    NSLog(@"%@", testmine);
}

- (void)selectWithIndex:(NSInteger)index{
    
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
