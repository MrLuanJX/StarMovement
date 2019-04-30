//
//  QQTestViewController.m
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "QQTestViewController.h"
#import "QQModel.h"
#import "QQTestCell.h"

@interface QQTestViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) QQModel * qqModel;

@end

@implementation QQTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = INMUIColorWithRGB(0x8B8989, 1.0);
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0x8B8989, 1.0) SecondColor:INMUIColorWithRGB(0x66CDAA, 1.0) WithView:self.view];

    [self configUI];
    
    [self requestData];
    
    self.titleLabel.text = self.qqStr;
}

- (void) requestData {
    __weak typeof (self) weakSelf = self;
    
    NSString * url = [NSString stringWithFormat:@"%@&key=%@&qq=%@",QQBaseURL,QQAPPKey,self.qqStr];
    
    NSLog(@"url= %@",url);
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        
        NSLog(@"obj = %@",obj);
        
        if ([obj[@"error_code"] integerValue] == 0) {
            self.qqModel = [QQModel mj_objectWithKeyValues:obj];
            
            [weakSelf.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

- (void) configUI {
    CGFloat navheight = self.navigationController.navigationBar.frame.size.height;
    CGFloat stateheight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    
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
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QQTestCell * qqCell = [QQTestCell dequeueReusableCellWithTableView:tableView Identifier:@"qqCell"];
    
    qqCell.model = self.qqModel;
    
    qqCell.index = indexPath;
    
    return qqCell;
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

@end
