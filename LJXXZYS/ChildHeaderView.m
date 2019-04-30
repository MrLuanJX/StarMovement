//
//  ChildHeaderView.m
//  LJXXZYS
//
//  Created by a on 2019/4/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "ChildHeaderView.h"
#import "UIView+Extension.h"

@interface ChildHeaderView()

@property (nonatomic , strong) UIView * backView;

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UIView * lineView;

@end

@implementation ChildHeaderView

- (void)setChildModel:(ChildModel *)childModel {
    _childModel = childModel;
    
    NSString * htmlString = childModel.name;//childModel.content;
    if ([childModel.content containsString:@"<p>"]) {
        NSString *strUrl = [htmlString stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        NSString * htmlStr = [strUrl stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
        NSLog(@"strUrl = %@ , htmlStr = %@",strUrl , htmlStr);
        self.titleLabel.text = htmlStr;
    } else if ([childModel.content containsString:@"&quot;"]) {
        NSString * htmlStr = [childModel.content stringByReplacingOccurrencesOfString:@"&quot;" withString:@"“"];
        self.titleLabel.text = htmlStr;
    } else if ([childModel.content containsString:@"&lt;"]) {
        NSString * htmlStr = [childModel.content stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        if ([htmlStr containsString:@"&amp;"]) {
            htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"&amp;" withString:@">"];
        }
        self.titleLabel.text = htmlStr;
    } else if ([childModel.content containsString:@"&middot;"]) {
        NSString * htmlStr = [childModel.content stringByReplacingOccurrencesOfString:@"&middot;" withString:@"."];
        self.titleLabel.text = htmlStr;
    }
    else {
        self.titleLabel.text = childModel.content;  //childModel.name;//
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    return self;
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    [self addSubview: self.backView];
    [self.backView addSubview: self.titleLabel];
    [self.backView addSubview: self.backBtn];
    [self addSubview: self.lineView];
    
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (0);
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (0);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo (-INMFit(10));
        make.width.height.mas_equalTo (INMFit(30));
        make.centerY.mas_equalTo (weakSelf.mas_centerY);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo (weakSelf.backView);
        make.left.mas_equalTo (INMFit(10));
        make.right.mas_equalTo (weakSelf.backBtn.mas_left).offset (-INMFit(10));
    }];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.mas_bottom);
        make.left.right.mas_equalTo (weakSelf.backView);
        make.height.mas_equalTo (INMFit(1));
    }];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)]];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton new];
        [_backBtn setImage:[UIImage imageNamed:@"向下箭头-4"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = kSetUpCololor(225, 225, 225, 1.0);
    }
    return _lineView;
}

- (void) backAction{
    
    if ([self.delegate respondsToSelector:@selector(backAction:)]) {
        [self.delegate backAction:self];
    }
}

@end
