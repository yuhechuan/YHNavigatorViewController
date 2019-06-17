//
//  YHPageControlController.h
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/29.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHNavigatorView.h"
#import "YHConfigFile.h"
#import "YHMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHPageControlController : UIViewController

@property (nonatomic, strong) YHNavigatorView *navigatorView;
@property (nonatomic, strong) NSArray <UIViewController *>*viewControllers;
@property (nonatomic, strong) NSArray <NSString *>*items;

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                                  items:(NSArray *)items;

@end

@interface UIViewController (YHPageControl)
@property (nonatomic, strong) YHPageControlController *pageControlController;
- (void)addPageControlController:(YHPageControlController *)pageControlController;
@end

NS_ASSUME_NONNULL_END
