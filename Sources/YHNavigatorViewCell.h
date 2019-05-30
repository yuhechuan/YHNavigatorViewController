//
//  YHNavigatorViewCell.h
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/28.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHConfigFile.h"

NS_ASSUME_NONNULL_BEGIN

@class YHNavigatorViewCell;
typedef void(^YHNavigatorViewCellClick)(YHNavigatorViewCell *cell,NSInteger index);

@interface YHNavigatorViewCell : UIView

@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, assign) NSInteger cellIndex;
@property (nonatomic, copy) YHNavigatorViewCellClick cellClick;
@property (nonatomic, strong) UILabel *title;


@end

NS_ASSUME_NONNULL_END
