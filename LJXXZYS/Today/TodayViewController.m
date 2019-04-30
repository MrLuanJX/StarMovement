//
//  TodayViewController.m
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "TodayViewController.h"
#import "TodayUnderstandViewController.h"

@interface TodayCollectionCell ()

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , copy) NSString * timeData;

@end

@implementation TodayCollectionCell

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

@interface TodayViewController () <UITextFieldDelegate , UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UITextField * monthTextField;

@property (nonatomic , strong) UITextField * dayTextField;

@property (nonatomic , strong) UILabel * dayLabel;

@property (nonatomic , strong) UILabel * monthLabel;

@property (nonatomic , strong) UIButton * todayBtn;

@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) NSMutableArray * dataArray;

@property (nonatomic , strong) NSMutableArray * monthArray;

@property (nonatomic , strong) NSMutableArray * dayArray;

@property (nonatomic , strong) UILabel * recommendLabel;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = INMUIColorWithRGB(0xA2B5CD, 1.0);
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0x8B8989, 1.0) SecondColor:INMUIColorWithRGB(0xA2B5CD, 1.0) WithView:self.view];
    
    [self configUI];
    
    [self createConstrainte];
    
}

- (void) configUI {
    [self.view addSubview: self.monthTextField];
    [self.view addSubview: self.dayLabel];
    [self.view addSubview: self.dayTextField];
    [self.view addSubview: self.monthLabel];
    [self.view addSubview: self.todayBtn];
    [self.view addSubview: self.titleLabel];
    [self.view addSubview: self.monthLabel];
    [self.view addSubview: self.dayLabel];
    [self.view addSubview: self.collectionView];
    [self.view addSubview: self.recommendLabel];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray != 0 ? self.dataArray.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TodayCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"todayCollectCell" forIndexPath:indexPath];
    
    cell.timeData = self.dataArray[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TodayUnderstandViewController * todayUVC = [TodayUnderstandViewController new];
    
    todayUVC.month = self.monthArray[indexPath.item];
    todayUVC.day = self.dayArray[indexPath.item];
    
    [self.navigationController pushViewController:todayUVC animated:YES];
}

- (void) createConstrainte {
    __weak typeof (self) weakSelf = self;
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (INMFit(100));
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(INMFit(40));
    }];
    
    NSInteger padding = INMFit(30);
    [@[self.monthTextField, self.monthLabel, self.dayTextField,self.dayLabel] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];
    
    [@[self.monthTextField, self.monthLabel, self.dayTextField,self.dayLabel] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(INMFit(40));
        make.height.mas_equalTo(INMFit(60));
    }];
    
    [self.recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.monthLabel.mas_bottom).offset (INMFit(40));
        make.left.mas_equalTo (INMFit(10));
        make.right.mas_equalTo (-INMFit(10));
        make.height.mas_equalTo (INMFit(40));
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.recommendLabel.mas_bottom).offset (INMFit(15));
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(INMFit(100));
    }];

    [self.todayBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.collectionView.mas_bottom).offset (INMFit(50));
        make.left.mas_equalTo (INMFit(40));
        make.right.mas_equalTo (-INMFit(40));
        make.height.mas_equalTo(INMFit(40));
    }];
}

#pragma mark -给每个cell中的textfield添加事件，只要值改变就调用此函数
- (void)changedTextField:(UITextField *)textField {
    NSLog(@"值是---%@",textField.text);
    
}

#pragma mark textfield的代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //敲删除键
    if ([string length] == 0) {
        return YES;
    }
   
    if (textField.text.length >= 2) return NO;//当前是手机号码
    
    return YES;
}

- (UITextField *)monthTextField {
    if (!_monthTextField) {
        _monthTextField = [UITextField new];
        _monthTextField.delegate = self;
        _monthTextField.layer.borderColor = [UIColor whiteColor].CGColor;
        _monthTextField.layer.borderWidth = 1.0f;
        _monthTextField.layer.cornerRadius = 5.0f;
        _monthTextField.keyboardType = UIKeyboardTypeNumberPad;
        _monthTextField.textColor = [UIColor whiteColor];
        _monthTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, INMFit(20), CGRectGetWidth(_monthTextField.frame))];
        _monthTextField.leftViewMode = UITextFieldViewModeAlways;
        [_monthTextField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventAllEditingEvents];
    }
    return _monthTextField;
}

