//
//  LJX_LoginViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/17.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_LoginViewController.h"
#import "LJX_RegistViewController.h"

@interface LJX_LoginViewController ()

@property (nonatomic , strong) UILabel * nameLabel;

@property (nonatomic , strong) UITextField * nameTF;

@property (nonatomic , strong) UILabel * nameBtmLine;

@property (nonatomic , strong) UILabel * pwLabel;

@property (nonatomic , strong) UITextField * pwTF;

@property (nonatomic , strong) UILabel * pwBtmLine;

@property (nonatomic , strong) UIButton * loginBtn;

@end

@implementation LJX_LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0xA2B5CD, 1.0) SecondColor:INMUIColorWithRGB(0x66CDAA, 1.0) WithView:self.view];

    [self setupNav];
    
    [self configUI];
}

- (void) requestLogin {
    
    NSDictionary * dict = @{
                            @"apikey" : [[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"],
                            @"name" : self.nameTF.text,
                            @"passwd" : self.pwTF.text
                            };
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:@"https://api.apiopen.top/loginUser" params:dict successBlock:^(id obj) {
        NSLog(@"loginObj = %@",obj);
        
        if ([obj[@"code"] integerValue] == 200) {
            NSUserDefaults *tokenUDF = [NSUserDefaults standardUserDefaults];
            [tokenUDF setValue:@"YES" forKey:@"member_id"];
            [tokenUDF setValue:self.nameTF.text forKey:@"userName"];
            [tokenUDF synchronize];
            
            [[NSUserDefaults standardUserDefaults] objectForKey:@"member_id"];
            [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"authResult" object:nil userInfo:@{@"isAuth":@"YES"}];

            [self back];
        }else {
            [SVProgressHUD showErrorWithStatus:obj[@"message"]];
            return ;
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

#pragma mark - 登录Action
- (void) loginAcion:(UIButton *)sender {
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写用户名"];
        return;
    }
    if (self.pwTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写密码"];
        return;
    }
    
    [self requestLogin];
}

- (void) registAction {
    NSLog(@"注册");
    [self.navigationController pushViewController:[LJX_RegistViewController new] animated:YES];
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview: self.nameLabel];
    [self.view addSubview: self.nameTF];
    [self.view addSubview: self.nameBtmLine];
    [self.view addSubview: self.pwLabel];
    [self.view addSubview: self.pwTF];
    [self.view addSubview: self.pwBtmLine];
    [self.view addSubview: self.loginBtn];
    
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
    
    [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.pwBtmLine.mas_bottom).offset (INMFit(50));
        make.height.left.right.mas_equalTo (weakSelf.nameLabel);
    }];
}

#pragma mark - 设置导航栏
- (void) setupNav {
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registAction)];
}

- (void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"用户名";
        _nameLabel.font = [UIFont boldSystemFontOfSize:25];//NAFontSize(25);
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UITextField *)nameTF {
    if (!_nameTF) {
        _nameTF = [UITextField new];
        _nameTF.font = [UIFont systemFontOfSize:14];//NAFontSize(14);
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
        _pwTF.font = self.nameTF.font;
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

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton new];
        _loginBtn.layer.cornerRadius = 5.0f;
        _loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _loginBtn.layer.borderWidth = 1.0f;
        _loginBtn.backgroundColor = INMUIColorWithRGB(0x96CDCD, 1.0);
        [_loginBtn setTitle:@"登     录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginAcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

@end
