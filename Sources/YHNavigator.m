//
//  YHNavigator.m
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/29.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import "YHNavigator.h"
#import "YHConfigFile.h"

@implementation YHNavigator

+ (NSArray *)navigatorFromDatas:(NSArray *)datas {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *title in datas) {
        YHNavigator *navigator = [[YHNavigator alloc]init];
        navigator.itemTitle = title;
        UIFont *font = [YHConfigFile sharedInstance].navigatorTextFont ?:[UIFont systemFontOfSize:19];
        navigator.itemWidth = [title sizeWithAttributes:@{NSFontAttributeName:font}].width;
        [arr addObject:navigator];
    }
    return arr.copy;
}

@end
