//
//  LeftController.m
//  LeftMenu
//
//  Created by iMac on 17/4/24.
//  Copyright © 2017年 zws. All rights reserved.
//

#import "LeftController.h"
#import "UIViewController+MMDrawerController.h"
#import "XZ_RootViewController.h"
#import "QQSearchViewController.h"
#import "TodayViewController.h"
#import "LJX_FeedbackViewController.h"
#import "LJX_LoginViewController.h"
#import "AboutUsViewController.h"
#import "ChildTableViewController.h"
#import "RiddleCategoryViewController.h"


@interface LeftController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableview;

@property (nonatomic , assign) CGFloat fileSize;

@property (nonatomic , strong) UIButton * logOutBtn;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , assign) BOOL isAuth;

@end

@implementation LeftController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.isAuth = NO;
    
    [Gradient getGradientWithFirstColor:INMUIColorWithRGB(0x191970, 1.0) SecondColor:INMUIColorWithRGB(0x4682B4, 1.0) WithView:self.view];

    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    self.fileSize = [self folderSizeAtPath:libPath];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, INMScreenW-150, INMScreenH) style:UITableViewStyleGrouped];
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    self.tableview = tableview;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authResult:) name:@"authResult" object:nil];
}

- (void)authResult:(NSNotification *)noti{
    NSLog(@"登录成功");

    self.isAuth = [noti.userInfo[@"isAuth"] isEqualToString:@"YES"] ? YES : NO;
    NSLog(@"%d",self.isAuth);
    [self.tableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"星运大全";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Q号吉凶";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"历史上的今天";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"意见反馈";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"关于我们";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"清理缓存";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2lfM",self.fileSize];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
        NSString *member_id=[user objectForKey:@"member_id"];
        NSLog(@" member_id %@ ",member_id);
        if ([member_id isKindOfClass:[NSNull class]] || (member_id == nil) || (member_id == NULL) || [member_id isEqualToString:@"NO"]) {
            
            [self jumpLoginVC];
        }else {
            XZ_RootViewController *pushVC = [[XZ_RootViewController alloc] init];
            //拿到我们的LitterLCenterViewController，让它去push
            UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
            [nav pushViewController:pushVC animated:NO];
        }
    } else if (indexPath.row == 1) {
        NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
        NSString *member_id=[user objectForKey:@"member_id"];
        NSLog(@" member_id %@ ",member_id);
        if ([member_id isKindOfClass:[NSNull class]] || (member_id == nil) || (member_id == NULL) || [member_id isEqualToString:@"NO"]) {
            [self jumpLoginVC];
        }else {
            QQSearchViewController *pushVC = [[QQSearchViewController alloc] init];
            //拿到我们的LitterLCenterViewController，让它去push
            UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
            [nav pushViewController:pushVC animated:NO];
        }
    } else if (indexPath.row == 2) {
        NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
        NSString *member_id=[user objectForKey:@"member_id"];
        NSLog(@" member_id %@ ",member_id);
        if ([member_id isKindOfClass:[NSNull class]] || (member_id == nil) || (member_id == NULL) || [member_id isEqualToString:@"NO"]) {
            
            [self jumpLoginVC];

        }else {
            TodayViewController *pushVC = [[TodayViewController alloc] init];
            //拿到我们的LitterLCenterViewController，让它去push
            UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
            [nav pushViewController:pushVC animated:NO];
        }
    } else if (indexPath.row == 3) {
        LJX_FeedbackViewController *pushVC = [[LJX_FeedbackViewController alloc] init];
        //拿到我们的LitterLCenterViewController，让它去push
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:pushVC animated:NO];
    } else if (indexPath.row == 4) {
//        AboutUsViewController *pushVC = [[AboutUsViewController alloc] init];
        ChildTableViewController *pushVC = [ChildTableViewController new];
//        RiddleCategoryViewController *pushVC = [RiddleCategoryViewController new];
        //拿到我们的LitterLCenterViewController，让它去push
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:pushVC animated:NO];
    } else if (indexPath.row == 5) {
        [self clearFile];
    }
    
    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 180;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = CGRectMake(CGRectGetWidth(view.frame)/2-25, 40, 50, 50);
    imageButton.layer.cornerRadius = 25;
    [imageButton setBackgroundImage:[UIImage imageNamed:@"icon_tabbar_mine_selected"] forState:UIControlStateNormal];
    [view addSubview:imageButton];
    [imageButton addTarget:self action:@selector(imgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageButton.frame)+5, tableView.bounds.size.width, 20)];
    
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    NSString *member_id=[user objectForKey:@"member_id"];
    NSLog(@" member_id %@ ",member_id);
    if ([member_id isKindOfClass:[NSNull class]] || (member_id == nil) || (member_id == NULL) || [member_id isEqualToString:@"NO"]) {
        
        nameLabel.text = @"未登录";
    } else {
        nameLabel.text = [user objectForKey:@"userName"];
    }
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:nameLabel];
    
    self.nameLabel = nameLabel;
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 180;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];

    UIButton * logOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30 , view.bounds.size.width - 40, 40)];
    
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    NSString *member_id=[user objectForKey:@"member_id"];
    NSLog(@" member_id %@ ",member_id);
     if ([member_id isKindOfClass:[NSNull class]] || (member_id == nil) || (member_id == NULL) || [member_id isEqualToString:@"NO"]) {
         
        [logOutBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    } else {
        [logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    }
    [logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logOutBtn.backgroundColor = INMUIColorWithRGB(0x4682B4, 1.0);
    [logOutBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview: logOutBtn];
    self.logOutBtn = logOutBtn;
    
    UILabel * versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.bounds.size.height - 20, view.bounds.size.width, 20)];
    versionLabel.text = [NSString stringWithFormat:@"V%@",APP_VERSION];
    versionLabel.font = [UIFont systemFontOfSize:15];
    versionLabel.textColor = [UIColor lightGrayColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview: versionLabel];
    
    return view;
}

