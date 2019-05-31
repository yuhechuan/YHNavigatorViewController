//
//  YHPageControlController.m
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/29.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import "YHPageControlController.h"
#import "YHMacro.h"

static CGFloat const NAVIGATOR_HEIGHT = 44;

@interface YHPageControlController ()<UIScrollViewDelegate,YHNavigatorViewDelegate>

@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, assign) CGSize pageSize;

@end

@implementation YHPageControlController

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                                  items:(NSArray *)items {
    if (self = [super init]) {
        self.items = items;
        self.viewControllers = viewControllers;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}

- (void)setUp {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navigatorView];
    _pageSize = self.view.bounds.size;
}


- (void)setViewControllers:(NSArray *)viewControllers {
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    NSInteger count = viewControllers.count;
    _viewControllers = viewControllers;
    self.containerView.contentSize = CGSizeMake(count *width,height - NAVIGATOR_HEIGHT);
}

- (UIScrollView *)containerView {
    if (!_containerView) {
        CGFloat width = self.pageSize.width;
        CGFloat height = self.pageSize.height;;
        _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,NAVIGATOR_HEIGHT + NAVIGATION_BAR_HEIGHT_YH, width, height - NAVIGATOR_HEIGHT)];
        _containerView.backgroundColor = [UIColor clearColor];
        _containerView.showsVerticalScrollIndicator = NO;
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.delegate = self;
        _containerView.pagingEnabled = YES;
        [self.view addSubview:_containerView];
    }
    return _containerView;
}

- (YHNavigatorView *)navigatorView {
    if (!_navigatorView) {
        NSArray *datas = [YHNavigator navigatorFromDatas:self.items];
        _navigatorView = [[YHNavigatorView alloc]initWithItems:datas frame:CGRectMake(0, NAVIGATION_BAR_HEIGHT_YH,self.view.bounds.size.width,NAVIGATOR_HEIGHT)];
        _navigatorView.delegate_yh = self;
    }
    return _navigatorView;
}

- (void)moveToViewControllerAtIndex:(NSUInteger)index
                          animation:(BOOL)animation {
    [self addChildViewControllerWithIndex:index];
    [self scrollContainerViewToIndex:index animation:animation];
}


- (void)addChildViewControllerWithIndex:(NSInteger)index {
    UIViewController *targetViewController = nil;
    id obj = self.viewControllers[index];;
    if ([obj isKindOfClass:[UIViewController class]]) {
        targetViewController = obj;
    } else if ([obj isKindOfClass:[NSString class]]) {
        targetViewController = [[NSClassFromString(obj) alloc]init];
    } else {
        return;
    }
    if ([self.childViewControllers containsObject:targetViewController] || !targetViewController) {
        return;
    }
    
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    
    targetViewController.view.backgroundColor = RGBACOLOR_YH(R, G, B, 1);
    
    [self updateFrameChildViewController:targetViewController atIndex:index];
}

- (void)scrollContainerViewToIndex:(NSUInteger)index
                         animation:(BOOL)animation {
    if (animation) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.containerView setContentOffset:CGPointMake(index * self.pageSize.width, 0)];
        } completion:^(BOOL finished) {
        }];
    } else {
        [self.containerView setContentOffset:CGPointMake(index * self.pageSize.width, 0)];
    }
}

- (void)updateFrameChildViewController:(UIViewController *)childViewController atIndex:(NSUInteger)index {
    
    childViewController.view.frame = CGRectOffset(CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height), index * _pageSize.width, 0);
    
    [self.containerView addSubview:childViewController.view];
    [self addChildViewController:childViewController];
}

/*
 * 将要滑动 提前添加
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.containerView) {
        NSInteger currentIndex = self.navigatorView.currentIndex;
        NSInteger index = currentIndex + 1;
        
        if (index > self.viewControllers.count -1) {
            return;
        }
        [self addChildViewControllerWithIndex:index];
    }
}

/*
 * 滚动动画结束后调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.containerView) {
        NSInteger currentIndex = self.navigatorView.currentIndex;
        NSInteger index = round(scrollView.contentOffset.x / _pageSize.width);
        
        if (currentIndex != index) {
            [self moveToViewControllerAtIndex:index animation:YES];
            [self.navigatorView setCurrentIndex:index];
        }
    }
}

- (void)navigatorView:(YHNavigatorView *)navigatorView didSelectRowAtIndex:(NSInteger)index {
    NSInteger currentIndex = self.navigatorView.currentIndex;
    if (currentIndex != index) {
        NSUInteger num = currentIndex - index;
        BOOL isAnimation = (num == 1);
        [self moveToViewControllerAtIndex:index animation:isAnimation];
    }
}


@end


#pragma mark ---- 分类(UIViewController)

#import <objc/runtime.h>

@implementation UIViewController(YHPageControl)
@dynamic pageControlController; // 去除set方法实现警告

- (YHPageControlController *)pageControlController {
    if ([self.parentViewController isKindOfClass:[YHPageControlController class]] && self.parentViewController) {
        return (YHPageControlController *)self.parentViewController;
    }
    return nil;
}

- (void)addPageControlController:(YHPageControlController *)pageControlController {
    if (self == pageControlController) {
        return;
    }
    
    [self.view addSubview:pageControlController.view];
    [self addChildViewController:pageControlController];
    
    // 默认加入第一个控制器
    UIViewController *firstViewController = nil;
    id obj = pageControlController.viewControllers.firstObject;
    if ([obj isKindOfClass:[UIViewController class]]) {
        firstViewController = obj;
    } else if ([obj isKindOfClass:[NSString class]]) {
        firstViewController = [[NSClassFromString(obj) alloc]init];
    } else {
        return;
    }
    
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    
    firstViewController.view.backgroundColor = RGBACOLOR_YH(R, G, B, 1);
    
    if ([pageControlController respondsToSelector:@selector(updateFrameChildViewController:atIndex:)]) {
        [pageControlController performSelector:@selector(updateFrameChildViewController:atIndex:) withObject:firstViewController withObject:0];
    }
}
@end
