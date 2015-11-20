//
//  SetTableViewController.m
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 刘晓阳. All rights reserved.
//

#import "SetTableViewController.h"

@interface SetTableViewController ()<UIActionSheetDelegate,UIAlertViewDelegate,CNPPopupControllerDelegate, TSMessageViewProtocol>

@property (nonatomic,strong) NSMutableArray *arr;

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIColor *color;

@property (nonatomic,strong) UIButton *button;
@end

static SetTableViewController *tools = nil;
@implementation SetTableViewController

+ (instancetype)shareSetting {
    if (tools == nil) {
        tools = [[SetTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    }
    return tools;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = colorCG;
    self.navigationItem.title = @"设置";
    [self.tableView registerClass:[SetTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.arr = [[NSMutableArray alloc]init];
    self.arr = @[@"皮肤设置",@"同步",@"清除缓存",@"关于我们"].mutableCopy;
    [TSMessage setDelegate:self];
   

    [self setNavigation];
    // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setNavigation {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forBarMetrics:UIBarMetricsCompact];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height*20/667, [UIScreen mainScreen].bounds.size.height*550/667, CGRectGetWidth([UIScreen mainScreen].bounds)-[UIScreen mainScreen].bounds.size.height*40/667, [UIScreen mainScreen].bounds.size.height*40/667)];
    self.button.layer.cornerRadius = 5;
    self.button.clipsToBounds = YES;
    [self.button setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(cancelSign:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_button];
}

- (void)viewWillAppear:(BOOL)animated {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] != nil) {
        self.button.userInteractionEnabled = YES;
        [self.button setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:1.000 green:0.350 blue:0.408 alpha:1.000]] forState:UIControlStateNormal];
    }else {
        self.button.userInteractionEnabled = NO;
        [self.button setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:1.000 green:0.350 blue:0.408 alpha:0.640]] forState:UIControlStateNormal];
    }
    
}

- (void)cancelSign:(UIButton *)sender {
    [sender setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:1.000 green:0.350 blue:0.408 alpha:0.640]] forState:UIControlStateNormal];
    self.button.userInteractionEnabled = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancel" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadView" object:nil];
}

- (void)changeColor:(NSNotification *)sender {
    self.button.userInteractionEnabled = YES;
    [self.button setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:1.000 green:0.350 blue:0.408 alpha:1.000]] forState:UIControlStateNormal];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    if (indexPath.section == 2) {
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(280, 5, 70, 30)];
        [cell addSubview:_label];
        self.label.text = [NSString stringWithFormat:@"文件: %ld",(unsigned long)files.count];
    }
    //取消选中颜色
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    self.tableView.scrollEnabled =NO;
    
    //   右边小箭头
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
#pragma mark  选中 tableview 触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"setColor" object:nil];
            break;
        case 1:
            [self p_synchronous];
            break;
        case 2:
            [self p_setAlert];
            break;
        case 3:
            [self p_about];
            break;
        default:
            break;
    }
}

