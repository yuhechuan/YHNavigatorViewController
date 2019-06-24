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
    
    UIColor *textColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    UIColor *textHeighColor =  [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1];
    
    if ([YHConfigFile sharedInstance].navigatorTextColor) {
        textColor = [YHConfigFile sharedInstance].navigatorTextColor;
    }
    
    if ([YHConfigFile sharedInstance].navigatorTextHeightColor) {
        textHeighColor = [YHConfigFile sharedInstance].navigatorTextHeightColor;
    }
    
    self.title.textColor = scale > 0? textHeighColor:textColor;

    CGFloat minScale = 0.9;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    if ([YHConfigFile sharedInstance].isZoomOfWord) {
        self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _title.frame = self.bounds;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [YHConfigFile sharedInstance].navigatorTextFont?:[UIFont systemFontOfSize:19];
        _title.textColor = [YHConfigFile sharedInstance].navigatorTextColor?:[UIColor blackColor];
        [self addSubview:_title];
    }
    return _title;
}

@end
