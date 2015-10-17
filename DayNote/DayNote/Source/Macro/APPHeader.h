//
//  APPHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h

#define Project_APPHeader_h

//
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

// base
#import "ConversionWithDate.h"
#import "GetDataTools.h"

// code
#import "RootTabBarViewController.h"
#import "CalendarViewController.h"
#import "MyDiaryTableViewController.h"
#import "MoodViewController.h"
#import "ShareViewController.h"
#import "AddDiaryViewController.h"
#import "PopUpBoxViewController.h"

// model
#import "AllMyDiary.h"

// View
#import "DiaryListTableViewCell.h"
#import "PopUpBoxView.h"
#import "AddDiaryView.h"

// net



// helper
#import "UIImage+TransformColorAndImage.h"

#define kScreenWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
#define kScrollViewWidth kScreenWidth
#define kScrollViewHeight kScrollViewWidth











































//TODO 提示
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))


#endif
