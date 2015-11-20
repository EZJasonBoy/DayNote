//
//  AddDiaryViewController.m
//  DayNote
//
//  Created by boluchuling on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "AddDiaryViewController.h"
#import "iflyMSC/IFlyRecognizerViewDelegate.h"  
#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechError.h"

@interface AddDiaryViewController () <AddDiaryViewDelegate,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, IFlyRecognizerViewDelegate>

@property (nonatomic, strong) AddDiaryView *writeDiary;
@property (nonatomic, strong) NSDictionary *weatherDict;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) NSInteger currentTag;
@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic, strong) NSString *weatherImage;
@property (nonatomic, strong) IFlyRecognizerView *voiceView;

@end

@implementation AddDiaryViewController

- (void)loadView {
    self.writeDiary = [[AddDiaryView alloc] initWithFrame:CGRectMake(0, 20, 375, 647)];
    self.view = _writeDiary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.writeDiary.backgroundColor = [UIColor whiteColor];
    self.writeDiary.delegate = self;
    self.writeDiary.editPage.delegate = self;
    
    
    self.writeDiary.moodCry.titleLabel.text = @"难过";
    self.writeDiary.moodFlat.titleLabel.text = @"平淡";
    self.writeDiary.moodSmaile.titleLabel.text = @"高兴";
    
    [self setUI]; 
     self.writeDiary.myImage.image = nil;
    [self.writeDiary.toolBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 填充界面
- (void)setUI {
    // 如果新写就请求网络数据(天气) 否则查询本地数据库
    if (self.type == ADDTYPEAdditional) {
        [self setLocalInfo];
    }else { 
        if (self.type == ADDTYPEInsert) {
            [[LocationTools shareLocation] initializePositioning];
            [[LocationTools shareLocation] locationStart];
            
            self.weatherImage = @"999";
            self.writeDiary.weatherShow.image = [UIImage imageNamed:@"999"];
            self.writeDiary.weatherText.text = @"未知";

            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeWeather:) name:@"local" object:nil];

            [self setNetInfo];
        }else {
            [self setOldInfo];
        }
        
    }
}

- (void)changeWeather:(NSNotification *)notification {
    NSString *str = notification.userInfo[@"city"];
    NSLog(@"%@", str);
    if ([self isChinese:str]) {
        str = [str substringToIndex:[str rangeOfString:@"市"].location];
    }

    [[RequestWeatherTools shareRequestWeather] getWeatherDetailsWithCity:str Weather:^(NSDictionary *dict) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", dict);
            self.weatherDict = dict;
            self.weatherImage = dict[@"code"];
            self.writeDiary.weatherShow.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dict[@"code"]]];
            self.writeDiary.weatherText.text = [NSString stringWithFormat:@"%@", dict[@"txt"]];
            if (self.weatherImage == nil) {
                self.weatherImage = @"999";
                self.writeDiary.weatherShow.image = [UIImage imageNamed:@"999"];
                self.writeDiary.weatherText.text = @"未知";
            }
        });
    }];
}
// 请求网络数据(新建)
- (void)setNetInfo {
       
        
    self.createDate = [NSDate date];
    self.writeDiary.datelabel.text  = [[ConversionWithDate shareDateConversion] getStringWithDate:self.contentDate 
                                                                                             type:GZWDateFormatTypePoint];
    
    self.writeDiary.editPage.text = @"";
    
    self.currentTag = self.writeDiary.moodSmaile.tag;
    
}

