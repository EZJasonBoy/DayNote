//
//  MyNavigationViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "PopUpBoxViewController.h"

@interface PopUpBoxViewController () <PopUpBoxViewDelegate>

@property (nonatomic, strong) PopUpBoxView *popUpBox;

@end

@implementation PopUpBoxViewController

- (void)loadView {
    self.popUpBox = [[PopUpBoxView alloc] initWithFrame:CGRectMake(0, -623, 375, 556)];
    self.view = _popUpBox;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.popUpBox.delegate = self;
    self.popUpBox.backgroundColor = [UIColor flatBlueColor];

    self.popUpBox.layer.cornerRadius = 2;
    self.popUpBox.signIn.hidden = NO;
    
    CGPoint center = self.popUpBox.circleImage.center;
    center.x = self.popUpBox.center.x;
    center.y = self.popUpBox.frame.size.height+11;
    self.popUpBox.circleImage.center = center;
}

- (void)signIn {
    // 跳转到登陆界面
}

- (void)intoUserCenter {
    // 跳转到个人中心
}

- (void)intoSetting {
    // 跳转到设置
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
