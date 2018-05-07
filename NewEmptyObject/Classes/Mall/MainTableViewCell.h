//
//  MainTableViewCell.h
//  NewEmptyObject
//
//  Created by Mac on 2018/4/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) BOOL isFolding;//是否展示折叠
@property (nonatomic, assign) BOOL isSecondFold;//子视图是否折叠
@property (nonatomic, copy) void(^bodyButtonBlock)(BOOL select, BOOL isFold, NSInteger secondIndex, NSInteger thirdIndex);//cell的button点击回调 默认传
@property (nonatomic, copy) void(^contentClickBlock)(NSInteger index);//折叠展开点击回调
- (void)getContentWithData:(NSDictionary *)data;
+ (CGFloat)calculateHeightWithData:(NSDictionary *)data withIndex:(NSInteger)index;

@property (nonatomic, copy) void(^contentThirdClickBlock)(NSInteger index);//折叠子视图展开点击回调
//第二层点击位置第三层点击位置
@property (nonatomic, strong) NSString *secondIndex;
@property (nonatomic, strong) NSString *thirdIndex;
@end
