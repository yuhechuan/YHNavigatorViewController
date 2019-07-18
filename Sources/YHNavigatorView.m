//
//  YHNavigatorView.m
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/28.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import "YHNavigatorView.h"
#import "YHNavigatorViewCell.h"

#define ITEM_LEFT_RIGHT_MARGIN 10

@interface YHNavigatorView () {
    YHNavigatorViewCell *_selectedCell;
    UIView *_indicator;
    CGFloat _itemSpace;  // 除title外空间
    CGFloat _indicatorHeight;
    NSMutableArray *_itemWidths;
    YHIndicatorType _indicatorType;
    UIView *_buttomLine;
}

@end

@implementation YHNavigatorView

- (instancetype)init {
    if (self = [super init]) {
        [self setUp:CGRectZero];
    }
    return self;
}


- (instancetype)initWithItems:(NSArray *)items
                        frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp:frame];
        [self setUpWithItems:items frame:frame];
    }
    return self;
}

- (void)setUp:(CGRect)frame {
    _indicatorType = [YHConfigFile sharedInstance].indicatorType;
    if (_indicatorType != YHIndicatorTypeNone) {
        _indicator = [[UIView alloc]init];
        _indicator.backgroundColor =  [YHConfigFile sharedInstance].indicatorColor?:[UIColor redColor];
        _indicatorHeight = [YHConfigFile sharedInstance].indicatorHeight > 0?[YHConfigFile sharedInstance].indicatorHeight:2;
        [self addSubview:_indicator];
    }
    _itemSpace = [YHConfigFile sharedInstance].itemWordSpace > 0 ?[YHConfigFile sharedInstance].itemWordSpace:15;
    _itemWidths = [NSMutableArray array];
}


- (void)setUpWithItems:(NSArray *)items
                 frame:(CGRect)frame {

    CGFloat totalWidth = 0;
    NSInteger itemCount = items.count;

    for (int i = 0; i < itemCount; i ++) {
        CGFloat width = 0;
        YHNavigatorViewCell *cell = nil;
        
        if ([self.dataSource_yh respondsToSelector:@selector(navigatorView:widthForRowAtIndex:)]) {
            width = [self.dataSource_yh navigatorView:self widthForRowAtIndex:i];
        }
        
        if ([self.dataSource_yh respondsToSelector:@selector(navigatorView:cellForRowAtIndex:)]) {
            cell = [self.dataSource_yh navigatorView:self cellForRowAtIndex:i];
        }
        
        id obj = items[i];
        if ([obj isKindOfClass:[YHNavigator class]]) {
            YHNavigator *navigator = (YHNavigator *)obj;
            
            if (width == 0) {
                width = navigator.itemWidth;
            }
            
            if (!cell) {
                cell = [[YHNavigatorViewCell alloc]init];
                cell.title.text = navigator.itemTitle;
            }
           
        }
        
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *itemTitle = (NSString *)obj;
    
            if (width == 0) {
                width = [itemTitle sizeWithAttributes:@{NSFontAttributeName:cell.title.font}].width + ITEM_LEFT_RIGHT_MARGIN;
            }
            if (!cell) {
                cell = [[YHNavigatorViewCell alloc]init];
                cell.title.text = itemTitle;
            }
        }
        
        if (!cell) {
            @throw [NSException exceptionWithName:@"dataSource_yh" reason:@"can't contain a YHNavigatorViewCell" userInfo:nil];
        }
        
        width += _itemSpace;
        
        cell.frame = CGRectMake(totalWidth,0,width,frame.size.height);
        
        
        [self configurationCell:cell currentIndex:i];
        
        [_itemWidths addObject:cell];
    
        totalWidth += width;
    
    }
    self.contentSize = CGSizeMake(totalWidth, self.bounds.size.height);
    
    if ([YHConfigFile sharedInstance].isAddButtomLine) {
        CGFloat lineHeight = 1.0;
        _buttomLine = [[UIView alloc]initWithFrame:CGRectMake(0,frame.size.height-lineHeight,totalWidth, lineHeight)];
        _buttomLine.backgroundColor = RGBACOLOR_YH(225, 225, 225, 1);
        [self addSubview:_buttomLine];
    }
}

