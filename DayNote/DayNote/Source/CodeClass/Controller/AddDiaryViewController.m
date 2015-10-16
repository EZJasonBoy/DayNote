//
//  AddDiaryViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "AddDiaryViewController.h"

@interface AddDiaryViewController ()

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
    self.writeDiary.backgroundColor = [UIColor greenColor];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY.MM.dd"];
    self.writeDiary.datelabel.text  = [dateFormat stringFromDate:date];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
