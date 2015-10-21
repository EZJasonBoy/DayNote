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
    self.popUpBox = [[PopUpBoxView alloc] initWithFrame:CGRectMake(-187.5, -333, 375, 667)];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startAnimation:) name:@"start" object:nil];
}
- (void)startAnimation:(NSNotification *)sender {
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAnimarToOther:) object:sender];
    [self performSelector:@selector(startAnimarToOther:) withObject:sender afterDelay:0.2f];
    
}

- (void)startAnimarToOther:(id)sender {
    self.popUpBox.jianImageVIew.hidden = NO;
    self.popUpBox.yiImageView.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint center = self.popUpBox.yiImageView.center;
        center.x = 100;
        self.popUpBox.yiImageView.center = center;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGPoint center = self.popUpBox.jianImageVIew.center;
        center.x = 180;
        center.y -= 10;
        self.popUpBox.jianImageVIew.center = center;
    } completion:nil];
}

- (void)signIn {
    // 跳转到登陆界面
    NSLog(@"1234234");
}

- (void)intoUserCenter {
    // 跳转到个人中心
}

- (void)intoSetting {
    // 跳转到设置
}

- (void)backToNext:(UIButton *)sender {
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(toDoSomething:) object:sender];
    [self performSelector:@selector(toDoSomething:) withObject:sender afterDelay:0.1f];

}

- (void)toDoSomething:(id)sender {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.popUpBox.transform = CGAffineTransformRotate(self.popUpBox.transform, -M_PI_2);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGPoint center = self.popUpBox.yiImageView.center;
            center.x -= 200;
            self.popUpBox.yiImageView.center = center;
        } completion:^(BOOL finished) {
            self.popUpBox.yiImageView.hidden = YES;
        }];
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
            CGPoint center = self.popUpBox.jianImageVIew.center;
            center.x -= 200;
            center.y += 10;
            self.popUpBox.jianImageVIew.center = center;
        } completion:^(BOOL finished) {
            self.popUpBox.jianImageVIew.hidden = YES;
        }];
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
