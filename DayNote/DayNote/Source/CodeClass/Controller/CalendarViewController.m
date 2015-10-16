//
//  CalendarViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()
@property (nonatomic, strong) PopUpBoxViewController *popUpBoxVC;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setNavigationBar];
}
// 设置导航栏
- (void)p_setNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchMyDiary:)];
    
    self.navigationItem.title = @"回忆";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:0.663 green:0.616 blue:1.000 alpha:1.000]] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(popupList:)];
    
    self.popUpBoxVC = [[PopUpBoxViewController alloc] init];
    
    [self.view addSubview:_popUpBoxVC.view];
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
