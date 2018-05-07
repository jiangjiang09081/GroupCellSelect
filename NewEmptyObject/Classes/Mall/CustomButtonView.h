//
//  CustomButtonView.h
//  CleverScape
//
//  Created by jiang on 2018/4/29.
//  Copyright © 2018年 klpy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButtonView : UIView

@property (nonatomic, copy) void(^bodyfoldBlock)(BOOL isbodyfoldSelect, BOOL isSubFold);
@property (nonatomic, strong) NSString *title;//标题
@property (nonatomic, strong) UIColor *color;//未点击颜色
@property (nonatomic, strong) UIColor *selectColor;//点击颜色
@property (nonatomic) BOOL isSecondFold;//是否折叠

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic) BOOL isUpdate;

@end
