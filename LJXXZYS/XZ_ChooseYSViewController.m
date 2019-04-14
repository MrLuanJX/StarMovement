//
//  XZ_ChooseYSViewController.m
//  LJXXZYS
//
//  Created by 栾金鑫 on 2019/4/14.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "XZ_ChooseYSViewController.h"
#import "XZ_DayViewController.h"

@interface XZ_ChooseYSCell ()

@property (nonatomic , strong) UILabel * titleLabel;

@end

@implementation XZ_ChooseYSCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(INMFit(80));
        }];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        _titleLabel.layer.borderWidth = 2.0f;
        _titleLabel.font = [UIFont boldSystemFontOfSize:30];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end

@interface XZ_ChooseYSViewController () <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UIImageView * bgImage;

@property (nonatomic , strong) UICollectionView * ysCollection;

@property (nonatomic , strong) NSMutableArray * titles;

@end

@implementation XZ_ChooseYSViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configUI];
}

- (void) configUI {
    
    UIImageView * bgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.jpg"]];
    [self.view addSubview:bgImage];
    self.bgImage = bgImage;
    
    [bgImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 行间距
    layout.minimumLineSpacing = INMFit(30);
    layout.minimumInteritemSpacing = INMFit(0);
    //设置每个item的大小
    layout.itemSize = CGSizeMake((INMScreenW - INMFit(80)), INMFit(80));
    layout.sectionInset = UIEdgeInsetsMake( 0, INMFit(10), 0, INMFit(10)); //设置距离上 左 下 右
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [collectionView registerClass:[XZ_ChooseYSCell class] forCellWithReuseIdentifier:@"chooseYSCell"];
    collectionView.backgroundColor = [UIColor clearColor];//INMUIColorWithRGB(0xffffff, 1.0);
    [self.view addSubview:collectionView];
    self.ysCollection = collectionView;
    
    [collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(INMFit(100));
        make.left.mas_equalTo(INMFit(40));
        make.right.mas_equalTo(-INMFit(40));
        make.height.mas_equalTo(100*7);
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XZ_ChooseYSCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"chooseYSCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = self.titles[indexPath.item];
    
//    if (self.fistSelect == YES) {
//        cell.titleLabel.textColor = indexPath.row == 0 ? [UIColor redColor] : [UIColor whiteColor];
//    }
    
    return cell;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.item);
    
    XZ_ChooseYSCell * selectCell = (XZ_ChooseYSCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
//        if (indexPath.row != 0) {
//            NSIndexPath *firstIndexPath = [[self.ysCollection indexPathsForVisibleItems] firstObject];
//            XZ_ChooseYSCell * firstCell = (XZ_ChooseYSCell *)[collectionView cellForItemAtIndexPath:firstIndexPath];
//            firstCell.titleLabel.textColor = [UIColor whiteColor];
//        }
//
//    selectCell.titleLabel.textColor = [UIColor redColor];
    if (indexPath.item == 0 || indexPath.item == 1) {
        XZ_DayViewController * dayVC = [XZ_DayViewController new];
        dayVC.xingzuoStr = self.xingzuoStr;
        [self.navigationController pushViewController:dayVC animated:YES];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//        self.fistSelect = NO;
//
//    XZ_ChooseYSCell *cell = (XZ_ChooseYSCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    // 边框颜色复原
//    cell.titleLabel.textColor = [UIColor whiteColor];
}

- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray arrayWithObjects:@"今日运势",@"明日运势",@"本周运势",@"本月运势",@"今年运势", nil];
    }
    return _titles;
}

@end
