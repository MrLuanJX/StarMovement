//
//  ChildTableViewController.m
//  LJXXZYS
//
//  Created by a on 2019/4/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "ChildTableViewController.h"
#import "ChildTableCell.h"
#import "ChildHeaderView.h"
#import "ChildModel.h"
#import "NoContentView.h"

@interface ChildTableViewController () <UITableViewDataSource , UITableViewDelegate , ChildHeaderViewDelegate , UISearchBarDelegate>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , assign) int currentRow;

@property (nonatomic , assign) int currentSection;

@property (nonatomic , strong) NSMutableArray * headerArray;

@property (nonatomic , strong) NSMutableArray * cellArray;

@property (nonatomic , strong) UISearchBar * searchBar;

@property (nonatomic , strong) NoContentView * noContentView;

@property (nonatomic , assign) NSInteger page;

@end

@implementation ChildTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;
    
    self.title = self.riddleModel.name;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0x191970, 1.0) SecondColor:INMUIColorWithRGB(0x4682B4, 1.0) WithView:self.view];

    [self configUI];
    
    [self randomCreatChinese:10];
    
//    [self requestData];
    
    [self refreshData];
}

- (void) refreshData {
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [weakSelf.headerArray removeAllObjects];
        [weakSelf.cellArray removeAllObjects];
        weakSelf.page = 1;
        [weakSelf requestData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}

- (NSMutableString*)randomCreatChinese:(NSInteger)count{
    NSMutableString * randomChineseString =@"".mutableCopy;
    for(NSInteger i =0; i < count; i++){
        NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);//随机生成汉字高位
        NSInteger randomH =0xA1+arc4random()%(0xFE - 0xA1+1);//随机生成汉子低位
        NSInteger randomL =0xB0+arc4random()%(0xF7-0xB0+1);//组合生成随机汉字
        NSInteger number = (randomH<<8)+randomL;
        NSData*data = [NSData dataWithBytes:&number length:2];
        NSString*string = [[NSString alloc]initWithData:data encoding:gbkEncoding];
        [randomChineseString appendString:string];
    }
    NSLog(@"randomChineseString = %@",randomChineseString);
    return randomChineseString;
}

#pragma mark - 实现键盘上Search按钮的方法

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"您点击了键盘上的Search按钮");
    if (self.searchBar.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先输入谜语关键字"];
        return;
    }
    
    [self.headerArray removeAllObjects];
    [self.cellArray removeAllObjects];
    
    [self requestData];
    
    [self.view endEditing:YES];
    UITextField * searchField = [self.searchBar valueForKey:@"_searchField"];
    searchField = [[[self.searchBar.subviews firstObject] subviews] lastObject];
    searchField.text = @"";
}

- (void) requestData{
    __weak typeof (self) weakSelf = self;
    
    // 谜语
    NSString * url = [NSString stringWithFormat:@"%@keyword=%@&pagenum=1&pagesize=2&classid=%@&appkey=4f41d6d85dbe73e5",@"https://api.jisuapi.com/miyu/search?",self.searchBar.text,self.riddleModel.classid];
    
    // 周公解梦
//    NSString * url = [NSString stringWithFormat:@"https://api.jisuapi.com/dream/search?appkey=%@&keyword=%@&pagenum=1&pagesize=10",@"4f41d6d85dbe73e5",@"人"];

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
    
    NSLog(@"url= %@",url);
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        NSLog(@"obj = %@",obj);
        
        [weakSelf endRefresh];
        
        if ([obj[@"status"] integerValue] == 0) {
            weakSelf.noContentView.hidden = YES;
            weakSelf.tableView.hidden = NO;
            
            NSMutableArray * dataArray = [ChildModel mj_objectArrayWithKeyValuesArray:obj[@"result"][@"list"]];
            
            int i = (int)weakSelf.headerArray.count;
            if (dataArray.count > 0) {
                for (ChildModel * childModel in dataArray) {
                    ChildHeaderView * headView = [ChildHeaderView new];
                    headView.delegate = self;
                    headView.childModel = childModel;
                    headView.index = i;
                    i++;
                    
                    [weakSelf.headerArray addObject:headView];
                    
                    [weakSelf.cellArray addObject:childModel.answer];
                }
            }
            [weakSelf.tableView reloadData];
            weakSelf.page++;
        } else {
            weakSelf.noContentView.hidden = NO;
            weakSelf.tableView.hidden = YES;
          
            NSString * contentStr = [obj[@"status"] integerValue] == 104 ? @"你太累了，也该歇歇了，明天再来吧" : obj[@"msg"]; // @"暂无数据，重新输入梦境再试试";//
            
            [weakSelf.noContentView setContent:contentStr];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf endRefresh];

        NSLog(@"error = %@",error);
    }];
}

