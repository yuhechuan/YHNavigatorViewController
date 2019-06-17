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
    self.title = @"竖向分页控制器";
    // Do any additional setup after loading the view.
}

- (NSArray *)getMyItems {
    NSArray *arr = @[@"关注",@"推荐",@"通知公告",@"新闻",@"一线传真",@"图片",@"视频",@"排行榜",@"业界动态",@"先进经验"];
    return arr;
}

// 可以重写  tableView 代理方法  定制页面的显示

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

//... 等等

@end
