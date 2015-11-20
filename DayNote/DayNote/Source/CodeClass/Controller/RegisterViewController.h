//
//  RegisterViewController.h
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 张晓敏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UserInfo)(NSDictionary *dict);
@interface RegisterViewController : UIViewController

@property (nonatomic, copy) UserInfo userInfo;

@end
