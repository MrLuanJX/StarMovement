//
//  TodayCell.m
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "TodayCell.h"

@interface TodayCell()

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UILabel * desLabel;

@property (nonatomic , strong) UILabel * dateLabel;

@property (nonatomic , strong) UILabel * lunarLabel;

@property (nonatomic , strong) UIImageView * img;

@end

@implementation TodayCell

- (void)setTodayModel:(TodayModel *)todayModel {
    _todayModel = todayModel;
    
    self.titleLabel.text = self.todayModel.title;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:self.todayModel.pic] placeholderImage:[UIImage imageNamed:@"icon-60"]];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ 年 %@ 月 %@ 日",self.todayModel.year,self.todayModel.month,self.todayModel.day];
    
    self.lunarLabel.text = self.todayModel.lunar;
    
    self.desLabel.text = self.todayModel.des;
}

//创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    TodayCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        
        cell=[[TodayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
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
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.desLabel];
    [self.contentView addSubview: self.dateLabel];
    [self.contentView addSubview: self.lunarLabel];
    [self.contentView addSubview: self.img];
}

- (void) createConstrainte {
    __weak typeof (self) weakSelf = self;
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo (INMFit(15));
        make.right.mas_equalTo (-INMFit(15));
        make.height.mas_equalTo (INMFit(30));
    }];
    [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.titleLabel.mas_bottom).offset (INMFit(10));
        make.left.mas_equalTo (weakSelf.titleLabel);
        make.width.height.mas_equalTo (INMFit(100));
    }];
    
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.img.mas_top);
        make.right.height.mas_equalTo(weakSelf.titleLabel);
        make.left.mas_equalTo (weakSelf.img.mas_right).offset (INMFit(10));
    }];
    
    [self.lunarLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.dateLabel.mas_bottom);
        make.left.right.height.mas_equalTo (weakSelf.dateLabel);
    }];
    
    [self.desLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.img.mas_bottom).offset (INMFit(10));
        make.left.right.mas_equalTo (weakSelf.titleLabel);
        make.bottom.mas_equalTo (weakSelf.contentView).offset(-INMFit(15));
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _titleLabel;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [UILabel new];
        _desLabel.font = [UIFont systemFontOfSize:15];
        _desLabel.numberOfLines = 0;
    }
    return _desLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont boldSystemFontOfSize:15];
        _dateLabel.textColor = [UIColor blackColor];
    }
    return _dateLabel;
}

- (UILabel *)lunarLabel{
    if (!_lunarLabel) {
        _lunarLabel = [UILabel new];
        _lunarLabel.font = [UIFont boldSystemFontOfSize:15];
        _lunarLabel.textColor = INMUIColorWithRGB(0x8B0000, 1.0);
    }
    return _lunarLabel;
}

- (UIImageView *)img {
    if (!_img) {
        _img = [UIImageView new];
    }
    return _img;
}


-(NSMutableAttributedString *)setUpinformationMoneyLabel:(NSString *)money unit:(NSString *)unit{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",money,unit]];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:kSetUpCololor(107, 107, 107, 1.0)
                range:NSMakeRange(0,[money length])];
    [str addAttribute:NSForegroundColorAttributeName
                value:kSetUpCololor(107, 107, 107, 1.0)
                range:NSMakeRange([money length],[unit length])];
    
    [str addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:12]
                range:NSMakeRange(0, [money length])];
    [str addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:12]
                range:NSMakeRange([money length], [unit length])];
    return str;
}


@end
