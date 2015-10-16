//
//  CalendarViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 刘晓阳. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)CalendarView *caView;
@end

@implementation CalendarViewController

- (void)loadView
{
    self.caView = [[CalendarView alloc]init];
    self.view = _caView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.caView.noteTable.delegate = self;
    self.caView.noteTable.dataSource = self;

//    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
//    calendar.frame = CGRectMake(10, 50, 300, 470);
//    CKCalendarView *ck = [[CKCalendarView alloc]initWithStartDay:startMonday frame:CGRectMake(10, 50, 300, 300)];
//    self.caView.calendarView = ck;
    // self.caView.noteTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    cell.textLabel.text = @"123";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
