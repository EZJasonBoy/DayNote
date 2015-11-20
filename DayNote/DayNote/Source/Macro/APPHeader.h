//
//  APPHeader.h
//  ProjectMusic
//
//  Created by boluchuling on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h

#define Project_APPHeader_h

//
#import <AVFoundation/AVAudioSession.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"

// base
#import "ConversionWithDate.h"
#import "GetDataTools.h"
#import "RequestWeatherTools.h"
#import "FileManagerTools.h"
#import "LocationTools.h"
#import "DriftComputingTools.h"


// code

#import "MyDiaryTableViewController.h"// 1
#import "CalendarViewController.h"// 2
#import "MoodViewController.h"// 3
#import "ShareTableViewController.h" // 4
#import "AddDiaryViewController.h" // 1.1
#import "PopUpBoxViewController.h" // 1.2
#import "DiaryDetailsViewController.h" // 1.3
#import "SignInViewController.h"// 登录
#import "SetTableViewController.h"// 设置
#import "RestPwdViewController.h" // 注册
#import "CNPPopupController.h" // 关于
#import "UserInfoViewController.h"
#import "RegisterViewController.h"
#import "DetailsMoodTableViewController.h"
#import "ServiceViewController.h"

// model
#import "DayNote.h"

// View
#import "DiaryListTableViewCell.h"
#import "PopUpBoxView.h"
#import "AddDiaryView.h"
#import "DiaryDetailsView.h"
#import "MoodView.h"
#import "SXWaveCell.h"
#import "SignView.h"
#import "SetTableViewCell.h"
#import "CalendarView.h"
#import "RestPwdView.h"
#import "UserInfoView.h"
#import "RegisterView.h"


#import "CNPPopupTheme.h"



// helper
#import "UIImage+TransformColorAndImage.h"
#import "UIView+Additions.h"
#import "NSString+ChineseIntoCharacters.h"

#define kScreenWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
#define kScrollViewWidth kScreenWidth
#define kScrollViewHeight kScrollViewWidth




// 颜色

#define colorI0 [UIImage imageFromColor:[UIColor flatBlueColor]] //                                                      简约兰

#define colorI1 [UIImage imageFromColor:[UIColor colorWithRed:0.389 green:0.233 blue:0.475 alpha:1.000]]   //   紫水晶

#define colorI2 [UIImage imageFromColor:[UIColor colorWithRed:0.319 green:0.230 blue:0.188 alpha:1]]    //  桃花木色

#define colorI3 [UIImage imageFromColor:[UIColor colorWithRed:91/256.0 green:19/256.0 blue:25/256.0 alpha:1]]    //   宝石红

#define colorI4 [UIImage imageFromColor:[UIColor colorWithRed:39/256.0 green:40/256.0 blue:42/256.0 alpha:1]]     //   玛瑙灰

#define colorI5 [UIImage imageFromColor:[UIColor colorWithRed:147/256.0 green:27/256.0 blue:48/256.0 alpha:1]]   //   律动红

#define colorI6 [UIImage imageFromColor:[UIColor colorWithRed:47/256.0 green:79/256.0 blue:79/256.0 alpha:1]]   //  沉默绿


#define color0 [UIColor flatBlueColor] //                                                      简约兰

#define color1 [UIColor colorWithRed:0.389 green:0.233 blue:0.475 alpha:1]  //   紫水晶

#define color2 [UIColor colorWithRed:0.319 green:0.230 blue:0.188 alpha:1.000]    //  桃花木色

#define color3 [UIColor colorWithRed:91/256.0 green:19/256.0 blue:25/256.0 alpha:1]    //   宝石红

#define color4 [UIColor colorWithRed:39/256.0 green:40/256.0 blue:42/256.0 alpha:1]     //   玛瑙灰

#define color5 [UIColor colorWithRed:147/256.0 green:27/256.0 blue:48/256.0 alpha:1]   //   律动红 

#define color6 [UIColor colorWithRed:47/256.0 green:79/256.0 blue:79/256.0 alpha:1]  //  沉默绿


#define colorCG [UIColor colorWithRed:240/256.0 green:246/256.0 blue:244/256.0 alpha:1]

































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
