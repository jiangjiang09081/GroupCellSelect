//
//  CustomSecondView.h
//  NewEmptyObject
//
//  Created by Mac on 2018/5/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButtonView.h"
@interface CustomSecondView : UIView

@property (nonatomic, strong) NSString *secondIndex;

- (void)setcontentWithData:(NSArray *)dataArr;

+ (CGFloat)calculateHeightWithData:(NSArray *)dataArr WithSelectIndex:(NSInteger)index;

//第二层不折叠的点击回调 //第三层点击回调
@property (nonatomic, copy) void(^subButtonClickBlock)(NSInteger secondIndex, NSInteger thirdIndex);


@end
