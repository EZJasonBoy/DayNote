//
//  RegisterViewController.m
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 张晓敏. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<RegisterViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) RegisterView *registerView;
@property (nonatomic, strong) UIAlertView *alert;
@property (nonatomic, strong) UIButton *serviceTerms;

@end

@implementation RegisterViewController
-(void)loadView
{
    _registerView = [[RegisterView alloc]init];
    self.view = _registerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forBarMetrics:UIBarMetricsCompact];
    self.registerView.backgroundColor = [UIColor whiteColor];
    
    _registerView.delegate = self;
    _registerView.UserNameText.delegate = self;
    _registerView.PwdText.delegate = self;
    _registerView.AgainPwdText.delegate = self;
   
    self.serviceTerms = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height*30/667, [UIScreen mainScreen].bounds.size.height*400/667, [UIScreen mainScreen].bounds.size.height*300/667, [UIScreen mainScreen].bounds.size.height*30/667)];
    [self.serviceTerms.titleLabel setFont:[UIFont fontWithName:@"Menlo" size:[UIScreen mainScreen].bounds.size.height*14/667]];
    [self.serviceTerms setTitle:@"注册表示您已阅读并同意服务条款" forState:UIControlStateNormal];
    [self.serviceTerms setTitleColor:[UIColor colorWithRed:0.243 green:0.322 blue:0.573 alpha:0.700] forState:UIControlStateNormal];
    [self.serviceTerms setTitleColor:[UIColor flatBlueColor] forState:UIControlStateHighlighted];
    [self.registerView addSubview:_serviceTerms];
    [self.serviceTerms addTarget:self action:@selector(pushToOther:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height*75/667, [UIScreen mainScreen].bounds.size.height*425/667, [UIScreen mainScreen].bounds.size.height*210/667, [UIScreen mainScreen].bounds.size.height*1/667)];
    label.backgroundColor = [UIColor colorWithRed:0.243 green:0.322 blue:0.573 alpha:0.700];
    [self.registerView addSubview:label];

    
}
- (void)pushToOther:(UIButton *)sender {
    ServiceViewController *serveice = [[ServiceViewController alloc] init];
    
    [self.navigationController pushViewController:serveice  animated:YES];
}

//控制*的出现和消失
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_registerView.UserNameText.text length]>0)
    {
        _registerView.UserNull.text = @"";
    }
    else
    {
        _registerView.UserNull.text = @"*";
    }

    if ([_registerView.PwdText.text length]>0)
    {
        _registerView.PwdrNull.text = @"";
    }
    else
    {
        _registerView.PwdrNull.text = @"*";
    }
    if ([_registerView.AgainPwdText.text length]>0)
    {
        _registerView.AgainPwdNull.text = @"";
    }
    else
    {
         _registerView.AgainPwdNull.text = @"*";
    }
    if ([_registerView.MailText.text length]>0)
    {
        _registerView.MailNull.text = @"";
    }
    else
    {
        _registerView.MailNull.text = @"*";
    }
    //设置textfiled的输入长度
    if ([textField.text length] < 6)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:nil message:@"不能少于6位" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
        [self.alert show];
    }
    if ([textField.text length] > 12)
    {
        self.alert = [[UIAlertView alloc] initWithTitle:nil message:@"不能超过12位" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
        [self.alert show];
    }
    
}

//判断邮箱是否合法
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
//键盘回收
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_registerView.UserNameText isExclusiveTouch])
    {
        [_registerView.UserNameText resignFirstResponder];
    }
    if (![_registerView.PwdText isExclusiveTouch])
    {
        [_registerView.PwdText resignFirstResponder];
    }
    if (![_registerView.AgainPwdText isExclusiveTouch])
    {
        [_registerView.AgainPwdText resignFirstResponder];
    }
    if (![_registerView.MailText isExclusiveTouch])
    {
        [_registerView.MailText resignFirstResponder];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_registerView.UserNameText resignFirstResponder];
    [_registerView.PwdText resignFirstResponder];
    [_registerView.AgainPwdText resignFirstResponder];
    [_registerView.MailText resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reset {
    _registerView.UserNameText.text = nil;
    _registerView.PwdText.text = nil;
    _registerView.AgainPwdText.text = nil;
    _registerView.MailText.text = nil;
}

- (void)login {
    //设置textfiled不能为空
    if ([_registerView.UserNameText.text isEqualToString: @""] || [_registerView.PwdText.text isEqualToString: @""]||[_registerView.MailText.text isEqualToString:@""])
    {
        self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名.邮箱或密码不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [self.alert show];
        
        
    }
    else
    {
        //判断邮箱格式是否正确
        BOOL y = [self validateEmail:_registerView.MailText.text];
        if (y == 0)
        {
            self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邮箱格式不正确!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [self.alert show];
        }
        else
        {
            if (![_registerView.PwdText.text isEqualToString:_registerView.AgainPwdText.text])
            {
                self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"两次输入密码不一致!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [self.alert show];
            }
            
            if ((![_registerView.UserNameText.text isEqualToString:@""]) &&[_registerView.PwdText.text isEqualToString:_registerView.AgainPwdText.text])
            {
                AVUser *user = [AVUser user];
                user.username = [Md5 md5:_registerView.UserNameText.text];
                user.password = [Md5 md5:_registerView.PwdText.text];
                user.email = _registerView.MailText.text;
                
                //注册成功
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded)
                    {
                        NSLog(@"success");
                        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:_registerView.UserNameText.text,@"userName",_registerView.PwdText.text,@"password", nil];
                        self.userInfo(dict);
                    }
                    else
                    {
                        //判断用户名是否存在
                        AVQuery *query = [AVUser query];
                        [query whereKey:@"username" equalTo:[Md5 md5:_registerView.UserNameText.text]];
                        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                            if (error == nil)
                            {
                            }
                            else
                            {
                                self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码已存在!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                [self.alert show];
                            }
                        }];
                        
                    }
                }];
            }
            
            
        }
        
    }
}
@end
