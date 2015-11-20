//
//  UIImage+TransformColorAndImage.h
//  DayNote
//
//  Created by boluchuling on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TransformColorAndImage)

// 纯色图片
+ (UIImage *)imageFromColor:(UIColor *)color;

// 缩放图片
+ (UIImage *)imageWithImageSimple:(UIImage *)image scaleToSize:(CGSize)newSize;

@end
