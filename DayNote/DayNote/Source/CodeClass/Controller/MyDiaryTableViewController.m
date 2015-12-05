//
//  MyDiaryTableViewController.m
//  DayNote
//
//  Created by boluchuling on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "MyDiaryTableViewController.h"


@interface MyDiaryTableViewController () <YALTabBarInteracting,UISearchBarDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) PopUpBoxViewController *popUpBox;
@property (nonatomic, strong) UISearchBar *mySearchBar;
@property (nonatomic, strong) NSMutableArray *searchData;
@property (nonatomic, strong) NSArray *tempArr;
@property (nonatomic, assign) BOOL isSearch;
@end

@implementation MyDiaryTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSearchBar];
    
    // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.jpg"]];
    
    self.tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
}

- (void)addSearchBar {
    self.mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 374, 42)];
    [self.mySearchBar setPlaceholder:@"想找到什么日记?"];
    
    self.mySearchBar.delegate = self;
    [self.mySearchBar setShowsCancelButton:NO];
    
    [self.mySearchBar setTintColor:[UIColor flatBlueColor]];
    [self.mySearchBar setTranslucent:YES];
    
    [self.tableView setTableHeaderView:_mySearchBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeFirst:) name:@"search" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resisFirst:) name:@"noSearch" object:nil];

    self.isSearch = NO;
}

- (void)becomeFirst:(NSNotification *)sender {
    self.searchData = self.diaryGroup.mutableCopy;
    self.isSearch = YES;
}

- (void)resisFirst:(NSNotification *)sender {
    self.isSearch = NO;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView registerClass:[DiaryListTableViewCell class] forCellReuseIdentifier:@"diary"];
    
    //  更新数据 如果不为空就置为空
    if (self.diaryGroup != nil) {
        self.diaryGroup = nil;
    }
    // 获取数据
    self.diaryGroup = [[GetDataTools shareGetDataTool] descendingDataArray].mutableCopy;
    [YALFoldingTabBarController shareFoldingTabBar].tabBarView.hidden = NO;
    
    self.diaryGroup = [[GetDataTools shareGetDataTool] selectDataWithUserName:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]].mutableCopy;
    
    // 设置坚持天数
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld", (unsigned long)self.diaryGroup.count],@"dayCount", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"day" object:nil userInfo:dict];
    // 判断是否是搜索
    if (_isSearch == NO) {
        self.tempArr = self.diaryGroup;
        [self.navigationController setNavigationBarHidden:NO];
    }
    if (_isSearch == YES) {
        self.tempArr = self.searchData;
    }
    
    [self.tableView reloadData];
    

    [[NSNotificationCenter defaultCenter] postNotificationName:@"navigation" object:nil userInfo:@{@"pageIndex":@"0"}];
    
    // 登陆后刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:@"reloadView" object:nil];


}

- (void)refreshData:(NSNotification *)sender {
    [self viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return self.tempArr.count;//self.diaryGroup.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [tableView setShowsVerticalScrollIndicator:NO];
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiaryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"diary" forIndexPath:indexPath];
    
    // Configure the cell...
    if (_isSearch == NO) {
        self.tempArr = self.diaryGroup;
        [self.navigationController setNavigationBarHidden:NO];
    }

    cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", ((DayNote *)self.tempArr[indexPath.section]).weatherImage]];
    cell.moodImageView.image = [UIImage imageNamed:((DayNote *)self.tempArr[indexPath.section]).mood];
    cell.detailsText.text = ((DayNote *)self.tempArr[indexPath.section]).diaryBody;
    
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
    NSString *str = [[ConversionWithDate shareDateConversion] getStringWithDate:((DayNote *)self.tempArr[section]).contentDate type:GZWDateFormatTypeConnector];
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
        [tableView reloadData];
    } 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    DiaryDetailsViewController *DDVC = [[DiaryDetailsViewController alloc] init];
    DDVC.diaryData = self.tempArr[indexPath.section];
    [self.navigationController pushViewController:DDVC animated:YES];
    
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

#pragma mark - YAL 三方
// 搜索
- (void)extraLeftItemDidPress {
    [self.mySearchBar becomeFirstResponder];
}

// 写日记
- (void)extraRightItemDidPress {
    if ([[GetDataTools shareGetDataTool] selectDataWithDate:[NSDate date]] == nil) {
        AddDiaryViewController *addDiary = [[AddDiaryViewController alloc] init];
        addDiary.type = ADDTYPEInsert;// 选择新写
        addDiary.contentDate = [NSDate date];
        [self presentViewController:addDiary animated:YES completion:nil];
    }else {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"您很勤奋偶,不过一天写一篇日记就可以喽" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [view show];  
    }
    
}



#pragma mark - searchDelegate

// 获取焦点时
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"search" object:nil];
    
    [UIView animateWithDuration:.5 animations:^{
        [self.mySearchBar setShowsCancelButton:YES animated:YES];
    }];
    return YES;
}

// 点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self stopSearch];
}

// 搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self stopSearch];
}

// 文字改变时
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (self.searchData == nil) {
        self.searchData = [NSMutableArray array];
    }else {
        [self.searchData removeAllObjects];
    }
    
    for (DayNote *temp in self.diaryGroup) {
        if ([temp.diaryBody rangeOfString:searchText].location != NSNotFound) {
            if ([temp.diaryBody containsString:searchText]) {
                [self.searchData addObject:temp];
            }
        }
    }
    self.tempArr = self.searchData;
    if ([searchText isEqualToString:@""]) {
        self.tempArr = self.diaryGroup;
    }
    
    [self.tableView reloadData];
}

- (void)stopSearch {
    [UIView animateWithDuration:.5 animations:^{
        [self.mySearchBar resignFirstResponder];
        [self.mySearchBar setText:@""];
        [self.mySearchBar setShowsCancelButton:NO animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"noSearch" object:nil];
    }];
}

@end
