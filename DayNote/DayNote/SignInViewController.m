//
//  SignInViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 刘晓阳. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()
@property (nonatomic,strong)SignView *signView;
@end

@implementation SignInViewController
- (void)loadView
{
    self.signView = [[SignView alloc]init];
    self.view = _signView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"忘记密码" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    // Do any additional setup after loading the view.
}
- (void)leftAction:(UIBarButtonItem *)sender
{
    
}
- (void)rightAction:(UIBarButtonItem *)sender
{
    
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
