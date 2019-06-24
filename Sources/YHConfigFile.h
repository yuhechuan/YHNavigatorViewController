//
//  YHConfigFile.h
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/30.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YHMacro.h"

typedef NS_ENUM(NSUInteger, YHIndicatorType) {
    YHIndicatorTypeView = 1,    // 指示器和view对齐
    YHIndicatorTypeWord = 2,    // 指示器和文字对齐
    YHIndicatorTypeNone = 3     // 不显示指示器
};

NS_ASSUME_NONNULL_BEGIN

@interface YHConfigFile : NSObject

SINGLETON_FOR_HEADER_YH(YHConfigFile);

@property (nonatomic, strong) UIColor         *indicatorColor;              // 指示器颜色 defalut is red
@property (nonatomic, strong) UIColor         *navigatorTextColor;         // 字体颜色 defalut is black
@property (nonatomic, strong) UIColor         *navigatorTextHeightColor;   // 字体高亮颜色defalut is black
@property (nonatomic, strong) UIFont          *navigatorTextFont;          // 字体大小 defalut is red

@property (nonatomic, assign) CGFloat         indicatorHeight;        // 指示器高度 defalut is 2.0
@property (nonatomic, assign) YHIndicatorType indicatorType;          // 指示器显示类型 defalut is YHIndicatorTypeView

@property (nonatomic, assign) CGFloat         itemWordSpace;              // 文字距离 defalut is 2.0
@property (nonatomic, assign) BOOL            isHasAnimation;             // 竖向导航点击上部 下面部分是否有动画 defalut is YES
@property (nonatomic, assign) BOOL            isAddButtomLine;            // 导航器下部线条 defalut is YES
@property (nonatomic, assign) BOOL            isZoomOfWord;               // 导航器是否有缩放 defalut is YES




@end

NS_ASSUME_NONNULL_END
