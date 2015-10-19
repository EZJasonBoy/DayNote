//
//  MyDiaryTableViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "MyDiaryTableViewController.h"


@interface MyDiaryTableViewController () 

@property (nonatomic, strong) PopUpBoxViewController *popUpBoxVC;

@end

@implementation MyDiaryTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[DiaryListTableViewCell class] forCellReuseIdentifier:@"diary"];
    [self p_setNavigationBar];
   
   
}

- (void)viewDidAppear:(BOOL)animated {
    if (_popUpBoxVC == nil) {
        _popUpBoxVC = [[PopUpBoxViewController alloc] init];
        [self.tableView addSubview:_popUpBoxVC.view];
    }
    
    self.diaryGroup =  [[GetDataTools shareGetDataTool] descendingDataArray].mutableCopy;
    [self.tableView reloadData];
}

// 设置导航栏
- (void)p_setNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchMyDiary:)];
    
    self.navigationItem.title = @"my diary";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forBarMetrics:UIBarMetricsDefault];
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(popupList:)];
    
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageFromColor:[UIColor clearColor]]];
}

- (void)searchMyDiary:(UIBarButtonItem *)sender {
   
}

- (void)popupList:(UIBarButtonItem *)sender {
    static BOOL isTouch = NO;
    if (isTouch == NO) {
   
        [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"ic_menuRotated"]];
            CGRect rect = self.popUpBoxVC.view.frame;
            rect.origin.y = 0;
            
            self.popUpBoxVC.view.frame = rect;
            
        } completion:nil];
        
    }else {
       
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"ic_menu"]];
            CGRect rect = self.popUpBoxVC.view.frame;
            rect.origin.y = -556;
            
            self.popUpBoxVC.view.frame = rect;
           
        } completion:nil];
        
    }
    isTouch = !isTouch;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return self.diaryGroup.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiaryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"diary" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", ((DayNote *)self.diaryGroup[indexPath.section]).weatherImage]];
    cell.moodImageView.image = nil;
    cell.detailsText.text = ((DayNote *)self.diaryGroup[indexPath.section]).diaryBody;
    CGFloat height = [self heightForString:cell.detailsText.text];
    if (height <= 100) {
         cell.detailsText.frame = CGRectMake(CGRectGetMinX(cell.detailsText.frame), CGRectGetMinY(cell.detailsText.frame), CGRectGetWidth(cell.detailsText.frame), height);
    }else {
        cell.detailsText.frame = CGRectMake(CGRectGetMinX(cell.detailsText.frame), CGRectGetMinY(cell.detailsText.frame), CGRectGetWidth(cell.detailsText.frame), 100);
    }
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self heightForString:((DayNote *)self.diaryGroup[indexPath.section]).diaryBody] > 100) {
        return 151;
    }else {
        return 51+[self heightForString:((DayNote *)self.diaryGroup[indexPath.section]).diaryBody];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *str = [[ConversionWithDate shareDateConversion] getStringWithDate:((DayNote *)self.diaryGroup[section]).contentDate type:GZWDateFormatTypeConnector];
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    DayNote *amd = self.diaryGroup[indexPath.section];
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [self.diaryGroup removeObjectAtIndex:indexPath.section];
        // core data 删除数据
        [[GetDataTools shareGetDataTool] deleteDataWithDate:amd.createDate];
        // 删除cell
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    } 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DiaryDetailsViewController *DDVC = [[DiaryDetailsViewController alloc] init];
    DDVC.hidesBottomBarWhenPushed = YES;
    DDVC.diaryIndex = indexPath.section;
    [self.navigationController pushViewController:DDVC animated:YES];
    DDVC.hidesBottomBarWhenPushed = NO;
}

- (CGFloat)heightForString:(NSString *)aString {
    CGRect rect = [aString boundingRectWithSize:CGSizeMake([[DiaryListTableViewCell alloc] init].contentView.frame.size.width, 10000) 
                          options:NSStringDrawingUsesLineFragmentOrigin 
                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} 
                          context:nil];
    
    return rect.size.height;
}

@end
