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
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        
        UIViewController *v = [[UIViewController alloc]init];
        v.view.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        [arr addObject:v];
    }
    
    NSArray *items = @[@"关注",@"推荐",@"通知公告",@"新闻",@"一线传真",@"图片",@"视频",@"排行榜",@"业界动态",@"先进经验"];
    YHPageControlController *s = [[YHPageControlController alloc]initWithViewControllers:[arr copy] items:items];
    [self addPageControlController:s];
}

@end
