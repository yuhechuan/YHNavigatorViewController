//
//  YHNavigatorViewCell.m
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/28.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import "YHNavigatorViewCell.h"

@interface YHNavigatorViewCell ()

@end

@implementation YHNavigatorViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    UITapGestureRecognizer *tap  =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)t {
    if (self.cellClick) {
        self.cellClick(self, self.cellIndex);
    }
}

- (void)setIsChecked:(BOOL)isChecked {
    _isChecked = isChecked;
    CGFloat scale = isChecked?1.0:0.0;
    [self setScale:scale];
}

- (void)setScale:(CGFloat)scale {
    self.title.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1];
    CGFloat minScale = 0.9;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _title.frame = self.bounds;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:19];
        [self addSubview:_title];
    }
    return _title;
}

@end
