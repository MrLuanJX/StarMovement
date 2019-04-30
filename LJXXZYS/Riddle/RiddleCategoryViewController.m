//
//  RiddleCategoryViewController.m
//  LJXXZYS
//
//  Created by a on 2019/4/24.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "RiddleCategoryViewController.h"
#import "RiddleCategoryModel.h"
#import "ChildTableViewController.h"

@interface RiddleCategoryCell ()

@property (nonatomic , strong) RiddleCategoryModel * model;

@end

@implementation RiddleCategoryCell

- (void)setModel:(RiddleCategoryModel *)model {
    _model = model;
    
    self.title.text = model.name;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        __weak typeof (self) weakSelf = self;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2.0f;
        
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        self.backgroundColor = kSetUpCololor(R, G, B, 1.0);
        
        [self.contentView addSubview:self.title];
    
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
            make.centerY.mas_equalTo (weakSelf.contentView.mas_centerY);
            make.bottom.mas_equalTo(-INMFit(10));
        }];
    }
    return self;
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.font = [UIFont boldSystemFontOfSize:25];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor whiteColor];
    }
    return _title;
}

@end

@interface RiddleCategoryViewController () <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) NSMutableArray * dataArray;

@end

@implementation RiddleCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = @"谜语";
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0x191970, 1.0) SecondColor:INMUIColorWithRGB(0x4682B4, 1.0) WithView:self.view];
    
    [self configUI];
    
    [self requestData];
}

- (void) requestData {
//    NSString * url = [NSString stringWithFormat:@"https://api.jisuapi.com/miyu/class?appkey=4f41d6d85dbe73e5"];
    
//    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
    
    
    NSString * url = [NSString stringWithFormat:@"https://api.jisuapi.com/miyu/class?appkey=4f41d6d85dbe73e5"];
    
    NSLog(@"url= %@",url);
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        NSLog(@"obj = %@",obj);
        
        NSMutableArray * dataArray = [RiddleCategoryModel mj_objectArrayWithKeyValuesArray:obj[@"result"]];
        
        if (dataArray.count > 0) {
            [self.dataArray addObjectsFromArray:dataArray];
        }
        
        for (RiddleCategoryModel * model in dataArray) {
            NSLog(@"name = %@",model.name);
        }
        
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        
        NSLog(@"error = %@",error);
    }];
}

- (void) configUI {
    __weak typeof  (self) weakSelf = self;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 行间距
    layout.minimumLineSpacing = INMFit(10);
    layout.minimumInteritemSpacing = INMFit(10);
    //设置每个item的大小
    layout.itemSize = CGSizeMake((INMScreenW - INMFit(40))/3, INMFit(120));
    layout.sectionInset = UIEdgeInsetsMake( 0, INMFit(10), 0, INMFit(10)); //设置距离上 左 下 右
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [collectionView registerClass:[RiddleCategoryCell class] forCellWithReuseIdentifier:@"riddleCollectCell"];
    collectionView.backgroundColor = [UIColor clearColor];//INMUIColorWithRGB(0xffffff, 1.0);
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(INMFit(520));
        make.top.mas_equalTo(INMFit(100));
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray != 0 ? self.dataArray.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RiddleCategoryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"riddleCollectCell" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.item];
    
    return cell;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"%ld",indexPath.item);
    ChildTableViewController * childVC = [ChildTableViewController new];
    RiddleCategoryModel * riddleModel = self.dataArray[indexPath.item];
    childVC.riddleModel = riddleModel;
    [self.navigationController pushViewController:childVC animated:YES];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
