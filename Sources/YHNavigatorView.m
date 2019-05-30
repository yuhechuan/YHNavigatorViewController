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
#define INDICATOR_HEIGHT 1

@interface YHNavigatorView () {
    YHNavigatorViewCell *_selectedCell;
    UIView *_indicator;
    CGFloat _itemSpace;  // 除title外空间
    CGFloat _indicatorHeight;
    NSMutableArray *_itemWidths;
}

@end

@implementation YHNavigatorView

- (instancetype)init {
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}


- (instancetype)initWithItems:(NSArray *)items
                        frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        [self setUpWithItems:items frame:frame];
    }
    return self;
}

- (void)setUp {
    _indicator = [[UIView alloc]init];
    _indicator.backgroundColor = [UIColor redColor];
    [self addSubview:_indicator];
    _itemSpace = 15;
    _indicatorHeight = 1.5;
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
}

- (void)configurationCell:(YHNavigatorViewCell *)cell
             currentIndex:(NSInteger)currentIndex {
    __weak typeof(self) weakSelf = self;
    if (currentIndex == 0) {
        cell.isChecked = YES;
        _selectedCell = cell;
        [self updateIndicator];
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
    [self updateIndicator];
}



// 设置偏移量
- (void)updateOffset:(YHNavigatorViewCell *)cell {
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

- (void)updateIndicator {
    [UIView animateWithDuration:0.2 animations:^{
        self->_indicator.frame = CGRectMake(CGRectGetMinX(self->_selectedCell.frame),CGRectGetHeight(self->_selectedCell.frame) - self->_indicatorHeight, CGRectGetWidth(self->_selectedCell.frame),self->_indicatorHeight);
    }];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    YHNavigatorViewCell * cell = _itemWidths[currentIndex];
    [self updateOffset:cell];
    [self updateIndicator];
}

- (NSInteger)currentIndex {
    return _selectedCell.cellIndex;
}

@end
