//
//  DiaryDetailsViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/19.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "DiaryDetailsViewController.h"

@interface DiaryDetailsViewController () <DiaryDetailsViewDelegate>
@property (nonatomic, strong) DiaryDetailsView *diaryDetails;
@property (nonatomic, strong) DayNote *myDiary;
@end

@implementation DiaryDetailsViewController

- (void)loadView {
    self.diaryDetails = [[DiaryDetailsView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    self.view = _diaryDetails;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.diaryDetails.delegate = self;
    self.diaryDetails.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    self.myDiary = (DayNote *)[[GetDataTools shareGetDataTool] selectDataWithIndex:self.diaryIndex][0];
    [self setData];
}

- (void)setData {
    self.navigationItem.title = [[ConversionWithDate shareDateConversion] getStringWithDate:_myDiary.contentDate type:GZWDateFormatTypeWord];
    
    self.diaryDetails.weatherImage.image = [UIImage imageNamed:self.myDiary.weatherImage];
    
    self.diaryDetails.moodImage.image = nil;
    
    
    self.diaryDetails.textLabel.text = _myDiary.diaryBody;
    [self.diaryDetails.textLabel sizeToFit];
    
    self.diaryDetails.myImage.image = nil;
    
    self.diaryDetails.editButton.backgroundColor = [UIColor flatBlueColor];
}

- (void)writeDiary {
    AddDiaryViewController *add = [[AddDiaryViewController alloc] init];
    add.type = ADDTYPEAdditional;
    add.hidesBottomBarWhenPushed = YES;
    add.diaryText = self.myDiary.diaryBody;
    add.contentDate = self.myDiary.contentDate;
    add.createDate = self.myDiary.createDate;
    add.mood = nil;
    add.weatherImage = self.myDiary.weatherImage;
    [self presentViewController:add animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
