//
//  TodayUnderstandViewController.m
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "TodayUnderstandViewController.h"
#import "TodayCell.h"
#import "TodayModel.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"

@interface TodayUnderstandViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray * dataArray;

@property (nonatomic , strong) TodayModel * todayModel;

@end

@implementation TodayUnderstandViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = INMUIColorWithRGB(0xA2B5CD, 1.0);
        
    [self configUI];
    
    [self requestData];
}

- (void) requestData {
    __weak typeof (self) weakSelf = self;
    
    NSString * url = [NSString stringWithFormat:@"%@&v=%@&key=%@&month=%@&day=%@",TodayBaseURL,@"1.0",TodayAPPKey,self.month,self.day];
    
    NSLog(@"url= %@",url);
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        
        NSLog(@"obj = %@",obj);
        
        if ([obj[@"error_code"] integerValue] == 0) {
            
            NSMutableArray * array = [TodayModel mj_objectArrayWithKeyValuesArray:obj[@"result"]];
            
            if (array.count > 0) {
                [self.dataArray addObjectsFromArray:array];
            }

            [weakSelf.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview: self.tableView];

    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view);
        make.left.right.bottom.mas_equalTo(weakSelf.view);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count > 0 ? self.dataArray.count : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TodayCell * todayCell = [TodayCell dequeueReusableCellWithTableView:tableView Identifier:@"todayCell"];
    
    if (self.dataArray.count > 0) {
        todayCell.todayModel = self.dataArray[indexPath.row];
    }
    
    return todayCell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
