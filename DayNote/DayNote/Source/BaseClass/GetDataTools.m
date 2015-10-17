//
//  GetDataTools.m
//  DayNote
//
//  Created by lanou3g on 15/10/16.
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
}

- (BOOL)addDiaryWithModel:(AllMyDiary *)diary {
    AllMyDiary *tempDiary = [NSEntityDescription insertNewObjectForEntityForName:@"AllMyDiary" inManagedObjectContext:self.context];
    tempDiary = diary;
    
    NSError *error;
    if (![self.context save:&error]) {
        return NO;
    }
    
    return YES;
}

- (BOOL)addDiaryWithModel:(NSDate *)contentDate create:(NSDate *)createDate details:(NSString *)diaryBody {
    AllMyDiary *tempDiary = [NSEntityDescription insertNewObjectForEntityForName:@"AllMyDiary" inManagedObjectContext:self.context];
    tempDiary.contentDate = contentDate;
    tempDiary.createDate = createDate;
    tempDiary.diaryBody = diaryBody;
    
    NSError *error;
    if (![self.context save:&error]) {
        return NO;
    }
    
    return YES;
}

- (NSArray *)selectAllData {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AllMyDiary" inManagedObjectContext:self.context];
    NSError *error;
    [request setEntity:entity];
    self.dataArray = [self.context executeFetchRequest:request error:&error];
    
    return self.dataArray;
}

- (NSArray *)descendingDataArray {
    NSMutableArray *tempArray;
    int b = (int)[self selectAllData].count-1;
    for (int i = 0; i < [self selectAllData].count; i++ ,b--) {
        tempArray[b] = self.dataArray[i];
    }
    
    return tempArray;
}


@end
