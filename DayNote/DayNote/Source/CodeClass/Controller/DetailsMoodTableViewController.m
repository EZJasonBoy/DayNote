//
//  DetailsMoodTableViewController.m
//  DayNote
//
//  Created by boluchuling on 15/10/27.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "DetailsMoodTableViewController.h"

@interface DetailsMoodTableViewController ()

@property (nonatomic, strong) NSArray *moodList;

@end

@implementation DetailsMoodTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.moodList = [[GetDataTools shareGetDataTool] selectDataWithMood:self.moodStr];
    self.navigationItem.title = self.moodStr;
    
    [self.tableView registerClass:[DiaryListTableViewCell class] forCellReuseIdentifier:@"moodList"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return self.moodList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiaryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moodList" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", ((DayNote *)self.moodList[indexPath.section]).weatherImage]];
    cell.moodImageView.image = [UIImage imageNamed:((DayNote *)self.moodList[indexPath.section]).mood];
    cell.detailsText.text = ((DayNote *)self.moodList[indexPath.section]).diaryBody;
    
    CGFloat height = [self heightForString:cell.detailsText.text];
    if (height <= 50) {
        cell.detailsText.frame = CGRectMake(CGRectGetMinX(cell.detailsText.frame), CGRectGetMinY(cell.detailsText.frame), CGRectGetWidth(cell.detailsText.frame), height);
    }else {
        cell.detailsText.frame = CGRectMake(CGRectGetMinX(cell.detailsText.frame), CGRectGetMinY(cell.detailsText.frame), CGRectGetWidth(cell.detailsText.frame), 50);
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self heightForString:((DayNote *)self.moodList[indexPath.section]).diaryBody] > 60) {
        return 92;
    }else {
        return 51+[self heightForString:((DayNote *)self.moodList[indexPath.section]).diaryBody];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *str = [[ConversionWithDate shareDateConversion] getStringWithDate:((DayNote *)self.moodList[section]).contentDate type:GZWDateFormatTypeConnector];
    return str;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController setNavigationBarHidden:NO];
//    [YALFoldingTabBarController shareFoldingTabBar].tabBarView.hidden = YES;
    
    DiaryDetailsViewController *DDVC = [[DiaryDetailsViewController alloc] init];
    
    DDVC.diaryData = self.moodList[indexPath.section];
    
    [self.navigationController pushViewController:DDVC animated:YES];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)heightForString:(NSString *)aString {
    CGRect rect = [aString boundingRectWithSize:CGSizeMake([[DiaryListTableViewCell alloc] init].contentView.frame.size.width, 10000) 
                                        options:NSStringDrawingUsesLineFragmentOrigin 
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} 
                                        context:nil];
    
    return rect.size.height;
}

@end
