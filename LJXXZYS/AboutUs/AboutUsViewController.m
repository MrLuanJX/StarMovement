//
//  AboutUsViewController.m
//  LJXXZYS
//
//  Created by a on 2019/4/22.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (nonatomic , strong) UIImageView * logoImg;

@property (nonatomic , strong) UILabel * desLabel;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0x191970, 1.0) SecondColor:INMUIColorWithRGB(0x4682B4, 1.0) WithView:self.view];
    
    [self configUI];
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview: self.logoImg];
    
    [self.view addSubview: self.desLabel];
    
    [self.logoImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (INMFit(120));
        make.centerX.mas_equalTo (weakSelf.view.mas_centerX);
        make.height.width.mas_equalTo (INMFit(90));
    }];
    
    [self.desLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.logoImg.mas_bottom).offset (INMFit(50));
        make.left.mas_equalTo (INMFit(30));
        make.right.mas_equalTo (-INMFit(30));
    }];
}

- (UIImageView *)logoImg {
    if (!_logoImg) {
        _logoImg = [UIImageView new];
        _logoImg.image = [UIImage imageNamed:@"icon-60"];
        _logoImg.layer.cornerRadius = 10.0f;
        _logoImg.layer.masksToBounds = YES;
    }
    return _logoImg;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [UILabel new];
        _desLabel.text = @"1、星运大师app是一款根据星座测试集合单日运势，星期运势，本月运势，年度运势为一体的星运测试手机软件，星运大师是星座控必备的口袋星座App\n\n2、星运大师集合Q号吉凶，想知道QQ号码数理评分吗？想知道QQ号码与您的八字相合吗？想预测获得QQ号码后2年及10年的运势影响吗？想知道您用什么QQ号码最有利吗？抓紧使用星运大师QQ号码测吉凶吧。\n\n3、星运大师集成历史上的今天， 让你对历史上的每一天更加了解";
        _desLabel.textColor = [UIColor lightGrayColor];
        _desLabel.font = [UIFont systemFontOfSize:18];
        _desLabel.numberOfLines = 0;
        _desLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _desLabel;
}

@end
