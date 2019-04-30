//
//  LJX_FeedbackViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/15.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_FeedbackViewController.h"

@interface LJX_FeedbackViewController () <UITextViewDelegate>

@property (nonatomic , strong) UITextView * FKTextView;
@property (nonatomic , strong) UILabel * descLab;
@property (nonatomic , strong) UIButton * sendBtn;
@property (nonatomic , strong) UILabel * stringlenghtLab;

@property (nonatomic , strong) UITextField * textField;

@end

@implementation LJX_FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0x191970, 1.0) SecondColor:INMUIColorWithRGB(0x4682B4, 1.0) WithView:self.view];

    [self configUI];
    
    self.descLab.userInteractionEnabled = NO;
    self.sendBtn.userInteractionEnabled = NO;
    self.sendBtn.backgroundColor = [UIColor lightGrayColor];
}

- (void) feedbackAction {
    [self requestData];
}

- (void) requestData {
    NSUserDefaults *tokenUDF = [NSUserDefaults standardUserDefaults];
    if (self.FKTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先填写您要反馈的意见"];
        return;
    }
    
    if (self.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请留下您的email，以便我们及时联系您"];
        return;
    }
    
    NSDictionary * dict = @{
                            @"apikey" : [tokenUDF objectForKey:@"apikey"],
                            @"text" : self.FKTextView.text.length > 0 ? self.FKTextView.text : @"",
                            @"email" : self.textField.text.length > 0 ? self.textField.text : @""
                            };
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:@"https://api.apiopen.top/userFeedback" params:dict successBlock:^(id obj) {
        
        NSLog(@"feedBack = %@",obj);
        
        if ([obj[@"code"] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"反馈成功"];
        }else {
            [SVProgressHUD showErrorWithStatus:obj[@"message"]];
            return ;
        }
        
        [self performSelector:@selector(after) withObject:self afterDelay:1.0];
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

- (void) after {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview: self.FKTextView];
    [self.FKTextView addSubview:self.descLab];
    [self.view addSubview: self.sendBtn];
    [self.view addSubview: self.textField];
    [self.view addSubview: self.stringlenghtLab];
    
    [self.FKTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(INMFit(114));
        make.left.mas_equalTo(INMFit(20));
        make.right.mas_equalTo(-INMFit(20));
        make.height.mas_equalTo(INMFit(200));
    }];
    
    [self.descLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(INMFit(7));
        make.right.mas_equalTo(weakSelf.FKTextView);
        make.height.mas_equalTo(INMFit(20));
    }];
    
    [self.stringlenghtLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.FKTextView.mas_bottom);
        make.right.mas_equalTo (weakSelf.FKTextView.mas_right);
        make.height.mas_equalTo (INMFit(20));
    }];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.stringlenghtLab.mas_bottom).offset (INMFit(30));
        make.left.right.mas_equalTo (weakSelf.FKTextView);
        make.height.mas_equalTo (INMFit(40));
    }];
    
    [self.sendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.textField.mas_bottom).offset (INMFit(50));
        make.left.right.mas_equalTo (weakSelf.FKTextView);
        make.height.mas_equalTo (INMFit(40));
    }];
}

-(void)textViewDidChange:(UITextView *)textView{
    self.descLab.hidden = YES;
    self.sendBtn.userInteractionEnabled = YES;
    self.sendBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
    //实时显示字数
    self.stringlenghtLab.text = [NSString stringWithFormat:@"%ld/200",(long)textView.text.length];
    
    //字数限制
    if (textView.text.length >= 200) {
        textView.text = [textView.text substringToIndex:200];
    }
    
    //取消按钮点击权限，并显示文字
    if (textView.text.length == 0) {
        self.descLab.hidden = NO;
        self.sendBtn.userInteractionEnabled = NO;
        self.sendBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [self.FKTextView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.placeholder = @"留下您的email，以便我们及时沟通";
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textField.layer.borderWidth = 1.0f;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, CGRectGetWidth(_textField.frame))];
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (UITextView *)FKTextView {
    if (!_FKTextView) {
        _FKTextView = [UITextView new];
        _FKTextView.backgroundColor = [UIColor whiteColor];
        _FKTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _FKTextView.layer.borderWidth = 1.0f;
        _FKTextView.font = [UIFont systemFontOfSize:14];
        _FKTextView.delegate = self;
    }
    return _FKTextView;
}

- (UILabel *)descLab {
    if (!_descLab) {
        _descLab = [UILabel new];
        _descLab.text = @"请输入内容";
        _descLab.font = [UIFont systemFontOfSize:14];
        _descLab.textColor = INMUIColorWithRGB(0xC1C1C1, 1.0);
    }
    return _descLab;
}

- (UILabel *)stringlenghtLab {
    if (!_stringlenghtLab) {
        _stringlenghtLab = [UILabel new];
        _stringlenghtLab.font = [UIFont systemFontOfSize:13];
        _stringlenghtLab.textColor = [UIColor lightGrayColor];
        _stringlenghtLab.textAlignment = NSTextAlignmentRight;
        _stringlenghtLab.text = @"0/200";
    }
    return _stringlenghtLab;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [UIButton new];
        [_sendBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(feedbackAction) forControlEvents:UIControlEventTouchUpInside];
        [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    }
    return _sendBtn;
}

@end
