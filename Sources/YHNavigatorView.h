//
//  YHNavigatorView.h
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/28.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHNavigator.h"

NS_ASSUME_NONNULL_BEGIN

@class YHNavigatorView;
@class YHNavigatorViewCell;

@protocol YHNavigatorViewDataSource <NSObject>

- (NSInteger)numberOfItemsInNavigatorView:(YHNavigatorView *)navigatorView;
- (YHNavigatorViewCell *)navigatorView:(YHNavigatorView *)navigatorView cellForRowAtIndex:(NSInteger)index;
- (CGFloat)navigatorView:(YHNavigatorView *)navigatorView widthForRowAtIndex:(NSInteger)index;

@end

@protocol YHNavigatorViewDelegate <NSObject>

- (void)navigatorView:(YHNavigatorView *)navigatorView didSelectRowAtIndex:(NSInteger)index;

@end

@interface YHNavigatorView : UIScrollView

@property (nonatomic, weak) id <YHNavigatorViewDataSource>dataSource_yh;
@property (nonatomic, weak) id <YHNavigatorViewDelegate>delegate_yh;

@property (nonatomic, assign) NSInteger currentIndex;

/*
 *items 最好是YHNavigator对象   也可以直接为字符串
 */
- (instancetype)initWithItems:(NSArray *)items
                        frame:(CGRect)frame;
/*
 *刷新数据
 */
- (void)reloadData;

/*
 *设置当前选中位置
 */
- (void)setCurrentIndex:(NSInteger)currentIndex;

/*
 *设置当前选中位置
 */
- (void)setCurrentIndex:(NSInteger)currentIndex
            isAnimation:(BOOL)isAnimation;



@end

NS_ASSUME_NONNULL_END