- (UITextField *)dayTextField {
    if (!_dayTextField) {
        _dayTextField = [UITextField new];
        _dayTextField.delegate = self;
        _dayTextField.layer.borderColor = [UIColor whiteColor].CGColor;
        _dayTextField.layer.borderWidth = 1.0f;
        _dayTextField.layer.cornerRadius = 5.0f;
        _dayTextField.keyboardType = UIKeyboardTypeNumberPad;
        _dayTextField.textColor = [UIColor whiteColor];
        _dayTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, INMFit(20), CGRectGetWidth(_dayTextField.frame))];
        _dayTextField.leftViewMode = UITextFieldViewModeAlways;
        [_dayTextField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventAllEditingEvents];
    }
    return _dayTextField;
}

- (UIButton *)todayBtn {
    if (!_todayBtn) {
        _todayBtn = [UIButton new];
        _todayBtn.layer.cornerRadius = 5.0f;
        _todayBtn.backgroundColor = INMUIColorWithRGB(0x6C7B8B, 1.0);
        _todayBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _todayBtn.layer.borderWidth = 1.0f;
        [_todayBtn setTitle:@"立即了解" forState:UIControlStateNormal];
        [_todayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_todayBtn addTarget:self action:@selector(todayAcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _todayBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"请输入您要了解的日期";
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [UILabel new];
        _monthLabel.text = @"月";
        _monthLabel.font = [UIFont systemFontOfSize:17];
        _monthLabel.textColor = [UIColor whiteColor];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _monthLabel;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [UILabel new];
        _dayLabel.text = @"日";
        _dayLabel.font = [UIFont systemFontOfSize:17];
        _dayLabel.textColor = [UIColor whiteColor];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dayLabel;
}

- (UILabel *)recommendLabel {
    if (!_recommendLabel) {
        _recommendLabel = [UILabel new];
        _recommendLabel.font = [UIFont boldSystemFontOfSize:20];
        _recommendLabel.text = @"热门日期:";
        _recommendLabel.textColor = [UIColor whiteColor];
    }
    return _recommendLabel;
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
        [_collectionView registerClass:[TodayCollectionCell class] forCellWithReuseIdentifier:@"todayCollectCell"];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (void) todayAcion:(UIButton *)sender {
    
    if (self.monthTextField.text.length == 0 || self.dayTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先输入您要了解的日期"];
        return;
    }
    
    TodayUnderstandViewController * todayUVC = [TodayUnderstandViewController new];
    if ([self.monthTextField.text integerValue] > 12) {
        [SVProgressHUD showErrorWithStatus:@"请输入有效的月份"];
        return;
    }
    
    if ([self.dayTextField.text integerValue] > 31) {
        [SVProgressHUD showErrorWithStatus:@"请输入有效的日期"];
        return;
    }
    
    if (self.monthTextField.text.length > 0) {
        todayUVC.month = self.monthTextField.text;
    }
    if (self.dayTextField.text.length > 0) {
        todayUVC.day = self.dayTextField.text;
    }
    [self.navigationController pushViewController:todayUVC animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.monthTextField.text = @"";
    self.dayTextField.text = @"";
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"1月1日",@"4月5日",@"5月1日",@"7月1日",@"8月1日",@"9月10日",@"10月1日",@"12月25日", nil];
    }
    return _dataArray;
}

- (NSMutableArray *)monthArray {
    if (!_monthArray) {
        _monthArray = [NSMutableArray arrayWithObjects:@"1",@"4",@"5",@"7",@"8",@"9",@"10",@"12", nil];
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    if (!_dayArray) {
        _dayArray = [NSMutableArray arrayWithObjects:@"1",@"5",@"1",@"1",@"1",@"10",@"1",@"25", nil];
    }
    return _dayArray;
}

@end
