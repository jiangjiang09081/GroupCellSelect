//
//  MainTableViewCell.m
//  NewEmptyObject
//
//  Created by Mac on 2018/4/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MainTableViewCell.h"
#import "CustomButtonView.h"
#import "CustomSecondView.h"
#define mallTopHeight 12
#define mallCellHeight 45
@interface MainTableViewCell()

@property (nonatomic, strong) UIView *bodyView;
@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightImg;
@property (nonatomic, strong) CustomSecondView *subView;
@property (nonatomic, strong) UIButton *bodyButton;

@property (nonatomic) CGFloat subHeight;

@end
@implementation MainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubUI];
    }
    return self;
}

- (void)bodyButtonClick:(UIButton *)button{
    _bodyButton.selected = !button.selected;
    if (_bodyButton.selected) {
        _bodyButton.backgroundColor = [UIColor colorWithRed:72/255.0 green:159/255.0 blue:233/255.0 alpha:1];
    }else{
        _bodyButton.backgroundColor = [UIColor clearColor];
    }
    self.bodyButtonBlock ? self.bodyButtonBlock(button.selected, _isFolding, 10000, 10000): nil;
    if (_isSelect && _isFolding && _isSecondFold) {
        _bodyView.frameHeight = _bodyButton.frameHeight + _subHeight;
        _rightImg.highlighted = YES;
    } else if (_isSelect && _isFolding && !_isSecondFold){
        _bodyView.frameHeight = _bodyButton.frameHeight + _subHeight;
        _rightImg.highlighted = YES;
    } else{
        _bodyView.frameHeight = _bodyButton.frameHeight;
        _rightImg.highlighted = NO;
    }
}

- (void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    _bodyButton.selected = _isSelect;
    if (_bodyButton.selected) {
        _bodyButton.backgroundColor = [UIColor colorWithRed:72/255.0 green:159/255.0 blue:233/255.0 alpha:1];
    }else{
        _bodyButton.backgroundColor = [UIColor clearColor];
    }
    if (_isSelect && _isFolding) {
        _bodyView.frameHeight = _bodyButton.frameHeight + _subHeight;
        _rightImg.highlighted = YES;
    }  else{
        _bodyView.frameHeight = _bodyButton.frameHeight;
        _rightImg.highlighted = NO;
    }
}

- (void)setSecondIndex:(NSString *)secondIndex{
    _secondIndex = secondIndex;
    if (_isSelect) {
        _MUser.secondIndex = _secondIndex;
    }else{
        _MUser.isSecondFold = NO;
        _MUser.secondIndex = @"10000";
    }
}

- (void)setThirdIndex:(NSString *)thirdIndex{
    _thirdIndex = thirdIndex;
    if (_isSelect) {
        _MUser.thirdIndex = thirdIndex;
    }else{
        _MUser.thirdIndex = @"10000";
    }
}

- (void)addSubUI{
    _bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAdaptor(250), kAdaptor(mallCellHeight))];
    _bodyView.backgroundColor = [UIColor whiteColor];
    _bodyView.clipsToBounds = YES;
    [self addSubview:_bodyView];
    UIButton *bodyButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _bodyView.frame.size.width, _bodyView.frame.size.height)];
    _bodyButton = bodyButton;
    bodyButton.backgroundColor = [UIColor clearColor];
    [bodyButton addTarget:self action:@selector(bodyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bodyView addSubview:_bodyButton];
    _leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(kAdaptor(10), kAdaptor(15), kAdaptor(20), kAdaptor(20))];
    //_leftImg.backgroundColor = [UIColor redColor];
    [bodyButton addSubview:_leftImg];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImg.frame) + kAdaptor(20), 0, kAdaptor(80), bodyButton.frame.size.height)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = KFontSize(13);
    [bodyButton addSubview:_titleLabel];
    _rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(bodyButton.frame.size.width - kAdaptor(26), _leftImg.frame.origin.y, kAdaptor(8), kAdaptor(12))];
    _rightImg.image = [UIImage imageNamed:@"跳转icon"];
    _rightImg.highlightedImage = [UIImage imageNamed:@"向下icon"];
    [bodyButton addSubview:_rightImg];
}

- (void)getContentWithData:(NSDictionary *)data{
    [_subView removeFromSuperview];
    _leftImg.image = [[UIImage imageNamed:[data objectForKey:@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _titleLabel.text = [data objectForKey:@"name"];
    NSArray *contentArr = [data objectForKey:@"contentArr"];
    if (contentArr.count > 0) {
       CustomSecondView *subView = [[CustomSecondView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_bodyButton.frame), _bodyView.frame.size.width, 0)];
        subView.backgroundColor = [UIColor clearColor];
        _subView = subView;
        [_bodyView addSubview:subView];
        _isFolding = YES;
        [subView setcontentWithData:contentArr];
        __weak __typeof(self) weakSelf = self;
        //10000就相当于是空数据 因为NSInterger默认nil是0
        subView.subButtonClickBlock = ^(NSInteger secondIndex, NSInteger thirdIndex) {
            if (secondIndex != 10000 && thirdIndex == 10000) {
                weakSelf.contentClickBlock ? weakSelf.contentClickBlock(secondIndex) : nil;
                weakSelf.subView.frameHeight = [CustomSecondView calculateHeightWithData:contentArr WithSelectIndex:10000];
                weakSelf.subHeight = weakSelf.subView.frameHeight;
                weakSelf.bodyView.frameHeight = weakSelf.bodyButton.frameHeight + weakSelf.subView.frameHeight;
                weakSelf.bodyButtonBlock ? weakSelf.bodyButtonBlock(weakSelf.bodyButton.selected, weakSelf.isFolding, secondIndex, 10000): nil;
            }
            if (thirdIndex != 10000) {
                if (thirdIndex == 999) {//第三层未点击时
                    weakSelf.contentClickBlock ? weakSelf.contentClickBlock(secondIndex) : nil;
                }else{//第三层点击时
                    weakSelf.contentThirdClickBlock ? weakSelf.contentThirdClickBlock(thirdIndex) : nil;
                }
                weakSelf.subView.frameHeight = [CustomSecondView calculateHeightWithData:contentArr WithSelectIndex:secondIndex];
                weakSelf.subHeight = weakSelf.subView.frameHeight;
                weakSelf.bodyView.frameHeight = weakSelf.bodyButton.frameHeight + weakSelf.subView.frameHeight;
                weakSelf.bodyButtonBlock ? weakSelf.bodyButtonBlock(weakSelf.bodyButton.selected, weakSelf.isFolding, secondIndex, thirdIndex): nil;
            }
        };
        subView.frameHeight = kAdaptor(40)*contentArr.count;
        _subHeight = subView.frameHeight;
    }else{
        _isFolding = NO;
    }
}


+(CGFloat)calculateHeightWithData:(NSDictionary *)data withIndex:(NSInteger)index{
    CGFloat height = kAdaptor(mallCellHeight);
    NSArray *contentArr = [data objectForKey:@"contentArr"];
    if (contentArr.count > 0) {
        height += contentArr.count * kAdaptor(40);
        if (index != 10000) {
            id content = contentArr[index];
            if ([content isKindOfClass:[NSDictionary class]]) {
                NSArray *contentSubArr = [content objectForKey:@"subArr"];
                height += kAdaptor(40) * contentSubArr.count;
            }
        }
    }
    return height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
