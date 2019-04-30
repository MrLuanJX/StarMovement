//
//  APPRootViewController.m
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "APPRootViewController.h"
#import "XZ_RootViewController.h"
#import "QQSearchViewController.h"
#import "TodayViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "LJX_LoginViewController.h"

@interface APPRootViewController ()

@property (nonatomic , strong) UIButton * xzBtn;

@property (nonatomic , strong) UIButton * qqBtn;

@property (nonatomic , strong) UIButton * todayBtn;

@end

@implementation APPRootViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    //同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = INMUIColorWithRGB(0x191970, 1.0);
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0x191970, 1.0) SecondColor:INMUIColorWithRGB(0x4682B4, 1.0) WithView:self.view];
    
    [self configUI];
    [self createConstrainte];
    
    [self setNav];
    
    NSString * str = [self getDateYearMonth];
    NSLog(@"str = %@", str);
    
    NSArray * arr = [self getString:str];
    NSLog(@"arr:%@",arr);
}

- (void) setNav {
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

- (NSString *)getDateYearMonth {
    NSDate *newDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | kCFCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:newDate];
//    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    return [NSString stringWithFormat:@"%.2ld月%ld日",month,day];
}

- (NSArray *) getString:(NSString *)str {
    NSArray * array = [str componentsSeparatedByString:@"月"];
    NSString * lastObj = array.lastObject;
    lastObj = [lastObj substringToIndex:lastObj.length - 1];
    NSArray * lastArray = [NSArray arrayWithObjects:array.firstObject,lastObj, nil];
    return lastArray;
}

-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void) configUI {
    [self.view addSubview: self.xzBtn];
    [self.view addSubview: self.qqBtn];
    [self.view addSubview: self.todayBtn];
}

- (void) createConstrainte {

    NSInteger padding = INMFit(100);
    // 实现masonry垂直方向固定控件高度方法
    [@[self.xzBtn, self.qqBtn, self.todayBtn] mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];
    
    [@[self.xzBtn, self.qqBtn, self.todayBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(INMFit(60));
        make.right.mas_equalTo (-INMFit(60));
    }];
}

- (UIButton *)xzBtn {
    if (!_xzBtn) {
        _xzBtn = [UIButton new];
        [_xzBtn setTitle:@"星运大全" forState:UIControlStateNormal];
        [_xzBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _xzBtn.backgroundColor = [UIColor clearColor];
        _xzBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _xzBtn.layer.borderWidth = 2.0f;
        _xzBtn.layer.cornerRadius = 5.0f;
        _xzBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_xzBtn addTarget:self action:@selector(xzAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _xzBtn;
}

- (UIButton *)qqBtn {
    if (!_qqBtn) {
        _qqBtn = [UIButton new];
        [_qqBtn setTitle:@"Q号吉凶" forState:UIControlStateNormal];
        [_qqBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _qqBtn.backgroundColor = [UIColor clearColor];
        _qqBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _qqBtn.layer.borderWidth = 2.0f;
        _qqBtn.layer.cornerRadius = 5.0f;
        _qqBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_qqBtn addTarget:self action:@selector(qqAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqBtn;
}

- (UIButton *)todayBtn {
    if (!_todayBtn) {
        _todayBtn = [UIButton new];
        [_todayBtn setTitle:@"历史上的今天" forState:UIControlStateNormal];
        [_todayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _todayBtn.backgroundColor = [UIColor clearColor];
        _todayBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _todayBtn.layer.borderWidth = 2.0f;
        _todayBtn.layer.cornerRadius = 5.0f;
        _todayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_todayBtn addTarget:self action:@selector(todayAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _todayBtn;
}

- (void) xzAction:(UIButton *)sender {
    
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    NSString *member_id=[user objectForKey:@"member_id"];
    NSLog(@" member_id %@ ",member_id);
    if ([member_id isKindOfClass:[NSNull class]] || (member_id == nil) || (member_id == NULL) || [member_id isEqualToString:@"NO"]) {
        [self jumpLoginVC];
    }else {
        [self.navigationController pushViewController:[XZ_RootViewController new] animated:YES];
    }
}

- (void) qqAction:(UIButton *)sender {
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    NSString *member_id=[user objectForKey:@"member_id"];
    NSLog(@" member_id %@ ",member_id);
    if ([member_id isKindOfClass:[NSNull class]] || (member_id == nil) || (member_id == NULL) || [member_id isEqualToString:@"NO"]) {
        [self jumpLoginVC];
    }else {
        [self.navigationController pushViewController:[QQSearchViewController new] animated:YES];
    }
}

- (void) todayAction:(UIButton *)sender {
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    NSString *member_id=[user objectForKey:@"member_id"];
    NSLog(@" member_id %@ ",member_id);
    if ([member_id isKindOfClass:[NSNull class]] || (member_id == nil) || (member_id == NULL) || [member_id isEqualToString:@"NO"]) {
        [self jumpLoginVC];
    }else {
        [self.navigationController pushViewController:[TodayViewController new] animated:YES];
    }
}

- (void) jumpLoginVC {
    [self.navigationController pushViewController:[LJX_LoginViewController new] animated:YES];
}


@end