- (void) configUI {
    CGFloat navheight = self.navigationController.navigationBar.frame.size.height;
    CGFloat stateheight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    __weak typeof  (self) weakSelf = self;
    
    [self.view addSubview: self.tableView];
    [self.view addSubview: self.searchBar];
    [self.view addSubview: self.noContentView];
    
    [self.searchBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (navheight + stateheight);
        make.left.right.mas_equalTo (weakSelf.view);
        make.height.mas_equalTo (INMFit(40));
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.searchBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(weakSelf.view);
    }];
    
    [self.noContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.searchBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(weakSelf.view);
    }];
}

// 多少个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerArray.count > 0 ? self.headerArray.count : 0;
}

// 每个区多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ChildHeaderView * headView = self.headerArray[section];
    
    return headView.isOpen ? self.cellArray.count ? 1 : 0 : 0;
}

// 每行的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChildTableCell * childTableCell = [ChildTableCell dequeueReusableCellWithTableView:tableView Identifier:@"childCell"];

    childTableCell.childModel = self.cellArray[indexPath.section];
    
    return childTableCell;
}

// 每个区的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.headerArray.count > 0) {
        return self.headerArray[section];
    }else
        return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

// 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"click---%ld section and %ld row",(long)indexPath.section,(long)indexPath.row);
}

// headerDelegate
- (void) backAction:(ChildHeaderView *)headView {
    self.currentRow = -1;
    if (headView.isOpen) {
        for(int i = 0; i < self.headerArray.count; i++){
            NSLog(@"i = %d",i);
            ChildHeaderView *head = [self.headerArray objectAtIndex:i];
            
            head.isOpen = NO;
            
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                head.backBtn.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
            } completion:NULL];
        }
        [_tableView reloadData];
        return;
    }
    _currentSection = (int)headView.index;
    [self reset];
}

//界面重置
- (void)reset {
    for(int i = 0;i < self.headerArray.count; i++){
        NSLog(@"reset_i = %d",i);
        ChildHeaderView *head = [self.headerArray objectAtIndex:i];
        
        if(head.index == _currentSection) {
            head.isOpen = YES;
            
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                head.backBtn.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } completion:NULL];
        }else {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                head.backBtn.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
            } completion:NULL];
            head.isOpen = NO;
        }
    }
    [_tableView reloadData];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 80;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)headerArray {
    if (!_headerArray) {
        _headerArray = @[].mutableCopy;
    }
    return _headerArray;
}

- (NSMutableArray *)cellArray {
    if (!_cellArray) {
        _cellArray = @[].mutableCopy;
    }
    return _cellArray;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [UISearchBar new];
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
        _searchBar.placeholder = @"请输入要搜索的谜语关键字";
    }
    return _searchBar;
}

- (NoContentView *)noContentView {
    if (!_noContentView) {
        _noContentView = [NoContentView new];
        _noContentView.backgroundColor = [UIColor whiteColor];
        _noContentView.hidden = YES;
    }
    return _noContentView;
}

- (void) endRefresh {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
