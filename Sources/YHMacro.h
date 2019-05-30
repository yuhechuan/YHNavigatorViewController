//
//  YHMacro.h
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/30.
//  Copyright © 2019 ruaho. All rights reserved.
//

#ifndef YHMacro_h
#define YHMacro_h

/**
 *  单例模式宏模板
 */
#define SINGLETON_FOR_HEADER_YH(className) \
\
+ (className *)sharedInstance;

#define SINGLETON_FOR_CLASS_YH(className) \
\
+ (className *)sharedInstance { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#define IS_IPHONEX_YH ({\
int tmp = 0;\
if (@available(iOS 11.0, *)) {\
UIWindow * window = [[[UIApplication sharedApplication] delegate] window];\
if (window.safeAreaInsets.bottom > 0.0) {\
tmp = 1;\
}else{\
tmp = 0;\
}\
}else{\
tmp = 0;\
}\
tmp;\
})

// 状态栏高度
#define STATUS_BAR_HEIGHT_YH (IS_IPHONEX_YH ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT_YH (IS_IPHONEX_YH ? 88.f : 64.f)

// home indicator
#define HOME_INDICATOR_HEIGHT_YH (IS_IPHONEX_YH ? 34.f : 0.f)
//24
#define NAVIGATION_BAR_MARGIN_YH (IS_IPHONEX_YH ? 24.f : 0.f)


//屏幕宽高
#define SCREEN_WIDTH_YH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT_YH  [UIScreen mainScreen].bounds.size.height

#define RGBACOLOR_YH(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#endif /* YHMacro_h */
