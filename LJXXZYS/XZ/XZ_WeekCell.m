//
//  XZ_WeekCell.m
//  LJXXZYS
//
//  Created by a on 2019/4/15.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "XZ_WeekCell.h"

@interface XZ_WeekCell ()

@property (nonatomic , strong) UILabel * title;

@property (nonatomic , strong) UILabel * des;

@property (nonatomic , strong) MASConstraint * widthFloat;

@end

@implementation XZ_WeekCell

-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
}

-(void)setIndex:(NSIndexPath *)index{
    _index = index;

    self.currentIndex == 3 ? self.widthFloat.mas_equalTo(INMFit(70)) : self.widthFloat.mas_equalTo(INMFit(40));
    
    self.title.textAlignment = self.currentIndex == 3 ? NSTextAlignmentLeft : NSTextAlignmentLeft;
    
    switch (index.row) {
        case 0:
            self.title.text = self.currentIndex == 3 ? @"月      份:" : @"日期:";
            self.des.text = self.currentIndex == 3 ? [NSString stringWithFormat:@"%@",self.model.date] : [NSString stringWithFormat:@"%@    当前第%@周",self.model.date,self.model.weekth];
            break;
        case 1:
            self.title.text = self.currentIndex == 3 ? @"健       康:" : @"健康:";
            self.des.text = self.model.health;
            break;
        case 2:
            self.title.text = self.currentIndex == 3 ? @"爱       情:" : @"爱情:";
            self.des.text = self.model.love;
            break;
        case 3:
            self.title.text = self.currentIndex == 3 ? @"工       作:" : @"工作:";
            self.des.text = self.model.work;
            break;
        case 4:
            self.title.text = self.currentIndex == 3 ? @"财       运:" : @"财运:";
            self.des.text = self.model.money;
            break;
        case 5:
            self.title.text = self.currentIndex == 3 ? @"综合运势:" : @"求职:";
            self.des.text = self.currentIndex == 3 ? self.model.all : self.model.job;
            break;
        default:
            break;
    }
}

-(void)setModel:(XZ_Model *)model{
    _model = model;
}

//创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    XZ_WeekCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        
        cell=[[XZ_WeekCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
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
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(INMFit(10));
        make.left.mas_equalTo(INMFit(10));
        weakSelf.widthFloat =  make.width.mas_equalTo(INMFit(40));
        make.height.mas_greaterThanOrEqualTo(INMFit(50));
    }];
    
    [self.des mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.title.mas_top);
        make.left.mas_equalTo(weakSelf.title.mas_right).offset(INMFit(10));
        make.right.mas_equalTo(-INMFit(10));
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-INMFit(10));
        make.centerY.mas_equalTo (weakSelf.title.mas_centerY);
    }];
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = INMUIColorWithRGB(0xDC143C, 1.0);
        _title.font = [UIFont boldSystemFontOfSize:17];
    }
    return _title;
}

- (UILabel *)des {
    if (!_des) {
        _des = [UILabel new];
        _des.textColor = [UIColor blackColor];
        _des.font = [UIFont systemFontOfSize:17];
        _des.numberOfLines = 0;
    }
    return _des;
}

@end
