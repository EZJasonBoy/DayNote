//
//  AddDiaryViewController.m
//  DayNote
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 郭兆伟. All rights reserved.
//

#import "AddDiaryViewController.h"

@interface AddDiaryViewController () <AddDiaryViewDelegate,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) AddDiaryView *writeDiary;
@property (nonatomic, strong) NSDictionary *weatherDict;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) NSInteger currentTag;
@property (nonatomic, strong) NSDate *createDate;

@end

@implementation AddDiaryViewController

- (void)loadView {
    self.writeDiary = [[AddDiaryView alloc] initWithFrame:CGRectMake(0, 20, 375, 647)];
    self.view = _writeDiary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.writeDiary.backgroundColor = [UIColor whiteColor];
    self.writeDiary.delegate = self;
    self.writeDiary.editPage.delegate = self;
    
    self.writeDiary.moodSmaile.titleLabel.text = @"高兴";
    self.writeDiary.moodCry.titleLabel.text = @"难过";
    self.writeDiary.moodFlat.titleLabel.text = @"平淡";
    
    [self setUI]; 
    
    [self.writeDiary.toolBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    
}

- (void)setUI {
    if (self.type == ADDTYPEInsert) {
        [self setNetInfo];
    }else {
        [self setLocalInfo];
    }
}
// 请求网络数据(新写)
- (void)setNetInfo {
    
//    [[RequestWeatherTools shareRequestWeather] getWeatherDetailsWithCity:@"beijing" Weather:^(NSDictionary *dict) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.weatherDict = dict;
//            self.writeDiary.weatherShow.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dict[@"code"]]];
//            self.writeDiary.weatherText.text = [NSString stringWithFormat:@"%@", dict[@"txt"]];
//        });
//    }];
    self.createDate = [NSDate date];
    self.writeDiary.datelabel.text  = [[ConversionWithDate shareDateConversion] getStringWithDate:self.createDate type:GZWDateFormatTypePoint];
    
    self.writeDiary.editPage.text = @"";
    
    self.currentTag = self.writeDiary.moodSmaile.tag;
    
}
// 获取已有数据(过去的)
- (void)setLocalInfo {
    
    DayNote *info = [[GetDataTools shareGetDataTool] selectDataWithIndex:self.index][0];
    
    self.writeDiary.weatherShow.image = [UIImage imageNamed:info.weatherImage];
    self.writeDiary.weatherText.text = info.weather;
    
    self.writeDiary.datelabel.text = [[ConversionWithDate shareDateConversion] getStringWithDate:info.contentDate type:GZWDateFormatTypePoint];
    
    self.writeDiary.editPage.text = info.diaryBody;
    
    self.writeDiary.myImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [[FileManagerTools shareFileManager] getImagePathWithName:info.diaryImage]]];
    
    self.writeDiary.moodText.text = info.mood;
    
    [self.writeDiary.backGroundView bringSubviewToFront:[self.writeDiary.backGroundView viewWithTag:[info.moodImage integerValue]]];
    self.currentTag = [info.moodImage integerValue];
    
    self.createDate = info.createDate;
}


- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDismiss:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardAppear:(NSNotification *)notification {
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.writeDiary.toolBar.frame = CGRectMake(0, keyboardRect.origin.y-64, CGRectGetWidth(keyboardRect), 44); 
    }];
    
}
- (void)keyboardDismiss:(NSNotification *)notification {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.writeDiary.toolBar.frame = CGRectMake(0, CGRectGetMaxY(self.writeDiary.frame)-64, CGRectGetWidth(self.writeDiary.frame), 44); 
    }];
    
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.contentSize.height >= 300) {
        NSUInteger length = textView.text.length;
        textView.selectedRange = NSMakeRange(length-2, 0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - addDiary delegate

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
            [[GetDataTools shareGetDataTool] addDiaryForContentDate:self.createDate 
                                                             Create:self.createDate 
                                                            Details:self.writeDiary.editPage.text 
                                                            Weather:self.weatherDict[@"txt"] 
                                                       WeatherImage:self.weatherDict[@"code"]
                                                               Mood:self.writeDiary.moodText.text
                                                          MoodImage:self.currentTag
                                                          DiaryImage:self.imageName];
        }
        
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)recording:(UIBarButtonItem *)sender {
    static BOOL isRecord = NO;
    if (isRecord == NO) {
        // 开始录音
        sender.image = [UIImage imageNamed:@"sound_recorder"];
    }else {
        // 停止录音
        sender.image = [UIImage imageNamed:@"sound.png"];
    }
    isRecord = !isRecord;
}

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

- (void)choosePhotos{
    
    UIAlertView *chooseType = [[UIAlertView alloc]initWithTitle:@"选择来源" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相册",@"拍照", nil];
    [chooseType show];
    
}

- (void)chooseMood:(UIButton *)sender {
    if (self.writeDiary.moodSmaile.center.y == self.writeDiary.moodCry.center.y) {
        
        [UIView animateWithDuration:0.55 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGPoint center = self.writeDiary.moodCry.center;
            center.y += 100;
            self.writeDiary.moodCry.center = center;
            
            CGPoint center1 = self.writeDiary.moodFlat.center;
            center1.y += 50;
            self.writeDiary.moodFlat.center = center1;
            
        } completion:nil];
    }else {
        [UIView animateWithDuration:0.1 animations:^{
            
            CGPoint center = self.writeDiary.moodCry.center;
            center.y -= 100;
            self.writeDiary.moodCry.center = center;
            
            CGPoint center1 = self.writeDiary.moodFlat.center;
            center1.y -= 50;
            self.writeDiary.moodFlat.center = center1;
            
            [self.writeDiary.backGroundView bringSubviewToFront:sender];
            self.writeDiary.moodText.text = sender.titleLabel.text;
            
            self.currentTag = sender.tag;
        } completion:nil];
    }
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
    
    NSLog(@"success");
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

// 缩放图片
- (UIImage *)imageWithImageSimple:(UIImage *)image scaleToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *imageTemp = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageTemp;
}

@end
