//
//  DiaryDetailsViewController.m
//  DayNote
//
//  Created by youyou on 15/10/19.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "DiaryDetailsViewController.h"

@interface DiaryDetailsViewController () <DiaryDetailsViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) DiaryDetailsView *diaryDetails;
@property (nonatomic, strong) DayNote *myDiary;

@property (nonatomic, strong) JTMaterialTransition *transition;

@property (nonatomic,strong) UIAlertView *alert;

@property (nonatomic, assign) NSInteger myTag;
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
    self.myDiary = [[GetDataTools shareGetDataTool] selectDataWithDate:self.diaryData.contentDate];
    _myTag = 0;
    [self setData];
}
// 设置页面信息
- (void)setData {
    self.diaryDetails.backScrollView.scrollEnabled = YES;
    self.diaryDetails.backScrollView.showsVerticalScrollIndicator = NO;
    
    self.navigationItem.title = [[ConversionWithDate shareDateConversion] getStringWithDate:_myDiary.contentDate type:GZWDateFormatTypeWord];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"/Users/lanou3g/Downloads/Left_Arrow_31.015384615385px_1190911_easyicon.net.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backToMain:)];
    self.diaryDetails.weatherImage.image = [UIImage imageNamed:self.myDiary.weatherImage];
    
    self.diaryDetails.moodImage.image = [UIImage imageNamed:_myDiary.mood];
    
    self.diaryDetails.textLabel.text = _myDiary.diaryBody;
    [self.diaryDetails.textLabel sizeToFit];
    
    self.diaryDetails.myImage.image = [UIImage imageNamed:[[FileManagerTools shareFileManager] getImagePathWithName:_myDiary.diaryImage]];
    
    self.diaryDetails.backScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(self.diaryDetails.myImage.frame)+80);
    [self.diaryDetails addSubview:self.diaryDetails.editButton];
    self.diaryDetails.editButton.backgroundColor = [UIColor flatBlueColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(shareAction:)];
}

-(void)shareAction:(UIBarButtonItem *)sender
{
    if (_myTag == 1) {
        self.alert = [[UIAlertView alloc] initWithTitle:@"日记已分享" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [self.alert show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.alert dismissWithClickedButtonIndex:0 animated:YES];
        });
        return;
    }
    [[LocationTools shareLocation] initializePositioning];
    CLLocationCoordinate2D cll = [[DriftComputingTools shareDriftComputing] calculateEstimatedPosition];
    [[LocationTools shareLocation] getCityNameWithCoordinate:cll city:^(NSString *cityName) {
        [self requestSuccess:cityName];
    }];
    _myTag = 1;
}

- (void)requestSuccess:(NSString *)sender {

    NSString *str1 = sender;
    NSString *str2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"local"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:_myDiary.contentDate,@"contentDate", _myDiary.weather,@"weather", _myDiary.mood,@"mood", _myDiary.diaryBody,@"diaryBody", [NSDate date],@"shareDate",nil];
    if (str1 == nil) {
        str1 = @"未知";
    }
    if (str2 == nil) {
        str2 = @"未知";
    } 
    [dict setObject:str1 forKey:@"targetLocation"];
    [dict setObject:str2 forKey:@"localLocation"];
    AVObject *post = [AVObject objectWithClassName:@"DriftBottle"];
    for (NSString *key in dict) {
        [post setObject:dict[key] forKey:key];
    }
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            if (str1 == nil) {
                self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的日记飘向了未知之地..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [self.alert show];
            }else {
                NSString *temp = [NSString stringWithFormat:@"您的日记预计将要飘向%@", str1];
                self.alert = [[UIAlertView alloc]initWithTitle:temp message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [self.alert show];
            }
            
        }
        else
        {
            self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不给力,分享失败了!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [self.alert show];
        }
//        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlertView:) userInfo:nil repeats:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.alert dismissWithClickedButtonIndex:0 animated:YES];
        });

    }];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pass" object:nil];
}

//- (void)dismissAlertView:(NSTimer*)timer {
//    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
//}
// 返回上一页面
- (void)backToMain:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
// 编辑日记
- (void)writeDiary {
    AddDiaryViewController *add = [[AddDiaryViewController alloc] init];
    add.type = ADDTYPEAdditional;
    add.contentDate = self.diaryData.contentDate;
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