#pragma mark - 同步
- (void)p_synchronous {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] == nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请登录后使用" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择方式" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self synchronous];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self downloadData];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
}
// 上传
- (void)synchronous {
    // 获取用户名
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    // 查询本地数据
     // 寻找本用户日记及无用户数据
    NSArray *synArr = [[GetDataTools shareGetDataTool] selectDataWithUserName:name];
   
    if (name == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请先登录!!!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissWithClickedButtonIndex:0 animated:YES];
        });
    }else {
        UIActivityIndicatorView *inview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        inview.frame = CGRectMake(150, 300, 50, 50);
        [self.view addSubview:inview];
        [inview startAnimating];
               
        // 删除数据库中相同数据
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            AVQuery *query = [AVQuery queryWithClassName:@"Diary"];
            [query whereKey:@"userName" equalTo:[Md5 md5:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    for (DayNote *temp in synArr) {
                        // 加密日记内容
                        NSData *bodyStr = [temp.diaryBody dataUsingEncoding:NSUTF8StringEncoding];
                        NSData *bodyData = [bodyStr aes256_encrypt:DEKEY];
                        
                        NSData *data;
                        if (temp.diaryImage == nil || [UIImage imageNamed:[[FileManagerTools shareFileManager] getImagePathWithName:temp.diaryImage]] == nil) {
                            data = [NSData data];
                        }else {
                            data = UIImagePNGRepresentation([UIImage imageNamed:[[FileManagerTools shareFileManager] getImagePathWithName:temp.diaryImage]]);
                        }

                        int i = 0;
                        for (AVObject *obj in objects) {
                            NSString *objStr = [[ConversionWithDate shareDateConversion] getStringWithDate:obj[@"localData"][@"contentDate"] type:GZWDateFormatTypeConnector];
                            NSLog(@"%@", objStr);
                            NSString *tempStr = [[ConversionWithDate shareDateConversion] getStringWithDate:temp.contentDate type:GZWDateFormatTypeConnector];
                            NSLog(@"%@", tempStr);
                            if ([objStr isEqualToString:tempStr]) {
                                AVObject *post = [AVObject objectWithoutDataWithClassName:@"Diary" objectId:obj[@"objectId"]];
                                [post setObject:bodyData forKey:@"diaryBody"];
                                [post setObject:data forKey:@"diaryImage"];
                                [post save];
                                i = 1;
                                continue;
                            }
                        }
                        if (i == 0) {// 如果一个都没有
                            // 上传数据
                            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[Md5 md5:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]],@"userName",temp.contentDate,@"contentDate",temp.createDate,@"createDate",temp.mood,@"mood",temp.weather,@"weather",nil];
                            
                            [dict setObject:bodyData forKey:@"diaryBody"];
                            [dict setObject:data forKey:@"diaryImage"];
                            [dict setObject:temp.moodImage forKey:@"moodImage"];
                            [dict setObject:temp.weatherImage forKey:@"weatherImage"];
                            NSLog(@"%@", dict);
                            AVObject *object = [AVObject objectWithClassName:@"Diary" dictionary:dict];
                            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                if (!error) {
                                    
                                }else {
                                    NSLog(@"fails");
                                }
                            }];
                        }
                    }
                    [TSMessage showNotificationWithTitle:@"同步上传完成!" type:TSMessageNotificationTypeSuccess];
                    [inview stopAnimating];
                }
            }];    
        });
    }
    [[GetDataTools shareGetDataTool] updateALLDataUserNameWithDict:@{@"userName":name}];                 
}
// 下载
- (void)downloadData {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] != nil) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [TSMessage showNotificationWithTitle:@"正在下载中..." 
                                        subtitle:nil 
                                            type:TSMessageNotificationTypeWarning];
        });

        AVQuery *query = [AVQuery queryWithClassName:@"Diary"];
        [query whereKey:@"userName" equalTo:[Md5 md5:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                [[GetDataTools shareGetDataTool] deleteDataWithUserName:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]];
        
                for (NSDictionary *dict in objects) {
                    
                    NSString *imageName = [NSString stringWithFormat:@"DI_%@.jpg", [[ConversionWithDate shareDateConversion] getStringWithDate:[NSDate date] type:GZWDateFormatTypeDateTime]];
                    NSLog(@"%@", dict[@"diaryBody"]);
                    NSLog(@"%@", [dict[@"diaryBody"] aes256_decrypt:[Md5 md5:@"blcl"]]);
                    NSString *bodyDiary = [[NSString alloc] initWithData:[dict[@"diaryBody"] aes256_decrypt:DEKEY] encoding:NSUTF8StringEncoding];
                    [[FileManagerTools shareFileManager] saveImage:[UIImage imageWithData:dict[@"diaryImage"]] WithName:imageName];
                    [[GetDataTools shareGetDataTool] addDiaryForContentDate:dict[@"contentDate"]
                                                                     Create:dict[@"createDate"]
                                                                    Details:bodyDiary 
                                                                    Weather:dict[@"weather"] 
                                                               WeatherImage:dict[@"weatherImage"] 
                                                                       Mood:dict[@"mood"] 
                                                                  MoodImage:[dict[@"moodImage"] integerValue]  
                                                                 DiaryImage:imageName 
                                                                   userName:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]];
                }
               
                [TSMessage showNotificationWithTitle:@"同步下载完成" type:TSMessageNotificationTypeSuccess];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadView" object:nil];
            }
        }]; 
      }
    });
    
}

#pragma mark  关于我们
- (void)p_about
{
    [self showPopupWithStyle:CNPPopupStyleFullscreen];
}

#pragma mark  清除缓存
- (void)p_setAlert
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认清除缓存？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
            NSLog(@"%@", cachPath);
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
            NSLog(@"files :%lu",(unsigned long)files.count);
            for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
        self.label.text = [NSString stringWithFormat:@"文件: %d",0];
    }
    
}

- (void)clearCacheSuccess {
    
}

#pragma mark  关于我们  demo显示
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"About" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:@"1.0.0" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    UIImage *icon = [UIImage imageNamed:@"悠悠记"];
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:@"---悠悠记团队" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"返回" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupController *popupController = [[CNPPopupController alloc] initWithTitle:title contents:@[lineOne,icon,lineTwo] buttonTitles:@[buttonTitle] destructiveButtonTitle:nil];
    popupController.theme = [CNPPopupTheme defaultTheme];
    popupController.theme.popupStyle = popupStyle;
    popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromTop;
    popupController.theme.dismissesOppositeDirection = YES;
    popupController.delegate = self;
    [popupController presentPopupControllerAnimated:YES];
    
}

@end
