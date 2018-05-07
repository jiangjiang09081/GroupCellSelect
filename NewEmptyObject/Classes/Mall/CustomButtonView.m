//
//  CustomButtonView.m
//  CleverScape
//
//  Created by jiang on 2018/4/29.
//  Copyright © 2018年 klpy. All rights reserved.
//

#import "CustomButtonView.h"
@interface CustomButtonView()

@property (nonatomic, strong) UIButton *bodyButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightImg;

@end
@implementation CustomButtonView
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

- (void)setTitle:(NSString *)title{
    _title = title;
    [_bodyButton setTitle:_title forState:UIControlStateNormal];
    _bodyButton.backgroundColor = _color;
}

- (void)addSubUI{
    UIButton *bodyButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _bodyButton = bodyButton;
    bodyButton.tag = 6;
    [bodyButton addTarget:self action:@selector(bodyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bodyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bodyButton.titleLabel.font = KFontSize(13);
    [self addSubview:_bodyButton];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAdaptor(20), 0, kAdaptor(80), bodyButton.frame.size.height)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = KFontSize(13);
    [bodyButton addSubview:_titleLabel];
    _rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(bodyButton.frame.size.width - kAdaptor(26), kAdaptor(15), kAdaptor(8), kAdaptor(12))];
    _rightImg.image = [UIImage imageNamed:@"跳转icon"];
    _rightImg.highlightedImage = [UIImage imageNamed:@"向下icon"];
    _rightImg.hidden = YES;
    [bodyButton addSubview:_rightImg];
    UIView *linview = [[UIView alloc] initWithFrame:CGRectMake(0, kAdaptor(39), _bodyButton.frameWidth, 1)];
    linview.backgroundColor = [UIColor whiteColor];
    [_bodyButton addSubview:linview];
}

- (void)bodyButtonClick:(UIButton *)button{
    if (button) {
        _bodyButton.selected = !button.selected;
    }
    if (_bodyButton.selected) {
        _bodyButton.backgroundColor = _selectColor;
        _rightImg.highlighted = YES;
    } else {
        _rightImg.highlighted = NO;
        _bodyButton.backgroundColor = _color;
    }
    self.bodyfoldBlock ? self.bodyfoldBlock(_bodyButton.selected, _isSecondFold) : nil;
}

- (void)setIsSecondFold:(BOOL)isSecondFold{
    _isSecondFold = isSecondFold;
    if (_isSecondFold) {
        _rightImg.hidden = NO;
    } else{
        _rightImg.hidden = YES;
    }
}

- (void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    _bodyButton.selected = _isSelect;
    if (_bodyButton.selected) {
        _rightImg.highlighted = YES;
        _bodyButton.backgroundColor = _selectColor;
    }else{
        _rightImg.highlighted = NO;
        _bodyButton.backgroundColor = _color;
    }
}

- (void)setIsUpdate:(BOOL)isUpdate{
    _isUpdate = isUpdate;
    if (_isUpdate) {
        if (_MUser.isSecondFold) {//点击折叠的
            if (_MUser.isZhankai) {//折叠展开,但是不点击第三层
                if ([_MUser.secondIndex integerValue] != 10000) {
                    _isSelect = YES;
                    _bodyButton.selected = _isSelect;
                    self.bodyfoldBlock ? self.bodyfoldBlock(_bodyButton.selected, _MUser.isSecondFold) : nil;
                }
            } else {//折叠关闭
                if ([_MUser.secondIndex integerValue] != 10000) {
                    _isSelect = YES;
                    _bodyButton.selected = NO;
                    self.bodyfoldBlock ? self.bodyfoldBlock(_bodyButton.selected, _MUser.isSecondFold) : nil;
                }
            }
        } else {//点击不是折叠的
            _isSelect = YES;
            _bodyButton.selected = _isSelect;
            self.bodyfoldBlock ? self.bodyfoldBlock(_bodyButton.selected, _MUser.isSecondFold) : nil;
        }
    }
}

- (void)setSelectColor:(UIColor *)selectColor{
    _selectColor = selectColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
