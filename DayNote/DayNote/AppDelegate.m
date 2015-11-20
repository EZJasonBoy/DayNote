//
//  AppDelegate.m
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "AppDelegate.h"
#import "iflyMSC/IFlySpeechUtility.h"

@interface AppDelegate () <UIActionSheetDelegate>
@property (nonatomic,strong)SetTableViewController *sv;
@property (nonatomic, strong) PopUpBoxViewController *pop;
@property (nonatomic,strong)NSUserDefaults *colorDefault;
@property (nonatomic,strong)NSArray *colorArr;
@property (nonatomic,strong)NSArray *colorIArr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [NSThread sleepForTimeInterval:3.0];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    MyDiaryTableViewController *myDiaryTVC = [[MyDiaryTableViewController alloc] initWithStyle:UITableViewStyleGrouped];

    CalendarViewController *calendarVC = [[CalendarViewController alloc] init];

    MoodViewController *moodVC = [[MoodViewController alloc] init];

    ShareTableViewController *shareVC = [[ShareTableViewController alloc] initWithStyle:UITableViewStylePlain];

    // 第三方tabbar
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
    YALTabBarItem *item3 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"statistics"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    
    YALTabBarItem *item4 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"zhuixingping"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    self.mainTBC.rightBarItems = @[item3, item4];
    
    self.mainTBC.centerButtonImage = [UIImage imageNamed:@"plus_icon"];
    
    self.mainTBC.selectedIndex = 0;
    
    // customize tabBarView
    self.mainTBC.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
    self.mainTBC.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
    self.mainTBC.tabBarView.backgroundColor = [UIColor flatBlueColor];
    self.mainTBC.tabBarView.tabBarColor = [UIColor colorWithRed:0.294 green:0.377 blue:0.597 alpha:1.000];
    self.mainTBC.tabBarViewHeight = YALTabBarViewDefaultHeight;
    self.mainTBC.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
    self.mainTBC.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
    
    
    self.window.rootViewController = nc;
    self.pop = [[PopUpBoxViewController alloc] init];
    
    self.colorIArr = @[colorI0,colorI1,colorI2,colorI3,colorI4,colorI5,colorI6];
    self.colorArr = @[color0,color1,color2,color3,color4,color5,color6];
    self.colorDefault = [NSUserDefaults standardUserDefaults];
    // 添加navigationbar
    
    [self.window addSubview:_pop.view];
    [self.window bringSubviewToFront:_pop.view];
    [self p_setNavigationBar];
    
    // leancloud
    [AVOSCloud setApplicationId:@"qY4QJscjHuPYu6MBom3XBY62"
                      clientKey:@"FWrcFjso6qUbqbiwerBRkn5l"];
//    [AVOSCloud setApplicationId:@"E7cnkG3jvtaopu6urja6Edqq" clientKey:@"E1sCWWCXzBkOLFNAXt6tputK"];
    // 讯飞
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"56250133"]; 
    [IFlySpeechUtility createUtility:initString];
    
    self.sv = [[SetTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_setColor) name:@"setColor" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNavigationTitle:) name:@"navigation" object:nil];
    
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    
    if (ability.currentReachabilityStatus == ReachableViaWiFi) {
        
        [ud setValue:@"WIFI" forKey:@"netStatus"];
    }else if (ability.currentReachabilityStatus == ReachableViaWWAN) {
        
        [ud setValue:@"WWAN" forKey:@"netStatus"];
    }else if (ability.currentReachabilityStatus == NotReachable){
        
        [ud setValue:@"NO NET" forKey:@"netStatus"];
    }
    [ability startNotifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStatusChanged:) name:kReachabilityChangedNotification object:ability];
    
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"status"] == nil) {
        NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
        NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
        self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
        [self.window addSubview:self.introductionView.view];
        
        __weak AppDelegate *weakSelf = self;
        self.introductionView.didSelectedEnter = ^() {
            [weakSelf.introductionView.view removeFromSuperview];
            weakSelf.introductionView = nil;
           
        };
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"status"];
    }
   
    [self p_color];
   
   
    
    return YES;
}
// 设置导航栏
- (void)p_setNavigationBar {
    
    [self.mainTBC.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forBarMetrics:UIBarMetricsDefault];
    
    self.mainTBC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(popupList:)];
    
    [self.mainTBC.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageFromColor:[UIColor clearColor]]];
}

