//
//  FileManagerTools.m
//  DayNote
//
//  Created by lanou3g on 15/10/20.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "FileManagerTools.h"

static FileManagerTools *tools = nil;
@implementation FileManagerTools

+ (instancetype)shareFileManager {
    if (tools == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tools = [[FileManagerTools alloc] init];
        });
    }
    return tools;
}
// 获取document目录
- (NSString *)getPathOfDocument {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return array[0];
}

- (NSString *)getImagePathWithName:(NSString *)aName {
    NSString *tempStr = [[[self getPathOfDocument] stringByAppendingPathComponent:@"diaryimage"] stringByAppendingPathComponent:aName];
    return tempStr;
}

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {

    // 创建文件夹
    NSString *pathStr = [NSString stringWithFormat:@"%@/diaryimage", [self getPathOfDocument]];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL exist = [manager fileExistsAtPath:imageName isDirectory:&isDir];
    
    if (!(isDir == YES && exist == YES)) {
        [manager createDirectoryAtPath:pathStr withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 保存图片
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    
    NSString *fullPathToFile = [pathStr stringByAppendingPathComponent:imageName];
    
    [imageData writeToFile:fullPathToFile atomically:NO];
    
}

@end
