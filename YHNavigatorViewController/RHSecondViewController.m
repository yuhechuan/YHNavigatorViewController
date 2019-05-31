//
//  RHSecondViewController.m
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/30.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import "RHSecondViewController.h"
#import "YHPageControlController.h"

@interface RHSecondViewController ()

@end

@implementation RHSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}

- (void)setUp {
    
    self.title = @"横向分页控制器";
    
    NSArray *items = @[@"关注",@"推荐",@"通知公告",@"新闻",@"一线传真",@"图片",@"视频",@"排行榜",@"业界动态",@"先进经验"];
    NSInteger count = items.count;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [arr addObject:@"UIViewController"];
    }
    
    YHPageControlController *s = [[YHPageControlController alloc]initWithViewControllers:[arr copy] items:items];
    [self addPageControlController:s];
}

@end
