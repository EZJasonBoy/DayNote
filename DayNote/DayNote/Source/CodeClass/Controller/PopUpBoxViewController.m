//
//  MyNavigationViewController.m
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "PopUpBoxViewController.h"

@interface PopUpBoxViewController () <PopUpBoxViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) PopUpBoxView *popUpBox;

@end

@implementation PopUpBoxViewController

- (void)loadView {
    self.popUpBox = [[PopUpBoxView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*-187.5/375, [UIScreen mainScreen].bounds.size.height*-333/667, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.popUpBox.layer.anchorPoint = CGPointZero;
    self.popUpBox.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    self.view = _popUpBox;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.popUpBox.delegate = self;
    self.popUpBox.backgroundColor = [UIColor flatBlueColor];
    self.popUpBox.layer.cornerRadius = 2;
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:@"userName"] != nil) {
        [self.popUpBox.signIn setTitle:[userDefault objectForKey:@"userName"] forState:UIControlStateNormal];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changetitle:) name:@"cancel" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue:) name:@"day" object:nil];
}

- (void)changeValue:(NSNotification *)sender {
    
    self.popUpBox.dayCount.text = sender.userInfo[@"dayCount"];
    
}

- (void)signIn {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"netStatus"] isEqualToString:@"NO NET"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络连接不可用" message:@"请检查网络配置" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return;
    }
    if ([self.popUpBox.signIn.titleLabel.text isEqualToString:@"登录"]) {
        // 跳转到登陆界面
        SignInViewController *signInTVC = [[SignInViewController alloc] init];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:signInTVC];
        
        [self presentViewController:nc animated:YES completion:nil];
    }
}

- (void)intoUserCenter {
    // 跳转到个人中心
    UserInfoViewController *userInfoTVC = [[UserInfoViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:userInfoTVC];
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)intoSetting {
    // 跳转到设置
    SetTableViewController *setTVC = [SetTableViewController shareSetting];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:setTVC];
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)backToNext:(UIButton *)sender {
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(toDoSomething:) object:sender];
    [self performSelector:@selector(toDoSomething:) withObject:sender afterDelay:0.1f];

}

- (void)toDoSomething:(id)sender {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.popUpBox.transform = CGAffineTransformRotate(self.popUpBox.transform, -M_PI_2);
        
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIAlertView Delegate

- (void)changetitle:(NSNotification *)sender {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:nil forKey:@"userName"];
        [userDefault setObject:nil forKey:@"password"];
        [self.popUpBox.signIn setTitle:@"登录" forState:UIControlStateNormal];
}

@end
