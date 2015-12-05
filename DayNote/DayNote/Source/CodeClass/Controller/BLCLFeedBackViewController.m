//
//  BLCLFeedBackViewController.m
//  DayNote
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 郭兆伟. All rights reserved.
//

#import "BLCLFeedBackViewController.h"

@interface BLCLFeedBackViewController ()

@property (nonatomic, strong) UILabel *feedLabel;
@property (nonatomic, strong) UITextView *feedTextView;

@end

@implementation BLCLFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationbar];
    [self setTextView];
}

- (void)setTextView {
    self.feedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 30)];
    self.feedLabel.textAlignment = NSTextAlignmentCenter;
    [self.feedLabel setFont:[UIFont fontWithName:@"Menlo" size:12]];
    self.feedLabel.textColor = [UIColor grayColor];
    self.feedLabel.text = @"反馈邮箱:baoluchuling@126.com";
    [self.view addSubview:_feedLabel];
    
    self.feedTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2)];
    self.feedTextView.editable = YES;
    self.feedTextView.scrollEnabled = YES;
    self.feedTextView.keyboardType = UIKeyboardAppearanceDefault;
    self.feedTextView.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_feedTextView];
}

- (void)setNavigationbar {
    self.navigationItem.title = @"反馈";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(sendFeed:)];
}

- (void)sendFeed:(UIBarButtonItem *)sender {
    AVObject *feed = [AVObject objectWithClassName:@"Feed"];
    [feed setObject:self.feedTextView.text forKey:@"FeedBack"];
    [feed saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded == YES) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"反馈成功!" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            });
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"反馈成功!" message:@"网络故障" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:^{
                }];
            });
        }
    }];
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
