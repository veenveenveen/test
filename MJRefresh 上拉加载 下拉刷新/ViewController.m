//
//  ViewController.m
//  MJRefresh 上拉加载 下拉刷新
//
//  Created by 黄启明 on 2016/11/25.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tabView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation ViewController

- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            NSString *str = [NSString stringWithFormat:@"icon_%02d.png",i+1];
            [_images addObject:[UIImage imageNamed:str]];
        }
    }
    return _images;
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            NSString *str = [NSString stringWithFormat:@"第 %d 行",i];
            [_dataArr addObject:str];
        }
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    [self.tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    //下拉刷新
    __weak typeof(self) weakSelf = self;
    MJRefreshGifHeader *h = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewdata];
    }];
    [h setImages:self.images forState:MJRefreshStateRefreshing];
    [h setImages:self.images forState:MJRefreshStateIdle];
    [h setImages:self.images forState:MJRefreshStatePulling];
    self.tabView.mj_header = h;
//    self.tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self loadNewdata];
//    }];
    //上拉加载更多
    self.tabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoredata];
    }];
    [self.view addSubview:self.tabView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)loadNewdata {
    for (int i = 0; i < 5; i++) {
        [self.dataArr insertObject:[NSString stringWithFormat:@"new data %d",i] atIndex:i];
    }
    [self.tabView reloadData];
    [self.tabView.mj_header endRefreshing];
}

- (void)loadMoredata {
    for (int i = 0; i < 10; i++) {
        [self.dataArr addObject:[NSString stringWithFormat:@"more data %d",i]];
    }
    [self.tabView reloadData];
    [self.tabView.mj_footer endRefreshing];
}

@end