// 点击事件
- (void)popupList:(UIBarButtonItem *)sender {
    // 延迟0.2秒执行(防止快速点击)
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(toDoSomething:) object:sender];
    [self performSelector:@selector(toDoSomething:) withObject:sender afterDelay:0.2f];
    
}

- (void)toDoSomething:(id)sender {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld", (unsigned long)[[GetDataTools shareGetDataTool] selectDataWithUserName:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]                  ].count],@"dayCount", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"day" object:nil userInfo:dict];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
         self.pop.view.transform = CGAffineTransformRotate(self.pop.view.transform, M_PI_2);
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"start" object:nil];
    }];

}

#pragma mark  记忆颜色
- (void)p_color
{
    if ([self.colorDefault objectForKey:@"color"]) {
        [self.mainTBC.navigationController.navigationBar setBackgroundImage:[self.colorIArr objectAtIndex:[[self.colorDefault valueForKey:@"color"] integerValue]] forBarMetrics:UIBarMetricsDefault];
        self.mainTBC.tabBarView.backgroundColor = [self.colorArr objectAtIndex:[[self.colorDefault valueForKey:@"color"] integerValue]];
        self.pop.view.backgroundColor = [self.colorArr objectAtIndex:[[self.colorDefault valueForKey:@"color"] integerValue]];
    }
}

- (void)p_setColor
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"简约兰 (默认)" otherButtonTitles:@"紫水晶",@"桃花木色",@"宝石红",@"玛瑙灰",@"律动红",@"沉默绿", nil];
    [sheet showInView:self.sv.view];
    
}

#pragma mark 皮肤设置
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
         [NSNumber numberWithInteger:buttonIndex];

        [self.mainTBC.navigationController.navigationBar setBackgroundImage:[self.colorIArr objectAtIndex:buttonIndex] forBarMetrics:UIBarMetricsDefault];

        [self.colorDefault setObject:[NSNumber numberWithInteger:buttonIndex] forKey:@"color"];
        self.mainTBC.tabBarView.backgroundColor = [self.colorArr objectAtIndex:buttonIndex];
        self.pop.view.backgroundColor = [self.colorArr objectAtIndex:buttonIndex];
    }
}

// 更改标题
- (void)changeNavigationTitle:(NSNotification *)sender {

    switch ([sender.userInfo[@"pageIndex"] integerValue]) {
        case 0:
            self.mainTBC.navigationItem.title = @"日记";
            break;
        case 1:
            self.mainTBC.navigationItem.title = @"回忆";
            break;
        case 2:
            self.mainTBC.navigationItem.title = @"心情";
            break;
        case 3:
            self.mainTBC.navigationItem.title = @"漂流记";
            break;
        default:
            break;
    }
}

- (void)netStatusChanged:(NSNotification *)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    Reachability *ability = [Reachability reachabilityForInternetConnection];
    
    
    if (ability.currentReachabilityStatus == ReachableViaWiFi) {
        [TSMessage showNotificationWithTitle:@"当前网络处于WIFI状态" type:TSMessageNotificationTypeMessage];
        [ud setValue:@"WIFI" forKey:@"netStatus"];
        
    }else if (ability.currentReachabilityStatus == ReachableViaWWAN) {
        [TSMessage showNotificationWithTitle:@"正在使用流量" subtitle:@"请不要在此期间同步数据" type:TSMessageNotificationTypeWarning];
        [ud setValue:@"WWAN" forKey:@"netStatus"];
    }else if (ability.currentReachabilityStatus == NotReachable){
        [TSMessage showNotificationWithTitle:@"网络不可用!!!" type:TSMessageNotificationTypeWarning];
        [ud setValue:@"NO NET" forKey:@"netStatus"];
    }
    
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
        _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
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
