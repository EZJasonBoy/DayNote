//
//  AppDelegate.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    
    MyDiaryTableViewController *myDiaryTVC = [[MyDiaryTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *myDiaryNC = [[UINavigationController alloc] initWithRootViewController:myDiaryTVC];
    CalendarViewController *calendarVC = [[CalendarViewController alloc] init];
    UINavigationController *calendarNC = [[UINavigationController alloc] initWithRootViewController:calendarVC];
    MoodViewController *moodVC = [[MoodViewController alloc] init];
    UINavigationController *moodNC = [[UINavigationController alloc] initWithRootViewController:moodVC];
    ShareViewController *shareVC = [[ShareViewController alloc] init];
    UINavigationController *shareNC = [[UINavigationController alloc] initWithRootViewController:shareVC];
    
    
    
    UITabBarController *mainTBC = [[UITabBarController alloc] init];
    [mainTBC.tabBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatMintColor]]];
    mainTBC.viewControllers = @[myDiaryNC, calendarNC, moodNC, shareNC];
    
    myDiaryNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的日记" image:nil tag:1];
    calendarNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"回忆" image:nil tag:2];
    moodNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"心情" image:nil tag:3];
    shareNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分享" image:nil tag:4];
    
    
    UIButton *addDiary = [UIButton buttonWithType:UIButtonTypeCustom];
    [addDiary setBackgroundColor:[UIColor colorWithWhite:0.253 alpha:1.000]];
    [addDiary setFrame:CGRectMake(172, -23, 46, 46)];
    [addDiary.layer setCornerRadius:23];
    [addDiary setClipsToBounds:YES];
    [addDiary setBackgroundImage:[UIImage imageNamed:@"/Users/lanou3g/Desktop/13133775(小).png"] forState:UIControlStateNormal];
    [addDiary addTarget:self action:@selector(addMyDiary:) forControlEvents:UIControlEventTouchUpInside];
    [mainTBC.tabBar addSubview:addDiary];

    self.window.rootViewController = mainTBC;
    
    return YES;
}

- (void)addMyDiary:(UIButton *)sender {
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