- (void)setOldInfo {
    if ([[GetDataTools shareGetDataTool] selectDataWithDate:self.contentDate].contentDate != nil) {
        [self setLocalInfo];
    }else {
        self.weatherImage = @"999";
        self.writeDiary.weatherShow.image = [UIImage imageNamed:@"999"];
        self.writeDiary.weatherText.text = @"未知";
        [self setNetInfo];
    }
}
// 获取已有数据(过去的)
- (void)setLocalInfo {
    // 通过上一页面传递过来的索引获取数据
    DayNote *info = [[GetDataTools shareGetDataTool] selectDataWithDate:self.contentDate];
    
    self.weatherImage = info.weatherImage;
    
    self.writeDiary.weatherShow.image = [UIImage imageNamed:info.weatherImage];
    self.writeDiary.weatherText.text = info.weather;
    
    self.writeDiary.datelabel.text = [[ConversionWithDate shareDateConversion] getStringWithDate:info.contentDate type:GZWDateFormatTypePoint];
    
    self.writeDiary.editPage.text = info.diaryBody;
    [self.writeDiary.editPage scrollRectToVisible:CGRectMake(0, self.writeDiary.editPage.contentSize.height-15, self.writeDiary.editPage.contentSize.width, 10) animated:YES];
    
    self.writeDiary.myImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [[FileManagerTools shareFileManager] getImagePathWithName:info.diaryImage]]];
    
    self.writeDiary.moodText.text = info.mood;
    
    [self.writeDiary.backGroundView bringSubviewToFront:[self.writeDiary.backGroundView viewWithTag:[info.moodImage integerValue]]];
    self.writeDiary.moodCry.userInteractionEnabled = NO;
    self.writeDiary.moodFlat.userInteractionEnabled = NO;
    self.writeDiary.moodSmaile.userInteractionEnabled = NO;
    self.currentTag = [info.moodImage integerValue];
    
    self.createDate = info.createDate;
}

#pragma mark - 监听键盘事件
- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDismiss:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardAppear:(NSNotification *)notification {
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.writeDiary.toolBar.frame = CGRectMake(0, keyboardRect.origin.y-64, CGRectGetWidth(keyboardRect), [UIScreen mainScreen].bounds.size.height*44/667); 
    }];
    
}
- (void)keyboardDismiss:(NSNotification *)notification {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.writeDiary.toolBar.frame = CGRectMake(0, CGRectGetMaxY([UIScreen mainScreen].bounds)-[UIScreen mainScreen].bounds.size.height*64/667, CGRectGetWidth([UIScreen mainScreen].bounds), [UIScreen mainScreen].bounds.size.height*44/667); 
    }];
    
}
// text增加,相应变大
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.contentSize.height >= 300) {
        NSUInteger length = textView.text.length;
        textView.selectedRange = NSMakeRange(length-2, 0);
    }
}



#pragma mark - addDiary delegate
// 确定
- (void)backToView:(BOOL)isOK {
    
    if (isOK) {
        if (self.writeDiary.moodText.text == nil) {
            UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"您还没有选择心情哦!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [v show];
            return;
        }
        if (self.type == ADDTYPEAdditional) {
            [[GetDataTools shareGetDataTool] updateDataWithCreateDate:self.createDate ForDetails:self.writeDiary.editPage.text ForImage:self.imageName];
        }else {
            [[GetDataTools shareGetDataTool] addDiaryForContentDate:self.contentDate 
                                                             Create:self.createDate 
                                                            Details:self.writeDiary.editPage.text 
                                                            Weather:self.writeDiary.weatherText.text 
                                                       WeatherImage:self.weatherImage
                                                               Mood:self.writeDiary.moodText.text
                                                          MoodImage:self.currentTag
                                                         DiaryImage:self.imageName
                                                           userName:nil];
        }
        
    }
    
    self.navigationController.navigationBar.hidden = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 录音
- (void)recording:(UIBarButtonItem *)sender {
    // 开始录音
    sender.image = [UIImage imageNamed:@"sound_recorder"];
        
    [self startrecord];
}

- (void)startrecord {

    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)]) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (granted) {
                self.voiceView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
                self.voiceView.delegate = self;
                [self.voiceView setParameter:@"1" forKey:@"audio_source"];
                [self.voiceView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
                //设置听写结果格式为json
                [self.voiceView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
                
                [self.voiceView start];
            }else {
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"检测到未开放麦克风权限,请到设置->隐私->麦克风中打开" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [view show];
            }
        }];
    }
}

- (void)onError:(IFlySpeechError *)error {
    ((UIBarButtonItem *)self.writeDiary.toolBar.items[5]).image = [UIImage imageNamed:@"sound.png"];
    
    NSLog(@"errorCode:%d",[error errorCode]);
}

- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast {
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
   
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    self.writeDiary.editPage.text = [self.writeDiary.editPage.text stringByAppendingString:result];
    
    if (isLast) {
        [self.voiceView cancel];
        ((UIBarButtonItem *)self.writeDiary.toolBar.items[5]).image = [UIImage imageNamed:@"sound.png"];
    }
}

