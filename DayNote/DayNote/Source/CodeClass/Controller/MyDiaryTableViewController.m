//
//  MyDiaryTableViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "MyDiaryTableViewController.h"


@interface MyDiaryTableViewController () <YALTabBarInteracting>

@property (nonatomic, strong) PopUpBoxView *popUpBox;

@end

@implementation MyDiaryTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:[[UIView alloc] init]];
    _popUpBox = [[PopUpBoxView alloc] initWithFrame:CGRectMake(-188, -354, 375, 667)];
    _popUpBox.backgroundColor = [UIColor flatBlueColor];
    self.popUpBox.transform = CGAffineTransformMakeRotation(-M_PI);
    self.popUpBox.layer.anchorPoint = CGPointMake(0, 0);

//    [[UIApplication sharedApplication].keyWindow insertSubview:_popUpBoxVC.view aboveSubview:self.tableView];
    [self.navigationController.navigationBar insertSubview:_popUpBox atIndex:0];
    
    [self.tableView registerClass:[DiaryListTableViewCell class] forCellReuseIdentifier:@"diary"];
    [self p_setNavigationBar];
   
}

- (void)viewDidAppear:(BOOL)animated {
    [YALFoldingTabBarController shareFoldingTabBar].tabBarView.hidden = NO;
    self.diaryGroup =  [[GetDataTools shareGetDataTool] descendingDataArray].mutableCopy;
    [self.tableView reloadData];
}

// 设置导航栏
- (void)p_setNavigationBar {
    
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
   
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"ic_menuRotated"]];
            
//            CGRect rect = self.popUpBoxVC.view.frame;
//            rect.origin.y = 32;
//
//            self.popUpBoxVC.view.frame = rect;
            self.popUpBox.transform = CGAffineTransformRotate(self.popUpBox.transform, M_PI);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                self.tabBarController.tabBar.hidden = YES;
            }];
        }];

    }else {
       
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"ic_menu"]];
//            CGRect rect = self.popUpBoxVC.view.frame;
//            rect.origin.y = -625;
//            self.popUpBoxVC.view.frame = rect;
            self.popUpBox.transform = CGAffineTransformRotate(self.popUpBox.transform, -M_PI);
            
        } completion:^(BOOL finished) {
            
        }];
        
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
    if (height <= 50) {
         cell.detailsText.frame = CGRectMake(CGRectGetMinX(cell.detailsText.frame), CGRectGetMinY(cell.detailsText.frame), CGRectGetWidth(cell.detailsText.frame), height);
    }else {
        cell.detailsText.frame = CGRectMake(CGRectGetMinX(cell.detailsText.frame), CGRectGetMinY(cell.detailsText.frame), CGRectGetWidth(cell.detailsText.frame), 50);
    }
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self heightForString:((DayNote *)self.diaryGroup[indexPath.section]).diaryBody] > 60) {
        return 92;
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
    
    [YALFoldingTabBarController shareFoldingTabBar].tabBarView.hidden = YES;
    
    DiaryDetailsViewController *DDVC = [[DiaryDetailsViewController alloc] init];
    DDVC.diaryIndex = indexPath.section;
    [self.navigationController pushViewController:DDVC animated:YES];
    
}

- (CGFloat)heightForString:(NSString *)aString {
    CGRect rect = [aString boundingRectWithSize:CGSizeMake([[DiaryListTableViewCell alloc] init].contentView.frame.size.width, 10000) 
                          options:NSStringDrawingUsesLineFragmentOrigin 
                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} 
                          context:nil];
    
    return rect.size.height;
}

#pragma mark - YAL 三方
- (void)extraLeftItemDidPress {
    
}
// 写日记
- (void)extraRightItemDidPress {
    AddDiaryViewController *addDiary = [[AddDiaryViewController alloc] init];
    addDiary.modalPresentationStyle = UIModalPresentationCustom;
    addDiary.transitioningDelegate = self;
    addDiary.contentDate = [NSDate date];
    addDiary.type = ADDTYPEInsert;
    [self.navigationController presentViewController:addDiary animated:YES completion:nil];
}




@end
