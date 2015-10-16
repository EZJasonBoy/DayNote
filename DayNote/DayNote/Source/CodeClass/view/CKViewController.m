#import "CKViewController.h"
#import "CKCalendarView.h"

@interface CKViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mytable;

@end

@implementation CKViewController


- (id)init {
    self = [super init];
    if (self) {
        CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
        calendar.frame = CGRectMake(10, 70, CGRectGetWidth([[UIScreen mainScreen]bounds]) - 20, 300);
        [self.view addSubview:calendar];
        self.view.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"123===");
    
    self.mytable = [[UITableView alloc]initWithFrame:CGRectMake(10, 450, CGRectGetWidth([[UIScreen mainScreen]bounds]) - 20, 200)];
        [self.view addSubview:_mytable];
    [self.mytable registerClass:[NoteTableViewCell class] forCellReuseIdentifier:@"cell"];
  
#pragma mark 去掉 tableview 头部空白区域
    //  去掉 tableview 头部空白区域 =============*************************==================  //
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.mytable.delegate = self;
    self.mytable.dataSource = self;
    self.mytable.sectionHeaderHeight = 22;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //  LeanCloud 保存数据 
//    AVObject *post = [AVObject objectWithClassName:@"Post"];
//    [post setObject:@"每个 Objective-C 程序员必备的 8 个开发工具" forKey:@"content"];
//    [post setObject:@"LeanCloud官方客服" forKey:@"pubUser"];
//    [post setObject:[NSNumber numberWithInt:1435541999] forKey:@"pubTimestamp"];
//    [post save];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark  table 
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
    
    NoteTableViewCell *cell = [self.mytable dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    cell.textLabel.text = @"123";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end