//
//  XZ_YearViewController.m
//  LJXXZYS
//
//  Created by a on 2019/4/15.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "XZ_YearViewController.h"
#import "XZ_YearModel.h"
#import "XZ_YearCell.h"

@interface XZ_YearViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray * array;

@property (nonatomic , strong) XZ_YearModel * yearModel;

@property (nonatomic , strong) UILabel * headTitleLabel;

@end

@implementation XZ_YearViewController

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
    
    NSString * url = [NSString stringWithFormat:@"%@consName=%@&type=%@&key=%@",BaseURL,self.xingzuoStr,@"year",APPKey];
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
    
    NSLog(@"url= %@",url);
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        
        NSLog(@"obj = %@",obj);
        if ([obj[@"error_code"] integerValue] == 0) {
            
            self.yearModel = [XZ_YearModel mj_objectWithKeyValues:obj];
            
            self.headTitleLabel.text = [NSString stringWithFormat:@"%@运势",self.yearModel.date];
            
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZ_YearCell * bussinessManagementCell = [XZ_YearCell dequeueReusableCellWithTableView:tableView Identifier:@"yearCell"];

    bussinessManagementCell.model = self.yearModel;

    bussinessManagementCell.index = indexPath;

    return bussinessManagementCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.array[section];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50;
        _tableView.tableHeaderView = [self headView];
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
        _array = [NSMutableArray arrayWithObjects:@"年度密码",@"事业运",@"感情运",@"财运",@"健康运",@"开运物",@"未来", nil];
    }
    return _array;
}

- (UIView *) headView {
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    headView.backgroundColor = [UIColor whiteColor];
    
    self.headTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    self.headTitleLabel.font = [UIFont boldSystemFontOfSize:35];
    self.headTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.headTitleLabel.textColor = [UIColor redColor];
    
    [headView addSubview:self.headTitleLabel];
    
    return headView;
}

@end
