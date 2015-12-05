#import "CalendarViewController.h"
#import "CalendarView.h"

@interface CalendarViewController ()<CalendarDelegate>
@property (nonatomic,strong) CalendarView *calendar;
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) NSString *currentDiary;
@property (nonatomic, strong) NSDate *selectDate;

@end

@implementation CalendarViewController


- (id)init {
    self = [super init];
    if (self) {
        self.calendar = [[CalendarView alloc] initWithStartDay:startMonday];
        self.calendar.delegate = self;
        self.calendar.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*10/375, [UIScreen mainScreen].bounds.size.height*10/667, CGRectGetWidth([[UIScreen mainScreen]bounds]) - [UIScreen mainScreen].bounds.size.width*20/375, [UIScreen mainScreen].bounds.size.height*300/667);
        [self.view addSubview:_calendar];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*10/375, CGRectGetHeight(self.calendar.frame)+[UIScreen mainScreen].bounds.size.height*30/667, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(self.view.frame)-CGRectGetHeight(self.calendar.frame)-[UIScreen mainScreen].bounds.size.height*160/667)];
    self.scroll.scrollEnabled = YES;
    self.scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scroll];
    
    self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]) - [UIScreen mainScreen].bounds.size.height*20/667, CGRectGetHeight(self.view.frame)-CGRectGetHeight(self.calendar.frame)-[UIScreen mainScreen].bounds.size.height*160/667)];
    self.myLabel.backgroundColor = [UIColor whiteColor];
    self.myLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.myLabel.numberOfLines = 0;
    
    [self.scroll addSubview:_myLabel];
	self.selectDate = [NSDate date];
    [self.calendar addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    self.myLabel.text = [[GetDataTools shareGetDataTool] selectDataWithDate:[NSDate date]].diaryBody;
    CGRect frame = self.myLabel.frame;
    [self.myLabel sizeToFit];
    frame.size.height = self.myLabel.frame.size.height;
    self.myLabel.frame = frame;
    self.scroll.contentSize = CGSizeMake(CGRectGetWidth(self.myLabel.frame), CGRectGetHeight(self.myLabel.frame));
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"navigation" object:nil userInfo:@{@"pageIndex":@"1"}];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:@"reloadView" object:nil];
}

//  监听frame,使scroll的y和calendar一起变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        CGRect frame = self.scroll.frame;
        frame.origin.y = self.calendar.frame.size.height + 30;
        self.scroll.frame = frame;
    }
    
}

// 登陆后刷新数据
- (void)refreshData:(NSNotification *)sender {
    [self viewWillAppear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)calendar:(CalendarView *)calendar didSelectDate:(NSDate *)date {
    self.currentDiary = [[GetDataTools shareGetDataTool] selectDataWithDate:date].diaryBody;
    self.selectDate = date;
    if (self.currentDiary != nil) {
        self.myLabel.text = self.currentDiary;
    }else {
        self.myLabel.text = @"😊您在这一天什么都没写哟...😊";
    }
    [self.myLabel sizeToFit];
    CGRect frame = self.myLabel.frame;
    frame.size.width = [UIScreen mainScreen].bounds.size.width-15;
    frame.size.height = self.myLabel.frame.size.height;
    self.myLabel.frame = frame;
    
}

// 写日记
- (void)extraRightItemDidPress {
    if ([self.selectDate compare:[NSDate date]] == NSOrderedDescending) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你还没有穿越到未来,不能在这一天写日记哦！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return; 
    }
    
    AddDiaryViewController *addDiary = [[AddDiaryViewController alloc] init];
    addDiary.type = ADDTYPEWriteUp;// 选择补写
    addDiary.contentDate = self.selectDate;
    [self presentViewController:addDiary animated:YES completion:nil];
//    [self.navigationController setHidesBottomBarWhenPushed:NO];
}

@end