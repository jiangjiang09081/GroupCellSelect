//
//  MallViewController.m
//  NewEmptyObject
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MallViewController.h"
#import "MainTableViewCell.h"
@interface MallViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tab;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *seleArray;

@end

@implementation MallViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _seleArray = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商城";
    [self addSUb];
    // Do any additional setup after loading the view.
}

- (void)addSUb{
    _dataArr = @[@{@"image" : @"查看图片", @"name": @"查看图片", @"contentArr":@[@"正白光",
                                                                         @{@"subtitle" :@"紫外光", @"subArr":@[@"皱纹",@"光泽度",@"透明度",@"睫毛",@"轮廓"]},
                                                                         @"偏振 (平行)",
                                                                         @"偏振 (交叉)",
                                                                         @"紫外线色斑",
                                                                         @{@"subtitle" :@"红色分析", @"subArr":@[@"皱纹",@"光泽度",@"透明度"]},
                                                                         @"棕色分析",
                                                                         @"综览图"]},
                 @{@"image" : @"成像对照",@"name": @"成像对照"},
                 @{@"image" : @"下载报告",@"name": @"下载报告", @"contentArr":@[@"综合报告",
                                                                        @"棕色分析",
                                                                        @"色斑",
                                                                        @"紫外线色斑",
                                                                        @"红色分析",
  @{@"subtitle" :@"毛孔", @"subArr":@[@"皱纹",@"光泽度",@"透明度",@"睫毛",@"轮廓"]},
                                                                        @"皱纹",
                                                                        @"光泽度",
                                                                        @"透明度",
                                                                        @"睫毛",
                                                                        @"轮廓",
                                                                        @"平滑度",
                                                                        @"痤疮",@"唇纹"]},
                 @{@"image" : @"结果对比",@"name": @"结果对比"},
                 @{@"image" : @"相关干预",@"name": @"相关干预"},
                 @{@"image" : @"智能评估",@"name": @"智能评估"}];
    _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kAdaptor(250), MainHeight - 49) style:UITableViewStylePlain];
    _tab.backgroundColor = [UIColor whiteColor];
    _tab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tab.delegate = self;
    _tab.dataSource = self;
    self.tab.estimatedRowHeight =0;
    self.tab.estimatedSectionHeaderHeight =0;
    self.tab.estimatedSectionFooterHeight =0;
    [self.view addSubview:_tab];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
    if (!cell) {
        cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineCell"];
    }
    BOOL click = NO;
    BOOL isfold = NO;
    NSString *secondIndex = nil;
    NSString *thirdIndex  = nil;
    for (NSDictionary *dic in _seleArray) {
        NSString *str = [dic objectForKey:@"index"];
        if ([str integerValue] == indexPath.row) {
            secondIndex = [dic objectForKey:@"SecondIndex"];
            thirdIndex = [dic objectForKey:@"thirdIndex"];
            isfold = [[dic objectForKey:@"fold"] boolValue];
            click = YES;
            break;
        }
    }
    cell.isFolding = isfold;
    cell.isSelect = click;
    cell.secondIndex = secondIndex;
    cell.thirdIndex = thirdIndex;
    cell.bodyButtonBlock = ^(BOOL select, BOOL isFold, NSInteger secondIndex, NSInteger thirdIndex) {
        if (select) {
            [self.seleArray removeAllObjects];
            [self.seleArray addObject:@{@"index": [NSString stringWithFormat:@"%ld", (long)indexPath.row], @"fold": [NSString stringWithFormat:@"%d", isFold], @"SecondIndex": [NSString stringWithFormat:@"%ld", (long)secondIndex], @"thirdIndex": [NSString stringWithFormat:@"%ld", (long)thirdIndex]}];
            if (!isFold) {
                [self selectAtIndex:indexPath.row];
            }
        } else {
            NSArray *array = [NSArray arrayWithArray:self.seleArray];
            for (NSDictionary *dic in array) {
                NSString *str = [dic objectForKey:@"index"];
                if ([str integerValue] == indexPath.row) {
                    [self.seleArray removeObject:dic];
                }
            }
        }
        [self.tab reloadData];
    };
    cell.contentClickBlock = ^(NSInteger index) {
        NSLog(@"点击里面模块%ld", (long)index);
        [self selectSubIndex:index withcellIndex:indexPath.row];
    };
    cell.contentThirdClickBlock = ^(NSInteger index) {
        NSLog(@"第三层点击事件%ld", (long)index);
    };
    [cell getContentWithData:_dataArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)selectSubIndex:(NSInteger)subIndex withcellIndex:(NSInteger)index{
     //subIndex点击的里面子模块 index 当前的cell
    switch (index) {//判断点击的cell是第几
        case 0:
        {
            if (subIndex == 0) {
                
            } else if (subIndex == 1){
                
            }
        }
        case 1:{
            if (subIndex == 0) {
                
            } else if (subIndex == 1){
                
            }
        }
            break;
        default:
            break;
    }
}

- (void)selectAtIndex:(NSInteger)index{
    NSLog(@"点击不是折叠的%ld", (long)index);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    for (NSDictionary *dic in _seleArray) {
        NSString *str = [dic objectForKey:@"index"];
        NSString *fold = [dic objectForKey:@"fold"];
        NSInteger secondIndex = [[dic objectForKey:@"SecondIndex"] integerValue];
        if ([str integerValue] == indexPath.row && [fold integerValue] == 1){
            if (_MUser.isZhankai) {//折叠展开
              return [MainTableViewCell calculateHeightWithData:_dataArr[indexPath.row] withIndex:secondIndex];
            } else {
              return [MainTableViewCell calculateHeightWithData:_dataArr[indexPath.row] withIndex:10000];
            }
            
        }else {
            return kAdaptor(45);
        }
    }
    return kAdaptor(45);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
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
