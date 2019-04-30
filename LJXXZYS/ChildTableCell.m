//
//  ChildTableCell.m
//  LJXXZYS
//
//  Created by a on 2019/4/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "ChildTableCell.h"

@interface ChildTableCell()

@property (nonatomic , strong) UILabel * titleLabel;

@end

@implementation ChildTableCell

- (void)setChildModel:(NSString *)childModel {
    _childModel = childModel;
    
    if ([childModel containsString:@"<p>"]) {
        NSString *strUrl = [childModel stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        NSString * htmlStr = [strUrl stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
        NSLog(@"strUrl = %@ , htmlStr = %@",strUrl , htmlStr);
        self.titleLabel.attributedText = [self setUpFirstStr:@"答案：" SecondStr:htmlStr];
    } else if ([childModel containsString:@"&quot;"]) {
        NSString * htmlStr = [childModel stringByReplacingOccurrencesOfString:@"&quot;" withString:@"“"];
        self.titleLabel.attributedText = [self setUpFirstStr:@"答案：" SecondStr:htmlStr];
    } else if ([childModel containsString:@"&middot;"]) {
        NSString * htmlStr = [childModel stringByReplacingOccurrencesOfString:@"&middot;" withString:@"."];
        self.titleLabel.attributedText = [self setUpFirstStr:@"答案：" SecondStr:htmlStr];
    } else if ([childModel containsString:@"&lt;"]) {
        NSString * htmlStr = [childModel stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        if ([htmlStr containsString:@"&amp;"]) {
            htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"&amp;" withString:@">"];
        }
        self.titleLabel.attributedText = [self setUpFirstStr:@"答案：" SecondStr:htmlStr];
    } else {
        self.titleLabel.attributedText = [self setUpFirstStr:@"答案：" SecondStr:childModel];
    }
}

//创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    ChildTableCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        
        cell=[[ChildTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = kSetUpCololor(245, 245, 245, 1.0);
        
        [self configUI];
    }
    return self;
}

- (void) configUI {
    
    [self.contentView addSubview: self.titleLabel];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo (-INMFit(10));
        make.left.mas_equalTo (INMFit(20));
        make.right.mas_equalTo (-INMFit(10));
        make.top.mas_equalTo (INMFit(10));
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (NSMutableAttributedString*)setUpFirstStr:(NSString *)firstStr SecondStr:(NSString *)secondStr{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",firstStr,secondStr]];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:[UIColor redColor]
                range:NSMakeRange(0,[firstStr length])];
    [str addAttribute:NSForegroundColorAttributeName
                value:INMUIColorWithRGB(0x666666, 1.0)
                range:NSMakeRange([firstStr length],[secondStr length])];
    
    [str addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:16]
                range:NSMakeRange(0, [firstStr length])];
    [str addAttribute:NSFontAttributeName
                value:[UIFont boldSystemFontOfSize:16]
                range:NSMakeRange([firstStr length], [secondStr length])];
    
    
    return str;
}

@end
