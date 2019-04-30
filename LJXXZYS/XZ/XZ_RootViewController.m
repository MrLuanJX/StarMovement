//
//  XZ_RootViewController.m
//  LJXXZYS
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "XZ_RootViewController.h"
#import "XZ_CollectionCell.h"
#import "XZ_ChooseYSViewController.h"

@interface XZ_RootViewController () <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UIImageView * bgImage;

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UICollectionView * xzCollection;

@property (nonatomic , strong) NSMutableArray * dataArray;

@property (nonatomic , strong) NSMutableArray * imgArr;

@property (nonatomic , strong) NSMutableArray * btnArr;

@end

@implementation XZ_RootViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    [self.view addSubview:self.bgImage];
    [self.view addSubview:self.titleLabel];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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
    
    [collectionView registerClass:[XZ_CollectionCell class] forCellWithReuseIdentifier:@"detailCollectCell"];
    collectionView.backgroundColor = [UIColor clearColor];//INMUIColorWithRGB(0xffffff, 1.0);
    [self.view addSubview:collectionView];
    self.xzCollection = collectionView;
    CGFloat topF = 0.0;
    CGFloat bottomF = 0.0;
    if ((void)(SAFE_AREA_INSETS_BOTTOM),safeAreaInsets().bottom > 0.0) {
        topF = INMFit(88);
        bottomF = INMFit(83);
    }else{
        topF = INMFit(64);
        bottomF = INMFit(49);
    }
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topF);
        make.height.mas_equalTo(INMFit(50));
        make.left.right.mas_equalTo(0);
    }];
    
    [collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo (-bottomF);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset (INMFit(30));
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
    
    XZ_CollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCollectCell" forIndexPath:indexPath];
    
    cell.title.text = self.dataArray[indexPath.item];
    
    cell.bgImg.image = [UIImage imageNamed:self.imgArr[indexPath.item]];

    return cell;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XZ_ChooseYSViewController * chooseYSVC = [XZ_ChooseYSViewController new];
    chooseYSVC.xingzuoStr = self.dataArray[indexPath.item];
    NSLog(@"%ld",indexPath.item);
    
    [self.navigationController pushViewController:chooseYSVC animated:YES];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = INMFontSize(35);//[UIFont boldSystemFontOfSize:35];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"请选择属于你de星座";
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UIImageView *)bgImage {
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _bgImage.image = [UIImage imageNamed:@"xingzuo.jpg"];
    }
    return _bgImage;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座", nil];
    }
    return _dataArray;
}

- (NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [NSMutableArray arrayWithObjects:@"by.png",@"jn.jpg",@"shuangzi.jpg",@"jx.jpg",@"sz.jpg",@"cn.jpg",@"tc.jpg",@"tx.jpg",@"ss.jpg",@"mj.jpg",@"sp.jpg",@"sy.jpg", nil];
    }
    return _imgArr;
}

- (NSMutableArray *)btnArr {
    if(!_btnArr) {
        _btnArr = [NSMutableArray arrayWithObjects:@"今日运势",@"明日运势",@"本周运势",@"本月运势",@"全年运势", nil];
    }
    return _btnArr;
}

@end
