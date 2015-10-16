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
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY.MM.dd"];
    self.writeDiary.datelabel.text  = [dateFormat stringFromDate:date];
    
    self.writeDiary.editPage.backgroundColor = [UIColor flatWhiteColor];
    self.writeDiary.editPage.textContainer.lineBreakMode = NSLineBreakByClipping;
    self.writeDiary.editPage.text = @"这是一个测试文本.- (void)applicationWillTerminate:(UIApplication *)application; //当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application;// try to clean up as much memory as possible. next step is to terminate app//内存较低时调用";
    self.writeDiary.editPage.font = [UIFont fontWithName:@"Menlo" size:14];
    self.writeDiary.editPage.delegate = self;
    [self.writeDiary.toolBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatMintColor]] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    self.writeDiary.delegate = self;
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
        NSLog(@"%@", self.writeDiary.editPage.text);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
