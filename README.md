# YHNavigatorViewController
一个非常好用的分页控制器,支持横向和竖向,及自定制功能

![功能展示图](https://github.com/yuhechuan/YHNavigatorViewController/blob/master/YHNavigatorViewController/gif5新文件.gif)

#####1.关于竖向分页控制器
```
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
```
#####2.关于横向分页控制器
```
// 只需要传入  items 及controllers数组
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

```


