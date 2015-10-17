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
@property (nonatomic, strong) UIView *view1;

@end

@implementation MyDiaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[DiaryListTableViewCell class] forCellReuseIdentifier:@"diary"];
    [self p_setNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    self.diaryGroup =  [[GetDataTools shareGetDataTool] descendingDataArray].mutableCopy;
    [self.tableView reloadData];
}

// 设置导航栏
- (void)p_setNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchMyDiary:)];
    
    self.navigationItem.title = @"my diary";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forBarMetrics:UIBarMetricsDefault];
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(popupList:)];
    
    self.popUpBoxVC = [[PopUpBoxViewController alloc] init];
    
    [self.tableView addSubview:_popUpBoxVC.view];
}

- (void)searchMyDiary:(UIBarButtonItem *)sender {
    AddDiaryViewController *writeDiary = [[AddDiaryViewController alloc] init];
    writeDiary.contentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    [self presentViewController:writeDiary animated:YES completion:nil];
}

- (void)popupList:(UIBarButtonItem *)sender {
    static BOOL isTouch = NO;
    if (isTouch == NO) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.99 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            [self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"ic_menuRotated"]];
            CGRect rect = self.popUpBoxVC.view.frame;
            rect.origin.y = 0.1;
            
            self.popUpBoxVC.view.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    }else {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1.2 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"ic_menu"]];
            CGRect rect = self.popUpBoxVC.view.frame;
            rect.origin.y = -623;
            
            self.popUpBoxVC.view.frame = rect;
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
    cell.weatherLabel.text = @"天气";
    cell.moodLabel.text = @"心情";
    cell.detailsText.text = ((AllMyDiary *)self.diaryGroup[indexPath.section]).diaryBody;
    CGFloat height = [self heightForString:cell.detailsText.text];
    if (height <= 100) {
         cell.detailsText.frame = CGRectMake(CGRectGetMinX(cell.detailsText.frame), CGRectGetMinY(cell.detailsText.frame), CGRectGetWidth(cell.detailsText.frame), height);
    }else {
        cell.detailsText.frame = CGRectMake(CGRectGetMinX(cell.detailsText.frame), CGRectGetMinY(cell.detailsText.frame), CGRectGetWidth(cell.detailsText.frame), 100);
    }
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self heightForString:((AllMyDiary *)self.diaryGroup[indexPath.section]).diaryBody] > 100) {
        return 151;
    }else {
        return 51+[self heightForString:((AllMyDiary *)self.diaryGroup[indexPath.section]).diaryBody];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *str = [[ConversionWithDate shareDateConversion] getStringWithDate:((AllMyDiary *)self.diaryGroup[section]).contentDate type:GZWDateFormatTypeConnector];
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
    AllMyDiary *amd = self.diaryGroup[indexPath.section];
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [self.diaryGroup removeObjectAtIndex:indexPath.section];
        // core data 删除数据
        [[GetDataTools shareGetDataTool] deleteDataWithDate:amd.createDate];
        // 删除cell
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];

    } 
}

- (CGFloat)heightForString:(NSString *)aString {
    CGRect rect = [aString boundingRectWithSize:CGSizeMake([[DiaryListTableViewCell alloc] init].contentView.frame.size.width, 10000) 
                          options:NSStringDrawingUsesLineFragmentOrigin 
                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} 
                          context:nil];
    
    return rect.size.height;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
