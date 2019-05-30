//
//  YHNavigator.h
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/29.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHNavigator : NSObject

@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, assign) CGFloat itemWidth;   // 缓存宽度

/*
 * 组装资源
 */
+ (NSArray *)navigatorFromDatas:(NSArray *)datas;

@end

NS_ASSUME_NONNULL_END
