//
//  CustomSecondView.m
//  NewEmptyObject
//
//  Created by Mac on 2018/5/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CustomSecondView.h"
@interface CustomSecondView()

@property (nonatomic, strong) UIView *thirdBodyView;

@end
@implementation CustomSecondView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubUI];
    }
    return self;
}

- (void)addSubUI{
    _thirdBodyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frameWidth, 0)];
    _thirdBodyView.backgroundColor = [UIColor blueColor];
    _thirdBodyView.clipsToBounds = YES;
//    _thirdBodyView.hidden = YES;
    [self addSubview:_thirdBodyView];
}

- (void)setcontentWithData:(NSArray *)dataArr{
    [_thirdBodyView removeAllSubviews];
    if (dataArr.count > 0) {
        for (NSInteger i = 0; i < dataArr.count; i++) {
            id content = dataArr[i];
            CustomButtonView *contentButton = [[CustomButtonView alloc] initWithFrame:CGRectMake(0, i * kAdaptor(40), self.frameWidth, kAdaptor(40))];
            contentButton.color = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
            contentButton.selectColor = [UIColor colorWithRed:72/255.0 green:159/255.0 blue:233/255.0 alpha:1];
            if ([content isKindOfClass:[NSDictionary class]]) {
                contentButton.isSecondFold = YES;
                contentButton.title = [content objectForKey:@"subtitle"];
            } else{
                contentButton.isSecondFold = NO;
                contentButton.title = content;
            }
            __weak __typeof(self) weakSelf = self;
            contentButton.bodyfoldBlock = ^(BOOL isbodyfoldSelect, BOOL isSubFold) {
                NSInteger i = 0;
                for (id but in weakSelf.subviews) {
                    if ([but isKindOfClass:[CustomButtonView class]]) {
                        CustomButtonView *cusbut = but;//循环列表button
                        if (cusbut == contentButton) {//是当前点击的button
                            if (isSubFold) {//点击折叠的 折叠又分折叠展开与折叠关闭
                                _MUser.isSecondFold = YES;
                                if (isbodyfoldSelect) {//折叠展开
                                    _MUser.isZhankai = YES;
                                    cusbut.isSelect = YES;//999是默认展开折叠但是不点击第三层
                                    weakSelf.subButtonClickBlock ? weakSelf.subButtonClickBlock(cusbut.tag - 66, 999) : nil;
                                    i = cusbut.tag;
                                    weakSelf.thirdBodyView.hidden = NO;
                                    id content = dataArr[cusbut.tag - 66];
                                    NSArray *contentSubArr = [content objectForKey:@"subArr"];
                                    for (NSInteger j = 0; j < contentSubArr.count; j++) {
                                        CustomButtonView *contentSubButton = [[CustomButtonView alloc] initWithFrame:CGRectMake(0, j * kAdaptor(40), self.thirdBodyView.frameWidth, kAdaptor(40))];
                                        contentSubButton.color = [UIColor grayColor];
                                        contentSubButton.selectColor = [UIColor greenColor];
                                        contentSubButton.tag = 777 + j;
                                        contentSubButton.bodyfoldBlock = ^(BOOL isbodyfoldSelect, BOOL isSubFold) {
                                            for (CustomButtonView *thirdbut in weakSelf.thirdBodyView.subviews) {
                                                if (thirdbut == contentSubButton) {
                                                    _MUser.isSecondFold = YES;
                                                    _MUser.isZhankai = YES;
                                                    thirdbut.isSelect = YES;
                                                    weakSelf.subButtonClickBlock ? weakSelf.subButtonClickBlock(cusbut.tag - 66, thirdbut.tag - 777) : nil;
                                                } else {
                                                    thirdbut.isSelect = NO;
                                                }
                                            }
                                        };
                                        contentSubButton.title = contentSubArr[j];
                                        [self.thirdBodyView addSubview:contentSubButton];
                                    }
                                    CustomButtonView *thirdBut = [weakSelf.thirdBodyView viewWithTag:[_MUser.thirdIndex integerValue] + 777];
                                    if (thirdBut) {
                                        thirdBut.isSelect = YES;
                                    } else {
                                        thirdBut.isSelect = NO;
                                    }
                                    weakSelf.thirdBodyView.frameHeight = kAdaptor(40) * contentSubArr.count;
                                    weakSelf.thirdBodyView.frameY = CGRectGetMaxY(cusbut.frame);
                                    weakSelf.frameHeight = kAdaptor(40)*dataArr.count + weakSelf.thirdBodyView.frameHeight;
                                } else {//折叠关闭
                                    i = cusbut.tag;
                                    weakSelf.thirdBodyView.frameHeight = 0;
                                    _MUser.isZhankai = NO;
                                    cusbut.isSelect = NO;
                                    weakSelf.frameHeight = kAdaptor(40)*dataArr.count;
                                    weakSelf.subButtonClickBlock ? weakSelf.subButtonClickBlock(cusbut.tag - 66, 10000) : nil;
                                }
                            } else {//点击的不是折叠的
                                _MUser.isSecondFold = NO;
                                _MUser.isZhankai = NO;
                                cusbut.isSelect = YES;
                                weakSelf.thirdBodyView.frameHeight = 0;
                                cusbut.frameY = (cusbut.tag - 66) * kAdaptor(40);
                                weakSelf.frameHeight = kAdaptor(40)*dataArr.count;
                                weakSelf.subButtonClickBlock ? weakSelf.subButtonClickBlock(contentButton.tag - 66, 10000) : nil;
                            }
                        } else {//不是当前点击的button
                            cusbut.isSelect = NO;
                            if (isSubFold) {//如果当前是显示的折叠的情况
                                if (isbodyfoldSelect) {//折叠展开
                                    if (i != 0 && cusbut.tag > i) {
                                        cusbut.frameY = kAdaptor(40) * (cusbut.tag - 66) + weakSelf.thirdBodyView.frameHeight;
                                    }
                                }else{//折叠关闭
                                    if (i != 0 && cusbut.tag > i) {
                                        cusbut.frameY = (cusbut.tag - 66) * kAdaptor(40);
                                    }
                                }
                            }else{//不是折叠情况
                                if (weakSelf.thirdBodyView.frameHeight > 0) {
                                    if (i != 0 && cusbut.tag > i) {
                                        cusbut.frameY = (cusbut.tag - 66) * kAdaptor(40);
                                    }
                                } else {
                                    cusbut.frameY = (cusbut.tag - 66) * kAdaptor(40);
                                }
                            }
                        }
                    }
                }
            };
            contentButton.tag = 66 + i;
            [self addSubview:contentButton];
        }
        CustomButtonView *but = [self viewWithTag:[_MUser.secondIndex integerValue] + 66];
        if (but) {
            but.isUpdate = YES;
        }
    }
}

+(CGFloat)calculateHeightWithData:(NSArray *)dataArr WithSelectIndex:(NSInteger)index{
    CGFloat height = 0;
    if (dataArr.count > 0) {
        height += kAdaptor(40) * dataArr.count;
        if (index != 10000) {
            id content = dataArr[index];
            if ([content isKindOfClass:[NSDictionary class]]) {
                NSArray *contentSubArr = [content objectForKey:@"subArr"];
                height += kAdaptor(40) * contentSubArr.count;
            }
        }
    }
    return height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
