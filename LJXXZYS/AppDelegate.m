//
//  AppDelegate.m
//  LJXXZYS
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "AppDelegate.h"
#import "APPRootViewController.h"
#import "MMDrawerController.h"
#import "LeftController.h"
//#import "CenterController.h"
#import "MMDrawerVisualState.h"

#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate ()

@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    LeftController *leftVC = [[LeftController alloc] init];
    
    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:[[APPRootViewController alloc] init]];
    centerNav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    centerNav.navigationBar.tintColor = [UIColor whiteColor];
    centerNav.navigationBar.barTintColor = [UIColor colorWithRed:44/255.0 green:185/255.0 blue:176/255.0 alpha:1];
    
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:centerNav leftDrawerViewController:leftVC];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setMaximumLeftDrawerWidth:INMScreenW-150];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
                 drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block){
            block(drawerController, drawerSide, percentVisible);
        }
        
    }];//侧滑效果
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:self.drawerController];
    
    [self.window makeKeyAndVisible];
    
    [self loginDeveloperOpenApi];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) developerOpenApiRegist {
    
    NSDictionary * dict = @{
                            @"name" : @"XZ_000000",
                            @"passwd" : @"123456",
                            @"email" : @"15652550778@163.com"
                            };
    NSLog(@"dict = %@",dict);
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:@"https://api.apiopen.top/developerRegister" params:dict successBlock:^(id obj) {
        NSLog(@"obj = %@",obj);
        
        NSUserDefaults *tokenUDF = [NSUserDefaults standardUserDefaults];
        [tokenUDF setValue:obj[@"result"][@"apikey"] forKey:@"apikey"];
        [tokenUDF synchronize];
    } failureBlock:^(NSError *error) {
          NSLog(@"error = %@",error);
    }];
}

- (void) loginDeveloperOpenApi{
    NSDictionary * dict = @{
                            @"name" : @"XZ_000000",
                            @"passwd" : @"123456",
                            };

    [LJXRequestTool LJX_requestWithType:LJX_GET URL:@"https://api.apiopen.top/developerLogin" params:dict successBlock:^(id obj) {
        NSUserDefaults *tokenUDF = [NSUserDefaults standardUserDefaults];
        [tokenUDF setValue:obj[@"result"][@"apikey"] forKey:@"apikey"];
        [tokenUDF synchronize];
        
        NSLog(@"loginObj = %@",obj);
        
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

@end
