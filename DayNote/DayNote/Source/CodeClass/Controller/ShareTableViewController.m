//
//  ShareTableViewController.m
//  DayNote
//
//  Created by boluchuling on 15/10/22.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "ShareTableViewController.h"
#import "ShareTableViewCell.h"

@interface ShareTableViewController ()<CNPPopupControllerDelegate>
@property (nonatomic,assign)NSInteger index;
@end

@implementation ShareTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ShareTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.frame = CGRectMake(CGRectGetMinX(self.tableView.frame), CGRectGetMinY(self.tableView.frame), CGRectGetWidth(self.tableView.frame), CGRectGetWidth(self.tableView.frame)-100);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    }];
    self.shareArr = [NSMutableArray array];
}

-(void)viewDidAppear:(BOOL)animated
{
    AVQuery *query = [AVQuery queryWithClassName:@"DriftBottle"];
    NSArray *arr = [NSMutableArray arrayWithArray:[query findObjects]];
    for (int i = 0; i < arr.count; i++) {
        self.shareArr[i] = arr[arr.count - i - 1];
    }
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"navigation" object:nil userInfo:@{@"pageIndex":@"3"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // Return the number of rows in the section.
    return self.shareArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.createDate.text = [[ConversionWithDate shareDateConversion] getStringWithDate:[self.shareArr[indexPath.row] objectForKey:@"contentDate"] type:GZWDateFormatTypeConnector];  
    cell.weather.text = [self.shareArr[indexPath.row] objectForKey:@"weather"];
    cell.mood.text = [self.shareArr[indexPath.row] objectForKey:@"mood"];
    cell.diaryBody.text = [self.shareArr[indexPath.row] objectForKey:@"diaryBody"];
    
    if ([self.shareArr[indexPath.row] objectForKey:@"localLocation"] != nil) {
        
        cell.city.text = [self.shareArr[indexPath.row] objectForKey:@"localLocation"];
    }else {
        cell.city.text = @"未知";
    }
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%254/255.0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.index = indexPath.row;
    [self showPopupWithStyle:CNPPopupStyleCentered];
}

#pragma mark  点击cell  demo显示
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"\n" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSString *text = [self.shareArr[self.index]objectForKey:@"diaryBody"];
    if (text == nil) {
        text = @"";
    }
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:@"\n" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"取消" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupController *popupController = [[CNPPopupController alloc] initWithTitle:title contents:@[lineOne,lineTwo] buttonTitles:@[buttonTitle] destructiveButtonTitle:nil];
    popupController.theme = [CNPPopupTheme defaultTheme];
    popupController.theme.popupStyle = popupStyle;
    popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromTop;
    popupController.theme.dismissesOppositeDirection = YES;
    popupController.delegate = self;
    [popupController presentPopupControllerAnimated:YES];
    
    
    
    
}

@end
