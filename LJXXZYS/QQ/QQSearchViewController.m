//
//  QQSearchViewController.m
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "QQSearchViewController.h"
#import "QQTestViewController.h"

@interface QQCollectionCell ()

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , copy) NSString * timeData;

@end

@implementation QQCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    return self;
}

-(void)configUI{
    __weak typeof (self) weakSelf = self;
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = INMUIColorWithRGB(0xffffff, 1.0);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.layer.borderWidth = 1.0f;
    titleLabel.layer.borderColor = kSetUpCololor(225, 225, 225, 1.0).CGColor;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(INMFit(40));
        make.right.mas_equalTo(weakSelf.contentView);
    }];
}

-(void)setTimeData:(NSString *)timeData{
    _timeData = timeData;
    self.titleLabel.text = timeData;
}

@end

@interface QQSearchViewController () <UITextFieldDelegate , UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UITextField * textField;

@property (nonatomic , strong) UIButton * testBtn;

@property (nonatomic , strong) UIButton * changeBtn;

@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) UILabel * recommendLabel;

@property (nonatomic , strong) NSMutableArray * dataArray;

@property (nonatomic , strong) NSMutableArray * changeArray;

@property (nonatomic , assign) BOOL isDataArray;

@end

@implementation QQSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = INMUIColorWithRGB(0xA2B5CD, 1.0);
    
    self.isDataArray = YES;
    
    self.title = @"Q号吉凶";
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0xA2B5CD, 1.0) SecondColor:INMUIColorWithRGB(0x66CDAA, 1.0) WithView:self.view];
    
    [self configUI];
    [self createConstrainte];
}

- (void) configUI {
    [self.view addSubview: self.titleLabel];
    [self.view addSubview: self.testBtn];
    [self.view addSubview: self.textField];
    [self.view addSubview: self.collectionView];
    [self.view addSubview: self.recommendLabel];
    [self.view addSubview: self.changeBtn];
}

- (void) createConstrainte {
    __weak typeof (self) weakSelf = self;
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (INMFit(100));
        make.left.mas_equalTo (INMFit(10));
        make.right.mas_equalTo (-INMFit(10));
        make.height.mas_equalTo (INMFit(40));
    }];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.titleLabel.mas_bottom).offset (INMFit(30));
        make.left.right.height.mas_equalTo (weakSelf.titleLabel);
    }];
    
    [self.changeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.textField.mas_bottom).offset (INMFit(30));
        make.height.width.mas_equalTo(INMFit(60));
        make.right.mas_equalTo (-INMFit(10));
    }];
    
    [self.recommendLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.left.mas_equalTo (weakSelf.textField);
        make.right.mas_equalTo (weakSelf.changeBtn.mas_left);
        make.centerY.mas_equalTo (weakSelf.changeBtn.mas_centerY);
    }];
 
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.recommendLabel.mas_bottom).offset (INMFit(20));
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(INMFit(100));
    }];
    
    [self.testBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.collectionView.mas_bottom).mas_equalTo (INMFit(50));
        make.left.right.height.mas_equalTo (weakSelf.textField);
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.isDataArray == YES) {
        return self.dataArray.count != 0 ? self.dataArray.count : 0;
    } else {
        return self.changeArray.count > 0 ? self.changeArray.count : 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QQCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"qqCollectCell" forIndexPath:indexPath];
    
    cell.timeData = self.isDataArray == YES ? self.dataArray[indexPath.item] : self.changeArray[indexPath.item];
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QQTestViewController * testVC = [QQTestViewController new];
  
    testVC.qqStr = self.isDataArray == YES ? self.dataArray[indexPath.item] : self.changeArray[indexPath.item];
    
    [self.navigationController pushViewController:testVC animated:YES];
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.delegate = self;
        _textField.layer.borderColor = [UIColor whiteColor].CGColor;
        _textField.layer.borderWidth = 1.0f;
        _textField.layer.cornerRadius = 5.0f;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.placeholder = @"请输入您要测QQ号码";
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_textField.frame))];
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (UIButton *)changeBtn {
    if (!_changeBtn) {
        _changeBtn = [UIButton new];
        _changeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_changeBtn setTitle:@"换一批" forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_changeBtn addTarget:self action:@selector(changeAcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}

- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [UIButton new];
        _testBtn.layer.cornerRadius = 5.0f;
        _testBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _testBtn.layer.borderWidth = 1.0f;
        _testBtn.backgroundColor = INMUIColorWithRGB(0x96CDCD, 1.0);
        [_testBtn setTitle:@"立即测试" forState:UIControlStateNormal];
        [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_testBtn addTarget:self action:@selector(testAcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testBtn;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 行间距
        layout.minimumLineSpacing = INMFit(10);
        layout.minimumInteritemSpacing = INMFit(10);
        //设置每个item的大小
        layout.itemSize = CGSizeMake((INMScreenW - INMFit(50))/4, INMFit(40));
        layout.sectionInset = UIEdgeInsetsMake( 0, INMFit(10), 0, INMFit(10)); //设置距离上 左 下 右
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[QQCollectionCell class] forCellWithReuseIdentifier:@"qqCollectCell"];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (UILabel *)recommendLabel {
    if (!_recommendLabel) {
        _recommendLabel = [UILabel new];
        _recommendLabel.font = [UIFont boldSystemFontOfSize:20];
        _recommendLabel.text = @"吉祥号:";
        _recommendLabel.textColor = [UIColor whiteColor];
    }
    return _recommendLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.text = @"请输入您要测评的QQ号码";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"123456",@"721521",@"666666",@"88888888",@"98765",@"34567",@"120110",@"667788", nil];
    }
    return _dataArray;
}

- (NSMutableArray *)changeArray {
    if (!_changeArray) {
        _changeArray = [NSMutableArray arrayWithObjects:@"3344",@"778899",@"1314520",@"6666",@"45678",@"999",@"787878",@"7654321", nil];
    }
    return _changeArray;
}


// 立即测试
- (void) testAcion:(UIButton *) sender {
    QQTestViewController * testVC = [QQTestViewController new];
    if (self.textField.text.length > 0) {
        testVC.qqStr = self.textField.text;
        [self.navigationController pushViewController:testVC animated:YES];
    }else
        [SVProgressHUD showErrorWithStatus:@"请先输入QQ号"];
}

// 换一批
- (void) changeAcion: (UIButton *) sender {
    if (self.isDataArray == YES) {
        self.isDataArray = NO;
    } else {
        self.isDataArray = YES;
    }
    
    [self.collectionView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.textField.text = @"";
}


@end
