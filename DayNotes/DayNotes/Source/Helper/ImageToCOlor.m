//
//  ImageToCOlor.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "ImageToCOlor.h"

@implementation ImageToCOlor

// 颜色转图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
