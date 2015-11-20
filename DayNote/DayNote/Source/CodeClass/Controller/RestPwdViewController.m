//
//  RestPwdViewController.m
//  YewNoteMe
//
//  Created by youyou on 15/10/17.
//  Copyright (c) 2015年 刘晓阳. All rights reserved.
//

#import "RestPwdViewController.h"

@interface RestPwdViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong)RestPwdView *re;

@end

@implementation RestPwdViewController

- (void)loadView
{
    self.re = [[RestPwdView alloc]init];
    self.view = _re;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_setData];
    // Do any additional setup after loading the view.
}

- (void)p_setData
{
    self.re.emailLabel.text = @"邮箱验证:";
    self.re.emailTextField.placeholder = @"请输入注册邮箱";
    [self.re.sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.re.sureBtn.backgroundColor = [UIColor flatBlueColor];
    [self.re.sureBtn addTarget:self action:@selector(sureBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.re.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.re.cancleBtn.backgroundColor = [UIColor flatBlueColor];
    [self.re.cancleBtn addTarget:self action:@selector(cancleBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancleBtn:(UIButton *)sender
{
    [self dismissKeyboard:self.re.emailTextField];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)dismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}

#pragma mark  键盘回收方法
//键盘回收
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self.re.emailTextField isExclusiveTouch])
    {
        [self.re.emailTextField resignFirstResponder];
    }
    
}

- (void)sureBtn:(UIButton *)sender
{
    [AVUser requestPasswordResetForEmailInBackground:self.re.emailTextField.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"进入邮箱验证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"验证失败" message:@"请输入正确邮箱" delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.frame];
    
        [self.view addSubview:web];
        
        NSURLRequest *pathURl = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://mail.qq.com/cgi-bin/loginpage"]];
        [web loadRequest:pathURl];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
