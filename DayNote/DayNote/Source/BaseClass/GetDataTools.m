//
//  GetDataTools.m
//  DayNote
//
//  Created by boluchuling on 15/10/16.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "GetDataTools.h"

@interface GetDataTools ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSArray *dataArray;

@end

static GetDataTools *tools = nil;
@implementation GetDataTools

+ (instancetype)shareGetDataTool {
    if (tools == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tools = [[GetDataTools alloc] init];
            [tools initSet];
        });
    }
    return tools;
}

- (void)initSet {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = delegate.managedObjectContext;
    self.dataArray = [NSArray array];
}

// 添加数据
- (BOOL)addDiaryForContentDate:(NSDate *)contentDate Create:(NSDate *)createDate Details:(NSString *)diaryBody Weather:(NSString *)weather WeatherImage:(NSString *)weatherImage Mood:(NSString *)mood   MoodImage:(NSInteger)moodImage DiaryImage:(NSString *)diaryImage userName:(NSString *)aName {
    
    DayNote *tempDiary = [NSEntityDescription insertNewObjectForEntityForName:@"DayNote" inManagedObjectContext:self.context];
    tempDiary.contentDate = contentDate;
    tempDiary.createDate = createDate;
    tempDiary.diaryBody = diaryBody;
    tempDiary.mood = mood;
    tempDiary.moodImage = [NSString stringWithFormat:@"%ld", (long)moodImage];       
    tempDiary.weather = weather;
    tempDiary.weatherImage = weatherImage;
    tempDiary.diaryImage = diaryImage;
    tempDiary.userName = aName;
    NSError *error;
    if (![self.context save:&error]) {
        return NO;
    }
    
    return YES;
}
// 查询所有数据
- (NSArray *)selectAllData {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DayNote" inManagedObjectContext:self.context];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    
    return array;
}
// 倒序排序
- (NSArray *)descendingDataArray {
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSArray *arr = [self selectAllData];
    for (int i = (int)arr.count-1; i >= 0; i--) {
        [tempArray addObject:arr[i]];
    }
    if (0 != tempArray.count) {
        // 按时间先后排序
    for (int i = 0; i < tempArray.count - 1;i++) {
        
        for (int j = 0; j < tempArray.count- 1 - i;j++) {
            DayNote *obj1 = tempArray[j];
            DayNote *obj2 = tempArray[j+1];
            NSComparisonResult result = [obj1.contentDate compare:obj2.contentDate];
            if (result == NSOrderedAscending) {
                DayNote *temp;
                temp = tempArray[j];
                tempArray[j] = tempArray[j+1];
                tempArray[j+1] = temp;

            }
        }
    }            
    }
    
    self.dataArray = tempArray;
    return tempArray;
}
// 按索引查询数据(从数组中)
- (NSArray *)selectDataWithIndex:(NSInteger)index {
    NSArray *array =[NSArray arrayWithObjects:(DayNote *)[self descendingDataArray][index], nil];
    return array;
}

// 根据时间查询数据
- (DayNote *)selectDataWithDate:(NSDate *)aDate {
    
    for (DayNote *dict in self.dataArray) {
        
        NSString *str = [[ConversionWithDate shareDateConversion] getStringWithDate:dict.contentDate type:GZWDateFormatTypeConnector];
        
        NSString *str2 = [[ConversionWithDate shareDateConversion] getStringWithDate:aDate type:GZWDateFormatTypeConnector];
        
        
        if ([str isEqualToString:str2]) {
            return dict;
        }
    }
    
    
    return nil;
}

// 根据心情查询数据个数
- (CGFloat)selectDataCountWithMood:(NSString *)aMood {
    CGFloat i = 0;
    for (DayNote *dict in self.dataArray) {
        if ([dict.mood isEqualToString:aMood]) {
            i++;
        }
    }
    return i;
}

- (NSArray *)selectDataWithMood:(NSString *)aMood {
    NSMutableArray *arr = [NSMutableArray array];
    for (DayNote *dict in self.dataArray) {
        if ([dict.mood isEqualToString:aMood]) {
            [arr addObject:dict];
        }
    }
    
    return arr;
}

// 按用户名查询数据
- (NSArray *)selectDataWithUserName:(NSString *)aName {
    NSMutableArray *arr = [NSMutableArray array];
    for (DayNote *dict in self.dataArray) {
       
        if ([dict.userName isEqualToString:aName] || dict.userName == nil) {
            [arr addObject:dict];
        }
    }
    self.dataArray = arr;
    return arr;
}


// 删除数据(根据时间)
- (BOOL)deleteDataWithDate:(NSDate *)aDate {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DayNote"];
    request.predicate = [NSPredicate predicateWithFormat:@"createDate = %@", aDate];
    NSError *error;
    NSArray *tempArray = [self.context executeFetchRequest:request error:&error];
    if (!error && [tempArray count]) {
        for (NSManagedObject *obj in tempArray) {
            [self.context deleteObject:obj];
        }
    }

    
    if (![self.context save:&error]) {
        return YES;
    }else {
        return NO;
    }
}

// 删除数据(根据姓名)
- (BOOL)deleteDataWithUserName:(NSString *)aName {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DayNote"];
    request.predicate = [NSPredicate predicateWithFormat:@"userName = %@", aName];
    NSError *error;
    NSArray *tempArray = [self.context executeFetchRequest:request error:&error];
    if (!error && [tempArray count]) {
        for (NSManagedObject *obj in tempArray) {
            [self.context deleteObject:obj];
        }
    }
    
    if (![self.context save:&error]) {
        return YES;
    }else {
        return NO;
    }
}


// 更新core data数据库(部分)
- (BOOL)updateDataWithCreateDate:(NSDate *)aDate ForDetails:(NSString *)diaryBody ForImage:(NSString *)diaryImage{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DayNote"];
    request.predicate = [NSPredicate predicateWithFormat:@"createDate = %@", aDate];
    
    NSError *error;
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    for (DayNote *data in array) {
        data.diaryBody = diaryBody;
        if (diaryImage != nil) {
            data.diaryImage = diaryImage;
        }
    }
    
    if (![self.context save:&error]) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)updateALLDataUserNameWithDict:(NSDictionary *)aDict {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DayNote"];
    NSError *error;
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    for (DayNote *data in array) {
        if (data.userName == nil) {
            data.userName = aDict[@"userName"];
        }
    }
    
    if (![self.context save:&error]) {
        return NO;
    }else {
        return YES;
    }
}

@end
