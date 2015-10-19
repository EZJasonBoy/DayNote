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
    
    UIViewController *placeholder = [[UIViewController alloc] init];
    
    
    UITabBarController *mainTBC = [[UITabBarController alloc] init];
    [mainTBC.tabBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]]];
    [mainTBC.tabBar setShadowImage:[UIImage imageFromColor:[UIColor clearColor]]];
    mainTBC.viewControllers = @[myDiaryNC, calendarNC, placeholder,moodNC, shareNC];
    mainTBC.tabBar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    myDiaryNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的日记" image:nil tag:1];
    calendarNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"回忆" image:nil tag:2];
    moodNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"心情" image:nil tag:3];
    shareNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分享" image:nil tag:4];
    
    placeholder.tabBarItem.enabled = NO;
    
    
    
    FUIButton *addDiary = [FUIButton buttonWithType:UIButtonTypeCustom];
    
    [addDiary setFrame:CGRectMake(172, -10, 46, 46)];
    CGPoint center = addDiary.center;
    center.x = self.window.center.x;
    addDiary.center = center;
    [addDiary setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColorDark]] forState:UIControlStateNormal];
    [addDiary setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forState:UIControlStateHighlighted];
    [addDiary.layer setCornerRadius:23];
    [addDiary setClipsToBounds:YES];
    addDiary.userInteractionEnabled = YES;
    [addDiary setImage:[UIImage imageNamed:@"13133775(小)"] forState:UIControlStateNormal];
    [addDiary setImage:[UIImage imageNamed:@"13133775(小)"] forState:UIControlStateHighlighted];
    [addDiary addTarget:self action:@selector(addMyDiary:) forControlEvents:UIControlEventTouchUpInside];
    [mainTBC.tabBar addSubview:addDiary];
    
    
    [AVOSCloud setApplicationId:@"J9wH2THYLIMQTO5CEtOnEWpj"
                      clientKey:@"yrkBJhd1KKlKCPrbFh8q2cIu"];
    
    self.window.rootViewController = mainTBC;
    
    return YES;
}

- (void)addMyDiary:(UIButton *)sender {
    AddDiaryViewController *addDiary = [[AddDiaryViewController alloc] init];
    addDiary.contentDate = [NSDate date];
    addDiary.type = ADDTYPEInsert;
    [self.window.rootViewController presentViewController:addDiary animated:YES completion:nil];
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

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && [managedObjectContext save:&error]) {
            NSLog(@"Unresolvederror:%@,%@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext !=nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc]init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application'smodel.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel !=nil) {
        return _managedObjectModel;
    }
    //这里一定要注意，这里的iWeather就是你刚才建立的数据模型的名字，一定要一致。否则会报错。
    NSURL *modelURL = [[NSBundle mainBundle]URLForResource:@"DayNote"withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and theapplication's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator !=nil) {
        return _persistentStoreCoordinator;
    }
    //这里的iWeaher.sqlite，也应该与数据模型的名字保持一致。
    NSURL *storeURL = [[self applicationDocumentsDirectory]URLByAppendingPathComponent:@"DayNote.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolvederror %@, %@", error, [error userInfo]);
        abort();
    }   
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL*)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}

@end
