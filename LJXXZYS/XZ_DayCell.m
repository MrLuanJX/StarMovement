//
//  XZ_DayCell.m
//  LJXXZYS
//
//  Created by 栾金鑫 on 2019/4/14.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "XZ_DayCell.h"

@interface XZ_DayCell()


@end


@implementation XZ_DayCell

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
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(weakSelf.title.mas_right).offset(INMFit(10));
        make.right.mas_equalTo(-INMFit(10));
        make.width.mas_equalTo(INMFit(100));
        make.bottom.mas_equalTo(weakSelf.contentView);
    }];
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = INMUIColorWithRGB(0xDC143C, 1.0);
        _title.font = [UIFont boldSystemFontOfSize:16];
    }
    return _title;
}

- (UILabel *)des {
    if (!_des) {
        _des = [UILabel new];
        _des.font = [UIFont systemFontOfSize:16];
    }
    return _des;
}

@end
