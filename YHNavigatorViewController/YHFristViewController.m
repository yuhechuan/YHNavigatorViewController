//
//  YHFristViewController.m
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/30.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import "YHFristViewController.h"

@interface YHFristViewController ()

@end

@implementation YHFristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"横向分页控制器";
    // Do any additional setup after loading the view.
}

- (NSArray *)getMyItems {
    NSArray *arr = @[@"关注",@"推荐",@"通知公告",@"新闻",@"一线传真",@"图片",@"视频",@"排行榜",@"业界动态",@"先进经验"];
    return arr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
