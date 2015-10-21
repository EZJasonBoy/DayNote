//
//  DiaryDetailsViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/19.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "DiaryDetailsViewController.h"

@interface DiaryDetailsViewController () <DiaryDetailsViewDelegate, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) DiaryDetailsView *diaryDetails;
@property (nonatomic, strong) DayNote *myDiary;

@property (nonatomic, strong) JTMaterialTransition *transition;

@end

@implementation DiaryDetailsViewController

- (void)loadView {
    self.diaryDetails = [[DiaryDetailsView alloc] initWithFrame:CGRectMake(0, 0, 375, 603)];
    self.view = _diaryDetails;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.diaryDetails.delegate = self;
    self.diaryDetails.backgroundColor = [UIColor whiteColor];
    [self createTransition];
}

- (void)viewWillAppear:(BOOL)animated {
    self.myDiary = (DayNote *)[[GetDataTools shareGetDataTool] selectDataWithIndex:self.diaryIndex][0];
    [self setData];
}

- (void)setData {
    self.diaryDetails.backScrollView.scrollEnabled = YES;
    self.diaryDetails.backScrollView.showsVerticalScrollIndicator = NO;
    
    self.navigationItem.title = [[ConversionWithDate shareDateConversion] getStringWithDate:_myDiary.contentDate type:GZWDateFormatTypeWord];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"/Users/lanou3g/Downloads/arrow_18.666666666667px_1167923_easyicon.net.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backToMain:)];
    self.diaryDetails.weatherImage.image = [UIImage imageNamed:self.myDiary.weatherImage];
    
    self.diaryDetails.moodImage.image = [UIImage imageNamed:_myDiary.mood];
    
    self.diaryDetails.textLabel.text = _myDiary.diaryBody;
    [self.diaryDetails.textLabel sizeToFit];
    
    self.diaryDetails.myImage.image = [UIImage imageNamed:[[FileManagerTools shareFileManager] getImagePathWithName:_myDiary.diaryImage]];
    
    self.diaryDetails.backScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(self.diaryDetails.myImage.frame)+80);
    [self.diaryDetails addSubview:self.diaryDetails.editButton];
    self.diaryDetails.editButton.backgroundColor = [UIColor flatBlueColor];
}

- (void)backToMain:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)writeDiary {
    AddDiaryViewController *add = [[AddDiaryViewController alloc] init];
    add.type = ADDTYPEAdditional;
    add.index = self.diaryIndex;
    add.modalPresentationStyle = UIModalPresentationCustom;
    add.transitioningDelegate = self;
    [self presentViewController:add animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Transition

- (void)createTransition
{
    self.transition = [[JTMaterialTransition alloc] initWithAnimatedView:self.diaryDetails.editButton];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.transition.reverse = NO;
    return self.transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.transition.reverse = YES;
    return self.transition;
}

@end
