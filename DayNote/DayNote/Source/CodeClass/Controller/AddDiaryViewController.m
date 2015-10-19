//
//  AddDiaryViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "AddDiaryViewController.h"

@interface AddDiaryViewController () <AddDiaryViewDelegate,UITextViewDelegate>

@property (nonatomic, strong) AddDiaryView *writeDiary;
@property (nonatomic, strong) NSDictionary *weatherDict;

@end

@implementation AddDiaryViewController

- (void)loadView {
    self.writeDiary = [[AddDiaryView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view = _writeDiary;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.writeDiary.backgroundColor = [UIColor whiteColor];
    
    self.writeDiary.editPage.delegate = self;
    
    [self.writeDiary.toolBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    self.writeDiary.delegate = self;
    
    
    [self setUI]; 
}

- (void)setUI {
    if (self.type == ADDTYPEInsert) {
        [self setNetInfo];
    }else {
        [self setLocalInfo];
    }
}

- (void)setNetInfo {
    
    [[RequestWeatherTools shareRequestWeather] getWeatherDetailsWithCity:@"beijing" Weather:^(NSDictionary *dict) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.weatherDict = dict;
            self.writeDiary.weatherShow.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dict[@"code"]]];
        });
    }];
    
    self.writeDiary.datelabel.text  = [[ConversionWithDate shareDateConversion] getStringWithDate:self.contentDate type:GZWDateFormatTypePoint];
    
    self.writeDiary.editPage.text = @"";
    
}

- (void)setLocalInfo {
    
    self.writeDiary.weatherShow.image = [UIImage imageNamed:self.weatherImage];
    self.writeDiary.datelabel.text = [[ConversionWithDate shareDateConversion] getStringWithDate:self.contentDate type:GZWDateFormatTypePoint];
    self.writeDiary.editPage.text = self.diaryText;
    
}


- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDismiss:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardAppear:(NSNotification *)notification {
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.writeDiary.toolBar.frame = CGRectMake(0, keyboardRect.origin.y-44, CGRectGetWidth(keyboardRect), 44); 
    }];
    
}
- (void)keyboardDismiss:(NSNotification *)notification {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.writeDiary.toolBar.frame = CGRectMake(0, CGRectGetMaxY(self.writeDiary.frame)-44, CGRectGetWidth(self.writeDiary.frame), 44); 
    }];
    
}

 

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.contentSize.height >= 300) {
        
        NSUInteger length = textView.text.length;
        textView.selectedRange = NSMakeRange(length-2, 0);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - addDiary delegate
- (void)backToView:(BOOL)isOK {
    
    if (isOK) {
        if (self.type == ADDTYPEAdditional) {
            [[GetDataTools shareGetDataTool] updateDataWithCreateDate:self.createDate ForDetails:self.writeDiary.editPage.text];
        }else {
            [[GetDataTools shareGetDataTool] addDiaryForContentDate:self.contentDate Create:[NSDate date] Details:self.writeDiary.editPage.text Weather:self.weatherDict[@"txt"] WeatherImage:self.weatherDict[@"code"]];
        }
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