- (void)imgButtonAction {
    NSLog(@"修改头像");
    
//    PushController *pushVC = [[PushController alloc] init];
//    pushVC.titleString = @"个人资料";
//
//    //拿到我们的LitterLCenterViewController，让它去push
//    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
//    [nav pushViewController:pushVC animated:NO];
//    //当我们push成功之后，关闭我们的抽屉
//    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
//        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
//        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
//    }];
}

- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long)fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

#pragma mark - 清理缓存

- (void) clearFile {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"%@", cachPath);
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        NSLog(@"files : %lu",(unsigned long)[files count]);
        
        for (NSString * p in files) {
            NSError *error;
            
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
    });
}

-(void)clearCacheSuccess{
    NSLog(@"清理成功");
    [SVProgressHUD showSuccessWithStatus:@"清理成功"];
    self.fileSize = 0;
    [self.tableview reloadData];
}

- (void) loginAction : (UIButton *)sender{
    
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    NSString *member_id=[user objectForKey:@"member_id"];
    NSLog(@" member_id %@ ",member_id);
    if ([member_id isKindOfClass:[NSNull class]] || (member_id == nil) || (member_id == NULL) || [member_id isEqualToString:@"NO"]) {
        [self jumpLoginVC];
    } else {
        NSUserDefaults *tokenUDF = [NSUserDefaults standardUserDefaults];
        [tokenUDF setValue:@"NO" forKey:@"member_id"];
        [tokenUDF setValue:@"" forKey:@"userName"];
        [tokenUDF synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"authResult" object:nil userInfo:@{@"isAuth":@"NO"}];

        [[NSUserDefaults standardUserDefaults] objectForKey:@"member_id"];
        [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    }
   
    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"loginOrOut"];
}


- (void) jumpLoginVC {
    LJX_LoginViewController *pushVC = [[LJX_LoginViewController alloc] init];
    //拿到我们的LitterLCenterViewController，让它去push
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    [nav pushViewController:pushVC animated:NO];
}

@end
