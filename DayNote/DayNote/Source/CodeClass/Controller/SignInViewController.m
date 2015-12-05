//
//  SignInViewController.m
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 刘晓阳. All rights reserved.
//

#import "SignInViewController.h"


@interface SignInViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) SignView *signView;
@end

@implementation SignInViewController
- (void)loadView
{
    self.signView = [[SignView alloc]init];
    self.view = _signView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.signView setBackgroundColor:[UIColor whiteColor]];
    self.signView.userTextField.delegate = self;
    self.signView.pwdTextField.delegate = self;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forBarMetrics:UIBarMetricsCompact];          
    self.navigationController.navigationBar.tintColor = [UIColor flatBlueColor];
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [self p_Action];
    
    // Do any additional setup after loading the view.
}
- (void)p_Action
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"忘记密码" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    
    [self.signView.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];   //  注册
    [self.signView.signBtn addTarget:self action:@selector(signAction:) forControlEvents:UIControlEventTouchUpInside];   // 登录
}
#pragma mark  注册 登录方法
- (void)loginAction:(UIButton *)sender
{
    
    RegisterViewController *registerView = [[RegisterViewController alloc]init];
    registerView.userInfo = ^(NSDictionary *dict) {
        self.signView.userTextField.text = dict[@"userName"];
        self.signView.pwdTextField.text = dict[@"password"];
        [self signAction:self.signView.signBtn];
    };                                                           
    
    [self.navigationController pushViewController:registerView animated:YES];
    [self touchesEnded:nil withEvent:nil];
}                               
- (void)signAction:(UIButton *)sender
{
    
    [AVUser logInWithUsernameInBackground:self.signView.userTextField.text password:self.signView.pwdTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"😄😄😄" message:@"恭喜登录成功！" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            NSUserDefaults *userNamePwd = [NSUserDefaults standardUserDefaults];
            [userNamePwd setObject:self.signView.userTextField.text forKey:@"userName"];
            [userNamePwd setObject:self.signView.pwdTextField.text forKey:@"password"];
            [[GetDataTools shareGetDataTool] selectDataWithUserName:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadView" object:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"😢😢😢" message:@"怎么就失败了呢？" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alert show];
            [self performSelector:@selector(failAction:) withObject:alert afterDelay:1];
            
        }
    }];
    [self touchesEnded:nil withEvent:nil];
}

- (void)failAction:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark 取消
- (void)leftAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  忘记密码方法
- (void)rightAction:(UIBarButtonItem *)sender
{
    RestPwdViewController *re = [[RestPwdViewController alloc]init];

    [self.navigationController presentViewController:re animated:YES completion:nil];
}

#pragma mark  键盘回收方法
//键盘回收
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self.signView.userTextField isExclusiveTouch])
    {
        [self.signView.userTextField resignFirstResponder];
    }
    if (![self.signView.pwdTextField isExclusiveTouch])
    {
        [self.signView.pwdTextField resignFirstResponder];
    }

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.signView.signBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.245 green:0.327 blue:0.589 alpha:0.900]] forState:UIControlStateNormal];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
