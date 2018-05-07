//
//  NewUserManager.h
//  NewEmptyObject
//
//  Created by Mac on 2018/4/10.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#define groupSecondCellHight 40
#define groupThirdCellHeight 40 //定义第三层cell的高度
@interface NewUserManager : NSObject

+ (NewUserManager *)shareUserManager;

//第二层点击位置第三层点击位置
@property (nonatomic, strong) NSString *secondIndex;
@property (nonatomic, strong) NSString *thirdIndex;
@property (nonatomic) BOOL isSecondFold;//点击的折叠的
@property (nonatomic) BOOL isZhankai;//折叠展开,折叠关闭
@property (nonatomic) BOOL isThirdSelect;//第三层点击改变颜色

@end
