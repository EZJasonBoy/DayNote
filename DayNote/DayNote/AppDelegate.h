//
//  AppDelegate.h
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWIntroductionViewController.h"

@class YALFoldingTabBarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) YALFoldingTabBarController *mainTBC;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) ZWIntroductionViewController *introductionView;
- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

@end

