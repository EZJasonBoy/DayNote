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

    self.diaryGroup =  [[GetDataTools shareGetDataTool] descendingDataArray].mutableCopy;;
    NSLog(@"%@", self.diaryGroup);
    [self.tableView registerClass:[DiaryListTableViewCell class] forCellReuseIdentifier:@"diary"];
    [self p_setNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)getLocalData {

}

// 设置导航栏
- (void)p_setNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchMyDiary:)];
    
    self.navigationItem.title = @"my diary";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatMintColor]] forBarMetrics:UIBarMetricsDefault];
   
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
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            [self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"ic_menuRotated"]];
            CGRect rect = self.popUpBoxVC.view.frame;
            rect.origin.y = 0.1;
            rect.size.width = 90;
            rect.size.height = 130;
            
            self.popUpBoxVC.view.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    }else {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"ic_menu"]];
            CGRect rect = self.popUpBoxVC.view.frame;
            rect.origin.y = -130;
            rect.size.width = 1;
            rect.size.height = 1;
            
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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 134;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *str = [[ConversionWithDate shareDateConversion] getStringWithDate:((AllMyDiary *)self.diaryGroup[section]).contentDate type:GZWDateFormatTypeConnector];
    return str;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
