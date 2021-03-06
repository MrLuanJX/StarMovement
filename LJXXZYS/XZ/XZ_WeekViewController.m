//
//  XZ_WeekViewController.m
//  LJXXZYS
//
//  Created by a on 2019/4/15.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "XZ_WeekViewController.h"
#import "XZ_Model.h"
#import "XZ_WeekCell.h"

@interface XZ_WeekViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray * array;

@property (nonatomic , strong) XZ_Model * model;

@end

@implementation XZ_WeekViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = INMUIColorWithRGB(0x8B8989, 1.0);
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0x8B8989, 1.0) SecondColor:INMUIColorWithRGB(0x66CDAA, 1.0) WithView:self.view];

    [self configUI];
    
    self.titleLabel.text = self.xingzuoStr;
    
    [self requestData];
    
}

- (void) requestData {
    __weak typeof (self) weakSelf = self;
    
    NSString * dayStr = self.currentIndex == 3 ? @"month" : @"week";
    
    NSString * url = [NSString stringWithFormat:@"%@consName=%@&type=%@&key=%@",BaseURL,self.xingzuoStr,dayStr,APPKey];
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
    
    NSLog(@"url= %@",url);
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        
        NSLog(@"obj = %@",obj);
        if ([obj[@"error_code"] integerValue] == 0) {
            
            self.model = [XZ_Model mj_objectWithKeyValues:obj];
            
            [weakSelf.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
}

- (void) configUI {
    
    CGFloat navheight = self.navigationController.navigationBar.frame.size.height;

    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview: self.titleLabel];
    [self.view addSubview: self.tableView];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(navheight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(INMFit(50));
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(INMFit(20));
        make.left.right.bottom.mas_equalTo(weakSelf.view);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZ_WeekCell * bussinessManagementCell = [XZ_WeekCell dequeueReusableCellWithTableView:tableView Identifier:@"weekCell"];
    
    bussinessManagementCell.model = self.model;
    
    bussinessManagementCell.index = indexPath;
    
    bussinessManagementCell.currentIndex = self.currentIndex;
    
    return bussinessManagementCell;
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:30];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray arrayWithObjects:@"日期:",@"综合指数:",@"健康指数:",@"爱情指数:",@"财运指数:",@"工作指数:",@"幸运色:",@"幸运数字:",@"速配星座:",@"今日概述:", nil];
    }
    return _array;
}


@end
