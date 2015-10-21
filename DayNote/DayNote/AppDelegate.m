//
//  AppDelegate.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) PopUpBoxViewController *pop;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    MyDiaryTableViewController *myDiaryTVC = [[MyDiaryTableViewController alloc] initWithStyle:UITableViewStyleGrouped];

    CalendarViewController *calendarVC = [[CalendarViewController alloc] init];

    MoodViewController *moodVC = [[MoodViewController alloc] init];

    ShareViewController *shareVC = [[ShareViewController alloc] init];

    
    self.mainTBC = [YALFoldingTabBarController shareFoldingTabBar];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.mainTBC];
    self.mainTBC.viewControllers = @[myDiaryTVC, calendarVC, moodVC, shareVC];

    //prepare leftBarItems
    YALTabBarItem *item1 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"diary"]
                                                      leftItemImage:[UIImage imageNamed:@"search_icon"]
                                                     rightItemImage:[UIImage imageNamed:@"edit_icon"]];
    
    
    YALTabBarItem *item2 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"Calendar"]
                                                      leftItemImage:nil
                                                     rightItemImage:[UIImage imageNamed:@"edit_icon"]];
    
    self.mainTBC.leftBarItems = @[item1, item2];
    
    //prepare rightBarItems
    YALTabBarItem *item3 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"chats_icon"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    
    YALTabBarItem *item4 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@""]
                                                      leftItemImage:[UIImage imageNamed:@"search_icon"]
                                                     rightItemImage:[UIImage imageNamed:@"new_chat_icon"]];
    
    self.mainTBC.rightBarItems = @[item3, item4];
    
    self.mainTBC.centerButtonImage = [UIImage imageNamed:@"plus_icon"];
    
    self.mainTBC.selectedIndex = 0;
    
    //customize tabBarView
    self.mainTBC.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
    self.mainTBC.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
    self.mainTBC.tabBarView.backgroundColor = [UIColor flatBlueColor];
    self.mainTBC.tabBarView.tabBarColor = [UIColor flatBlueColorDark];
    self.mainTBC.tabBarViewHeight = YALTabBarViewDefaultHeight;
    self.mainTBC.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
    self.mainTBC.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
        
    
    [AVOSCloud setApplicationId:@"J9wH2THYLIMQTO5CEtOnEWpj"
                      clientKey:@"yrkBJhd1KKlKCPrbFh8q2cIu"];
    
    self.window.rootViewController = nc;
    self.pop = [[PopUpBoxViewController alloc] init];
    
    [self p_setNavigationBar];
    
    [self.window addSubview:_pop.view];[self.window bringSubviewToFront:_pop.view];
    return YES;
}
// 设置导航栏
- (void)p_setNavigationBar {
    
    self.mainTBC.navigationItem.title = @"my diary";
    [self.mainTBC.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forBarMetrics:UIBarMetricsDefault];
    
    self.mainTBC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(popupList:)];
    [self.mainTBC.navigationItem.leftBarButtonItem setTintColor:[UIColor grayColor]];
    
    [self.mainTBC.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageFromColor:[UIColor clearColor]]];
}

- (void)popupList:(UIBarButtonItem *)sender {
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(toDoSomething:) object:sender];
    [self performSelector:@selector(toDoSomething:) withObject:sender afterDelay:0.2f];
    }

- (void)toDoSomething:(id)sender {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
         self.pop.view.transform = CGAffineTransformRotate(self.pop.view.transform, M_PI_2);
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"start" object:nil];
    }];

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
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES};
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
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
