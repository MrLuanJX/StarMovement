//
//  XZ_YearCell.m
//  LJXXZYS
//
//  Created by a on 2019/4/15.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "XZ_YearCell.h"

@interface XZ_YearCell()

@property (nonatomic , strong) UILabel * title;

@property (nonatomic , strong) UILabel * des;

@end

@implementation XZ_YearCell

-(void)setIndex:(NSIndexPath *)index{
    _index = index;
    
    if (index.section == 0) {
        if (index.row == 0) {
            self.title.text =  @"概   述:";
            self.des.text = [NSString stringWithFormat:@"%@",self.model.info];
        }
        if (index.row == 1) {
            self.title.text =  @"说   明:";
            self.des.text = [NSString stringWithFormat:@"%@", [self.model.text componentsJoinedByString:@""]];
        }
    } else if (index.section == 1) {
        self.title.text =  @"事   业:";
        self.des.text = [NSString stringWithFormat:@"%@", [self.model.career componentsJoinedByString:@""]];
    } else if (index.section == 2) {
        self.title.text =  @"爱   情:";
        self.des.text = [NSString stringWithFormat:@"%@", [self.model.love componentsJoinedByString:@""]];
    } else if (index.section == 3) {
        self.title.text =  @"财   运:";
        self.des.text = [NSString stringWithFormat:@"%@", [self.model.finance componentsJoinedByString:@""]];
    } else if (index.section == 4) {
        self.title.text =  @"健   康:";
        self.des.text = [NSString stringWithFormat:@"%@", [self.model.health componentsJoinedByString:@""]];
    } else if (index.section == 5) {
        self.title.text =  @"开运石:";
        self.des.text = self.model.luckeyStone;
    } else if (index.section == 6) {
        self.title.text =  @"未   来:";
        self.des.text = self.model.future;
    }
}

-(void)setModel:(XZ_YearModel *)model{
    _model = model;
}

//创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    XZ_YearCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[XZ_YearCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
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
        make.width.mas_equalTo(INMFit(60));
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

