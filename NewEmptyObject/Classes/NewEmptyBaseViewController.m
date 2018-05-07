//
//  NewEmptyBaseViewController.m
//  NewEmptyObject
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NewEmptyBaseViewController.h"

@interface NewEmptyBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation NewEmptyBaseViewController

- (void)loadView{
    [super loadView];
    self.view.opaque = NO;
    self.view.backgroundColor = HEXCOLOR(0xffffff);
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController) {
        self.view.backgroundColor = HEXCOLOR(0xecebf0);
        if (self.navigationController) {
            if ([[self.navigationController viewControllers] count] > 1) {
                self.navigationController.delegate = self;
                UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
                negativeSpacer.width = -18;
                UIButton *butt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
                butt.backgroundColor = [UIColor clearColor];
                [butt setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
                [butt setTitle:@" 返回" forState:UIControlStateNormal];
                [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                butt.titleLabel.font = [UIFont systemFontOfSize:17];;
                [butt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
                UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:butt];
                if (IS_IOS11_OR_HIGHER) {
                    butt.contentEdgeInsets =UIEdgeInsetsMake(0, -20,0, 0);
                    self.navigationItem.leftBarButtonItem = backBtn;
                }
                else{
                    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backBtn];
                }
                self.navigationController.interactivePopGestureRecognizer.enabled = YES;
                self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
            }
            else{
                self.navigationController.interactivePopGestureRecognizer.enabled = NO;
            }
        }
    }
    // Do any additional setup after loading the view.
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
