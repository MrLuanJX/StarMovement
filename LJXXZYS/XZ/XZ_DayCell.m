//
//  XZ_DayCell.m
//  LJXXZYS
//
//  Created by 栾金鑫 on 2019/4/14.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "XZ_DayCell.h"

@interface XZ_DayCell()

@property (nonatomic , strong) UILabel * des;

@property (nonatomic , strong) UIProgressView * progress;

@property (nonatomic , strong) MASConstraint * progressWidth;

@end

@implementation XZ_DayCell

-(void)setModel:(XZ_Model *)model{
    _model = model;
}

-(void)setIndex:(NSIndexPath *)index{
    _index = index;

    if (index.row == 0) {
        self.des.text = self.model.datetime;
        self.progressWidth.mas_equalTo(0);
    }if (index.row == 1) {
        self.des.text = self.model.all;
        self.progress.progress = [self.model.all floatValue]/100;
    }if (index.row == 2) {
        self.des.text = self.model.health;
        self.progress.progress = [self.model.health floatValue]/100;
    }if (index.row == 3) {
        self.des.text = self.model.love;
        self.progress.progress = [self.model.love floatValue]/100;
    }if (index.row == 4) {
        self.des.text = self.model.money;
        self.progress.progress = [self.model.money floatValue]/100;
    }if (index.row == 5) {
        self.des.text = self.model.work;
        self.progress.progress = [self.model.work floatValue]/100;
    }if (index.row == 6) {
        self.progressWidth.mas_equalTo(0);
        self.des.text = self.model.color;
    }if (index.row == 7) {
        self.progressWidth.mas_equalTo(0);
        self.des.text = self.model.number;
    }if (index.row == 8) {
        self.progressWidth.mas_equalTo(0);
        self.des.text = self.model.QFriend;
    }if (index.row == 9) {
        self.des.text = self.model.summary;
        self.progressWidth.mas_equalTo(0);
    }
}

//创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    XZ_DayCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        
        cell=[[XZ_DayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
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
    [self.contentView addSubview: self.progress];
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
        make.left.mas_equalTo(weakSelf.progress.mas_right).offset(INMFit(10));
        make.right.mas_equalTo(-INMFit(10));
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-10);
    }];
    
    [self.progress mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (weakSelf.title.mas_centerY);
        make.left.mas_equalTo(weakSelf.title.mas_right).offset(INMFit(10));
        weakSelf.progressWidth = make.width.mas_equalTo(INMFit(150));
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

- (UIProgressView *)progress {
    if (!_progress) {
        _progress = [UIProgressView new];
        _progress.tintColor = [UIColor redColor];
        _progress.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    }
    return _progress;
}

@end
