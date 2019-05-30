//
//  YHSectionControlController.m
//  YHNavigatorViewController
//
//  Created by ruaho on 2019/5/29.
//  Copyright © 2019 ruaho. All rights reserved.
//

#import "YHSectionControlController.h"
#import "YHMacro.h"

static CGFloat const NAVIGATOR_HEIGHT = 44;

@interface YHSectionControlController ()

@property (nonatomic, assign) NSInteger currentSection;


@end

@implementation YHSectionControlController

- (instancetype)initWithItems:(NSArray *)items {
    if (self = [super init]) {
        _items = items;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp {
    [self.view addSubview:self.navigatorView];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableFooter];
}

- (void)setTableFooter {
    NSInteger sectionCount = [self numberOfSectionsInTableView:self.tableView] - 1;
    CGRect headRect = [self.tableView rectForHeaderInSection:sectionCount];
    CGRect sectionRect = [self.tableView rectForSection:sectionCount];
    
    CGFloat tableViewHeight = self.tableView.frame.size.height;
    CGFloat headH = headRect.size.height;
    CGFloat sectionH = sectionRect.size.height;
    
    CGFloat footH = tableViewHeight - (headH + sectionH);
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, footH)];
    footer.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footer;
}

- (YHNavigatorView *)navigatorView {
    if (!_navigatorView) {
        NSArray *datas = [YHNavigator navigatorFromDatas:[self getMyItems]];
        _navigatorView = [[YHNavigatorView alloc]initWithItems:datas frame:CGRectMake(0, NAVIGATION_BAR_HEIGHT_YH,self.view.bounds.size.width,44)];
        _navigatorView.delegate_yh = self;
    }
    return _navigatorView;
}

- (NSArray *)getMyItems {
    return _items;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT_YH + NAVIGATOR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - (NAVIGATION_BAR_HEIGHT_YH + NAVIGATOR_HEIGHT)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组--第%ld行",indexPath.section,indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 30)];
    label.text = [NSString stringWithFormat:@"第%ld组",section];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor whiteColor];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)navigatorView:(YHNavigatorView *)navigatorView didSelectRowAtIndex:(NSInteger)index {
    if (index != _currentSection) {
        _currentSection = index;
        CGRect headRect = [self.tableView rectForHeaderInSection:index];
        CGFloat y = self.tableView.contentOffset.y;
        CGFloat yOffset = headRect.origin.y -y;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.bounds = CGRectOffset(self.tableView.bounds,0,yOffset);
        }];
    }
}


#pragma mark - UIScrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat xOffset = scrollView.contentOffset.x;
    CGFloat yOffset = scrollView.contentOffset.y + 15;
    //计算相应行
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:CGPointMake(xOffset, yOffset)];
    //设置buttonView变化
    
    NSInteger section = indexPath.section;
    if (section !=_currentSection) {
        _currentSection = section;
        [self.navigatorView setCurrentIndex:section];
    }
}



@end
