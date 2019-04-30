//
//  NoContentView.m
//  LJXXZYS
//
//  Created by a on 2019/4/24.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "NoContentView.h"

@interface  NoContentView ()

@property (nonatomic , strong) UILabel * contentLabel;

@property (nonatomic , copy) NSString * content;

@end

@implementation NoContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    return self;
}

- (void)setContent:(NSString *)content {
    _content = content;
    
    self.contentLabel.text = content;
}

- (void) configUI {
    __weak typeof  (self) weakSelf = self;
    
    [self addSubview: self.contentLabel];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (weakSelf.mas_centerY);
        make.left.right.mas_equalTo (0);
    }];
}

- (UILabel *) contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont boldSystemFontOfSize:20];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
