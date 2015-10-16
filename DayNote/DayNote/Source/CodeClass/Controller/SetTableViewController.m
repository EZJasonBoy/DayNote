//
//  SetTableViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 刘晓阳. All rights reserved.
//

#import "SetTableViewController.h"

@interface SetTableViewController ()
@property (nonatomic,strong)NSMutableArray *arr;
@property (nonatomic,strong)UISwitch *mySwitch;
@end

@implementation SetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[SetTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self p_switch];
    self.arr = [[NSMutableArray alloc]init];
    self.arr = @[@"皮肤设置",@"夜间模式",@"清除缓存",@"检查更新",@"关于我们"].mutableCopy;
}
- (void)p_switch
{
    self.mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    
    self.mySwitch.onTintColor = [UIColor purpleColor];
    [self.mySwitch setOn:NO];
    self.mySwitch.tintColor = [UIColor grayColor];
    [self.mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
}
- (void)switchAction:(UISwitch *)sender
{
    if (sender.isOn) {
        self.view.alpha = 0.2;
    }else
    {
        self.view.alpha = 1;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
// #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
// #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.arr [indexPath.section];
    
    if (indexPath.section == 1) {
        cell.accessoryView = self.mySwitch;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            
            break;
        case 2:
            [self p_setAlert];
            break;
        case 3:
            break;
        case 4:
            [self p_setus];
            break;
        default:
            break;
    }
}
- (void)p_setus
{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:arc4random()%256/255.0];
}
- (void)p_setAlert
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"确认清除缓存？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
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
