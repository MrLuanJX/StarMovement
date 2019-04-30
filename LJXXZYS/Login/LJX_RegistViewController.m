//
//  LJX_RegistViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/17.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_RegistViewController.h"

@interface LJX_RegistViewController ()

@property (nonatomic , strong) UILabel * nameLabel;

@property (nonatomic , strong) UITextField * nameTF;

@property (nonatomic , strong) UILabel * nameBtmLine;

@property (nonatomic , strong) UILabel * pwLabel;

@property (nonatomic , strong) UITextField * pwTF;

@property (nonatomic , strong) UILabel * pwBtmLine;

@property (nonatomic , strong) UIButton * registBtn;

@end

@implementation LJX_RegistViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0xA2B5CD, 1.0) SecondColor:INMUIColorWithRGB(0x66CDAA, 1.0) WithView:self.view];
    
    [self configUI];
}

#pragma mark - 注册Action
- (void) registAcion:(UIButton *)sender {
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写用户名"];
        return;
    }
    if (self.pwTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写密码"];
        return;
    }
    
    [self requestRegist];
}

- (void) requestRegist {
    NSDictionary * dict = @{
                            @"apikey" : [[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"],
                            @"name" : self.nameTF.text,
                            @"passwd" : self.pwTF.text
                            };
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:@"https://api.apiopen.top/registerUser" params:dict successBlock:^(id obj) {
        NSLog(@"registObj = %@",obj);
        
        if ([obj[@"code"] integerValue] == 200) {
            
            NSUserDefaults *tokenUDF = [NSUserDefaults standardUserDefaults];
            [tokenUDF setValue:@"YES" forKey:@"member_id"];
            [tokenUDF setValue:self.nameTF.text forKey:@"userName"];
            [tokenUDF synchronize];
            
            [[NSUserDefaults standardUserDefaults] objectForKey:@"member_id"];
            [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"authResult" object:nil userInfo:@{@"isAuth":@"YES"}];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            [SVProgressHUD showErrorWithStatus:obj[@"message"]];
            return ;
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview: self.nameLabel];
    [self.view addSubview: self.nameTF];
    [self.view addSubview: self.nameBtmLine];
    [self.view addSubview: self.pwLabel];
    [self.view addSubview: self.pwTF];
    [self.view addSubview: self.pwBtmLine];
    [self.view addSubview: self.registBtn];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.view.frame.size.height/5);
        make.left.mas_equalTo (INMFit(30));
        make.right.mas_equalTo (-INMFit(30));
        make.height.mas_equalTo (INMFit(40));
    }];
    
    [self.nameTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.nameLabel.mas_bottom).offset(INMFit(10));
        make.left.right.height.mas_equalTo(weakSelf.nameLabel);
    }];
    
    [self.nameBtmLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.nameTF.mas_bottom).offset (INMFit(2));
        make.left.right.mas_equalTo (weakSelf.nameTF);
        make.height.mas_equalTo(INMFit(1));
    }];
    
    [self.pwLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.nameBtmLine.mas_bottom).offset(INMFit(30));
        make.left.right.height.mas_equalTo (weakSelf.nameLabel);
    }];
    
    [self.pwTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwLabel.mas_bottom).offset (INMFit(10));
        make.left.right.height.mas_equalTo (weakSelf.nameTF);
    }];
    
    [self.pwBtmLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwTF.mas_bottom).offset (INMFit(2));
        make.left.right.mas_equalTo (weakSelf.nameLabel);
        make.height.mas_equalTo (INMFit(1));
    }];
    
    [self.registBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwBtmLine.mas_bottom).offset (INMFit(50));
        make.height.left.right.mas_equalTo (weakSelf.nameLabel);
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"用户名";
        _nameLabel.font = [UIFont boldSystemFontOfSize:25];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UITextField *)nameTF {
    if (!_nameTF) {
        _nameTF = [UITextField new];
        _nameTF.font = [UIFont systemFontOfSize:14];
        _nameTF.backgroundColor = [UIColor clearColor];
        _nameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_nameTF.frame))];
        _nameTF.leftViewMode = UITextFieldViewModeAlways;
        _nameTF.textColor = [UIColor whiteColor];
    }
    return _nameTF;
}

- (UILabel *)nameBtmLine {
    if (!_nameBtmLine) {
        _nameBtmLine = [UILabel new];
        _nameBtmLine.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    }
    return _nameBtmLine;
}

- (UILabel *)pwLabel {
    if (!_pwLabel) {
        _pwLabel = [UILabel new];
        _pwLabel.text = @"密     码";
        _pwLabel.font = _nameLabel.font;
        _pwLabel.textColor = _nameLabel.textColor;
    }
    return _pwLabel;
}

- (UITextField *)pwTF {
    if (!_pwTF) {
        _pwTF = [UITextField new];
        _pwTF.font = self.nameTF.font;//NAFontSize(14);
        _pwTF.backgroundColor = [UIColor clearColor];
        _pwTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_nameTF.frame))];
        _pwTF.leftViewMode = UITextFieldViewModeAlways;
        _pwTF.textColor = [UIColor whiteColor];
    }
    return _pwTF;
}

- (UILabel *)pwBtmLine {
    if (!_pwBtmLine) {
        _pwBtmLine = [UILabel new];
        _pwBtmLine.backgroundColor = _nameBtmLine.backgroundColor;
    }
    return _pwBtmLine;
}

- (UIButton *)registBtn {
    if (!_registBtn) {
        _registBtn = [UIButton new];
        _registBtn.layer.cornerRadius = 5.0f;
        _registBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _registBtn.layer.borderWidth = 1.0f;
        _registBtn.backgroundColor = INMUIColorWithRGB(0x96CDCD, 1.0);
        [_registBtn setTitle:@"注    册" forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registBtn addTarget:self action:@selector(registAcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBtn;
}


@end
