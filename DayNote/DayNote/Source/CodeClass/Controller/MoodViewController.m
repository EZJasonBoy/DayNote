//
//  MoodViewController.m
//  DayNote
//
//  Created by youyou on 15/10/16.
//  Copyright (c) 2015年 张晓敏. All rights reserved.
//

#import "MoodViewController.h"

@interface MoodViewController ()

@property(nonatomic,assign)CGFloat precent;
@property(nonatomic,assign)CGFloat good;
@property(nonatomic,assign)CGFloat smooth;
@property(nonatomic,assign)CGFloat bad;
@property(nonatomic,assign)CGFloat total;


@end

@implementation MoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"SXWaveCell" bundle:nil] forCellReuseIdentifier:@"mood"];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.good = [[GetDataTools shareGetDataTool] selectDataCountWithMood:@"高兴"];
    self.smooth = [[GetDataTools shareGetDataTool] selectDataCountWithMood:@"平淡"];
    self.bad = [[GetDataTools shareGetDataTool] selectDataCountWithMood:@"难过"];
    [self.tableView reloadData];
//    
    // ------在需要加入动画的地方
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"navigation" object:nil userInfo:@{@"pageIndex":@"2"}];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //输入统计过的心情数据

    SXWaveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mood" forIndexPath:indexPath];
    _total = _good + _bad + _smooth;
    
    if (_total == 0) {
        _total = 1;
    }
    if (indexPath.row == 0)
    {
        self.precent = _good/_total * 100;
        [cell addAnimateWithType:0];
        [cell setPrecent:self.precent textColor:[UIColor orangeColor] type:0 alpha:1];
        cell.endless = YES;
        //设置背景图片
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fine.jpg"]];
        //设置图片上的文字
        cell.discriptionLbl.text = @"心情不错";
    }
    else if (indexPath.row == 1)
    {
    
        self.precent = _smooth/_total * 100;
        [cell addAnimateWithType:0];
        [cell setPrecent:self.precent textColor:[UIColor greenColor] type:1 alpha:0.6];
        cell.endless = YES;
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sky.jpg"]];
        cell.discriptionLbl.text = @"心情平稳";
    }
    else if (indexPath.row == 2)
    {
        [cell addAnimateWithType:0];
        self.precent = _bad/_total * 100;
        
        [cell setPrecent:self.precent textColor:[UIColor brownColor] type:2 alpha:0.3];
        cell.endless = YES;
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rain.jpg"]];
        cell.discriptionLbl.text = @"心情糟透了";
        
    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tempStr;
    if (indexPath.row == 0)
    {
      
        tempStr = @"高兴";
    }
    else if(indexPath.row == 1)
    {

        tempStr = @"平淡";
    }
    else
    {

        tempStr = @"难过";
    }

    [self goToOtherWithMood:tempStr];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的高度
    return [UIScreen mainScreen].bounds.size.height*185/667;
}

- (void)goToOtherWithMood:(NSString *)aString {
    DetailsMoodTableViewController *DMTVC = [[DetailsMoodTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    DMTVC.moodStr = aString;
    [self.navigationController pushViewController:DMTVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