// 字体大小
- (void)zoomInOrOutFont:(BOOL)isReduce {
    if (isReduce == NO) {
        // 缩小
    
        CGFloat size = self.writeDiary.editPage.font.pointSize;
        
        self.writeDiary.editPage.font = [UIFont systemFontOfSize:size-1];
        
    }else {
        // 放大
        CGFloat size = self.writeDiary.editPage.font.pointSize;
        
        self.writeDiary.editPage.font = [UIFont systemFontOfSize:size+1];
    }
}

// 选择照片
- (void)choosePhotos{
    
    UIAlertView *chooseType = [[UIAlertView alloc]initWithTitle:@"选择来源" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相册",@"拍照", nil];
    [chooseType show];
    
}

// 选择心情
- (void)chooseMood:(UIButton *)sender {
    if (self.writeDiary.moodSmaile.center.y == self.writeDiary.moodCry.center.y) {
        
        [UIView animateWithDuration:0.55 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGPoint center = self.writeDiary.moodCry.center;
            center.y += [UIScreen mainScreen].bounds.size.height*100/667;
            self.writeDiary.moodCry.center = center;
            
            CGPoint center1 = self.writeDiary.moodFlat.center;
            center1.y += [UIScreen mainScreen].bounds.size.height*50/667;
            self.writeDiary.moodFlat.center = center1;
            
        } completion:nil];
    }else {
        [UIView animateWithDuration:0.1 animations:^{
            
            CGPoint center = self.writeDiary.moodCry.center;
            center.y -= [UIScreen mainScreen].bounds.size.height*100/667;
            self.writeDiary.moodCry.center = center;
            
            CGPoint center1 = self.writeDiary.moodFlat.center;
            center1.y -= [UIScreen mainScreen].bounds.size.height*50/667;
            self.writeDiary.moodFlat.center = center1;
            
            [self.writeDiary.backGroundView bringSubviewToFront:sender];
            self.writeDiary.moodText.text = sender.titleLabel.text;
            
            self.currentTag = sender.tag;
        } completion:nil];
    }
}

- (BOOL)isChinese:(NSString *)aString {
    int strLength = 0;
    int b = (int)[aString length];
    char *p = (char *)[aString cStringUsingEncoding:NSUnicodeStringEncoding];
    int a = (int)[aString lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < a; i++) {
        if (*p) {
            p++;
            strLength++;
        }else {
            p++;
        }
    }
    NSLog(@"%d", strLength);
    NSLog(@"%d", b);
    if (b == 0 || strLength/b == 1) {
        return NO;
    }else {
        return YES;
    }
//    return ((strLength/b)==1) ? NO : YES;
    
}
#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    }else if (buttonIndex == 1) {
        [self choosePhotoWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }else {
        [self choosePhotoWithType:UIImagePickerControllerSourceTypeCamera];
    }
}

- (void)choosePhotoWithType:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if (type == UIImagePickerControllerSourceTypeCamera) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = type;
            [self presentViewController:picker 
                               animated:YES 
                             completion:nil];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"未找到摄像头!!!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
         
    }
    if (type == UIImagePickerControllerSourceTypePhotoLibrary) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            picker.sourceType = type;
            [self presentViewController:picker 
                               animated:YES 
                             completion:nil];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没有相册访问权限!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
    }

}


#pragma mark - UIImagePickerController delegate

- (void)imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo {
    if (paramError == nil) {
        NSLog(@"save success");
    }else {
        NSLog(@"save fails");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *tempImage;

    if ([picker allowsEditing]) {
        tempImage = [info objectForKey:UIImagePickerControllerEditedImage];
    }else {
        tempImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
         SEL selectToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
        UIImageWriteToSavedPhotosAlbum(tempImage, self, selectToCall,NULL);
    }
    
    self.imageName = [NSString stringWithFormat:@"DI_%@.jpg", [[ConversionWithDate shareDateConversion] getStringWithDate:[NSDate date] type:GZWDateFormatTypeDateTime]];

    [[FileManagerTools shareFileManager] saveImage:tempImage WithName:self.imageName];
    self.writeDiary.myImage.image = tempImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
