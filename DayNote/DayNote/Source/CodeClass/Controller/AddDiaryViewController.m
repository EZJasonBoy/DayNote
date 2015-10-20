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
@end

@implementation AddDiaryViewController

- (void)loadView {
    self.writeDiary = [[AddDiaryView alloc] initWithFrame:CGRectMake(0, 20, 375, 647)];
    self.view = _writeDiary;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.writeDiary.backgroundColor = [UIColor whiteColor];
    
    self.writeDiary.editPage.delegate = self;
    
    [self.writeDiary.toolBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    self.writeDiary.delegate = self;
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    [self setUI]; 
}


- (void)setUI {
    if (self.type == ADDTYPEInsert) {
        [self setNetInfo];
    }else {
        [self setLocalInfo];
    }
}

- (void)setNetInfo {
    
//    [[RequestWeatherTools shareRequestWeather] getWeatherDetailsWithCity:@"beijing" Weather:^(NSDictionary *dict) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.weatherDict = dict;
//            self.writeDiary.weatherShow.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dict[@"code"]]];
//        });
//    }];
    
    self.writeDiary.datelabel.text  = [[ConversionWithDate shareDateConversion] getStringWithDate:self.contentDate type:GZWDateFormatTypePoint];
    
    self.writeDiary.editPage.text = @"";
    
}

- (void)setLocalInfo {
    
    self.writeDiary.weatherShow.image = [UIImage imageNamed:self.weatherImage];
    self.writeDiary.datelabel.text = [[ConversionWithDate shareDateConversion] getStringWithDate:self.contentDate type:GZWDateFormatTypePoint];
    self.writeDiary.editPage.text = self.diaryText;
//    self.writeDiary.myImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", ,self.diaryImage]];
    
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
        if (self.type == ADDTYPEAdditional) {
            [[GetDataTools shareGetDataTool] updateDataWithCreateDate:self.createDate ForDetails:self.writeDiary.editPage.text];
        }else {
            [[GetDataTools shareGetDataTool] addDiaryForContentDate:self.contentDate 
                                                             Create:[NSDate date] 
                                                            Details:self.writeDiary.editPage.text 
                                                            Weather:self.weatherDict[@"txt"] 
                                                       WeatherImage:self.weatherDict[@"code"]
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
    
    self.imageName = [NSString stringWithFormat:@"DI_%@.jpg", [[ConversionWithDate shareDateConversion] getStringWithDate:self.contentDate type:GZWDateFormatTypeDateTime]];

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