- (void)reloadData {
    
    [_itemWidths removeAllObjects];
    
    NSArray *subs = self.subviews;
    for (UIView *view in subs) {
        if ([view isKindOfClass:[YHNavigatorViewCell class]]) {
            [view removeFromSuperview];
        }
    }
    
    NSInteger itemCount = 0;
    if ([self.dataSource_yh respondsToSelector:@selector(numberOfItemsInNavigatorView:)]) {
        itemCount = [self.dataSource_yh numberOfItemsInNavigatorView:self];
    }
    
    CGFloat totalWidth = 0;
    for (int i = 0; i < itemCount; i++) {
        CGFloat width = 0;
        if ([self.dataSource_yh respondsToSelector:@selector(navigatorView:widthForRowAtIndex:)]) {
            width = [self.dataSource_yh navigatorView:self widthForRowAtIndex:i];
        }
        
        YHNavigatorViewCell *cell = nil;
        if ([self.dataSource_yh respondsToSelector:@selector(navigatorView:cellForRowAtIndex:)]) {
            cell = [self.dataSource_yh navigatorView:self cellForRowAtIndex:i];
        }
        
        if (!cell) {
            @throw [NSException exceptionWithName:@"dataSource_yh" reason:@"can't contain a YHNavigatorViewCell" userInfo:nil];
        }
        
        if (width == 0) {
            width = [cell.title.text sizeWithAttributes:@{NSFontAttributeName:cell.title.font}].width + ITEM_LEFT_RIGHT_MARGIN;
        }
        
        cell.frame = CGRectMake(totalWidth,0,width,self.bounds.size.height);
        
        [self configurationCell:cell currentIndex:i];
       
        [_itemWidths addObject:cell];
        
        totalWidth += width;
    }
    
    self.contentSize = CGSizeMake(totalWidth, self.bounds.size.height);
    
    [_buttomLine removeFromSuperview];
    if ([YHConfigFile sharedInstance].isAddButtomLine) {
        CGFloat lineHeight = 1.0;
        _buttomLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.bounds.size.height - lineHeight,totalWidth, lineHeight)];
        _buttomLine.backgroundColor = RGBACOLOR_YH(225, 225, 225, 1);
        [self addSubview:_buttomLine];
    }
}

- (void)configurationCell:(YHNavigatorViewCell *)cell
             currentIndex:(NSInteger)currentIndex {
    __weak typeof(self) weakSelf = self;
    if (currentIndex == 0) {
        cell.isChecked = YES;
        _selectedCell = cell;
        [self updateIndicator:NO];
    }
    
    [self addSubview:cell];
    
    cell.cellIndex = currentIndex;
    cell.cellClick = ^(YHNavigatorViewCell * _Nonnull cell, NSInteger index) {
        [weakSelf navigatorViewCell:cell didSelectedIndex:index];
    };
}

- (void)navigatorViewCell:(YHNavigatorViewCell *)cell
         didSelectedIndex:(NSInteger)index {
    
    if ([self.delegate_yh respondsToSelector:@selector(navigatorView:didSelectRowAtIndex:)]) {
        [self.delegate_yh navigatorView:self didSelectRowAtIndex:index];
    }

    [self updateOffset:cell];
    [self updateIndicator:YES];
}


- (void)updateOffset:(YHNavigatorViewCell *)cell {
    [self updateOffset:cell isAnimation:YES];
}

// 设置偏移量
- (void)updateOffset:(YHNavigatorViewCell *)cell
         isAnimation:(BOOL)isAnimation {
    // 改变cell的选中状态
    cell.isChecked = YES;
    _selectedCell.isChecked = NO;
    _selectedCell = cell;
    
    CGFloat offsetx = cell.center.x - self.frame.size.width * 0.5;
    CGFloat offsetMax = self.contentSize.width - self.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    CGPoint offset = CGPointMake(offsetx, self.contentOffset.y);
    [self setContentOffset:offset animated:YES];
}

- (void)updateIndicator:(BOOL)isAnimation {
    
    if (_indicatorType == YHIndicatorTypeNone) {
        return;
    }
    
    CGFloat indicatorX = CGRectGetMinX(self->_selectedCell.frame);
    CGFloat indicatorY = CGRectGetHeight(self->_selectedCell.frame) - self->_indicatorHeight;
    CGFloat indicatorWidth = CGRectGetWidth(self->_selectedCell.frame);
    CGFloat indicatorHeight = self->_indicatorHeight;
    
    if (_indicatorType == YHIndicatorTypeWord) {
        indicatorX = CGRectGetMinX(self->_selectedCell.frame) + _itemSpace /2.0;
        indicatorWidth = CGRectGetWidth(self->_selectedCell.frame) - _itemSpace;
    }
    
    if (isAnimation) {
        [UIView animateWithDuration:0.3 animations:^{
            self->_indicator.frame = CGRectMake(indicatorX,indicatorY, indicatorWidth,indicatorHeight);
        }];
    } else {
        self->_indicator.frame = CGRectMake(indicatorX,indicatorY, indicatorWidth,indicatorHeight);
    }
}


- (void)setCurrentIndex:(NSInteger)currentIndex {
    [self setCurrentIndex:currentIndex
              isAnimation:YES];
}
- (void)setCurrentIndex:(NSInteger)currentIndex
            isAnimation:(BOOL)isAnimation {
    YHNavigatorViewCell * cell = _itemWidths[currentIndex];
    [self updateOffset:cell isAnimation:isAnimation];
    [self updateIndicator:isAnimation];
}

- (NSInteger)currentIndex {
    return _selectedCell.cellIndex;
}

@end
