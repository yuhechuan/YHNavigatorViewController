//
//  YHSectionControlController.h
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

@interface YHSectionControlController : UIViewController<UITableViewDelegate,UITableViewDataSource,YHNavigatorViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YHNavigatorView *navigatorView;
@property (nonatomic, strong) NSArray <NSString *>*items;

- (instancetype)initWithItems:(NSArray *)items;

- (NSArray *)getMyItems;

@end

NS_ASSUME_NONNULL_END
