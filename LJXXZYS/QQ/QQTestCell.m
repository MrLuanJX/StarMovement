//
//  QQTestCell.m
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "QQTestCell.h"

@interface QQTestCell()

@property (nonatomic , strong) UILabel * title;

@property (nonatomic , strong) UILabel * des;

@end

@implementation QQTestCell

- (void)setModel:(QQModel *)model {
    _model = model;
}

- (void)setIndex:(NSIndexPath *)index {
    _index = index;

    if (index.row == 0) {
        self.title.text = @"测试结果:";
        self.des.text = self.model.conclusion;
    }
    
    if (index.row == 1) {
        self.title.text = @"结果分析:";
        self.des.text = self.model.analysis;
    }
}

//创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    QQTestCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        
        cell=[[QQTestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createSubView];
        [self createConstrainte];
    }
    return self;
}

- (void) createSubView {
    [self.contentView addSubview: self.title];
    [self.contentView addSubview: self.des];
}

- (void) createConstrainte {
    __weak typeof  (self) weakSelf = self;
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(INMFit(10));
        make.width.mas_equalTo(INMFit(80));
        make.height.mas_greaterThanOrEqualTo(INMFit(50));
    }];
    
    [self.des mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(weakSelf.title.mas_right).offset(INMFit(10));
        make.right.mas_equalTo(-INMFit(10));
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-10);
    }];
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = INMUIColorWithRGB(0xDC143C, 1.0);
        _title.font = [UIFont boldSystemFontOfSize:16];
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}

- (UILabel *)des {
    if (!_des) {
        _des = [UILabel new];
        _des.font = [UIFont systemFontOfSize:16];
        _des.numberOfLines = 0;
    }
    return _des;
}

@end
