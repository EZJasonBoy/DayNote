//
//  UserInfoViewController.m
//  DayNote
//
//  Created by youyou on 15/10/15.
//  Copyright (c) 2015年 张晓敏. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIActionSheet *myActionSheet;
@property(nonatomic,strong)RestPwdViewController *rvc;
@property(nonatomic,strong)NSString *imageString;
@property(nonatomic,strong)UserInfoView *userInfo;
@property (nonatomic, strong) NSString *userName;
@end
@implementation UserInfoViewController

-(void)loadView
{
    _userInfo = [[UserInfoView alloc]init];
    self.view = _userInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDefaultData];
    [self setValueForView];
    [self setNavigation];
    
}

- (void)setDefaultData {
    self.img =[[UIImage alloc]init];
    
    UIView *gender = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 200)];
    UIButton *m = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(gender.frame), CGRectGetMinY(gender.frame), CGRectGetWidth(gender.frame), CGRectGetHeight(gender.frame)/3)];
    [m setTitle:@"男" forState:UIControlStateNormal];
    [m addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [gender addSubview:m];
    
    UIButton *f = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(m .frame), CGRectGetMaxY(m .frame), CGRectGetWidth(m .frame), CGRectGetHeight(m.frame))];
    [f setTitle:@"女" forState:UIControlStateNormal];
    [f addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [gender addSubview:f];
    
    UIButton *secrecy = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(f.frame), CGRectGetMaxY(f.frame), CGRectGetWidth(f.frame), CGRectGetHeight(f.frame))];
    [secrecy setTitle:@"保密" forState:UIControlStateNormal];
    [secrecy addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [gender addSubview:secrecy];
    self.userInfo.genderText.inputView = gender;
    
    // age ------ Datepiker
    self.userInfo.ageText.delegate = self;
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMaxY(self.view.frame)-BLCLPROPOTIONSCREENHEIGHT*100, CGRectGetWidth(self.view.frame), BLCLPROPOTIONSCREENHEIGHT*100)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.userInfo.ageText.inputView = datePicker;
    

    
    // 
    self.userInfo.SignText.delegate = self;
    self.userInfo.SignText.returnKeyType = UIReturnKeyDone;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddBgImage)];
    [self.userInfo.heardImg addGestureRecognizer:singleTap];
    
    [_userInfo.editBtn addTarget:self action:@selector(EditAction:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.userInfo.genderText resignFirstResponder];
    [self.userInfo.ageText resignFirstResponder];
    [self.userInfo.SignText resignFirstResponder];
    
}

- (void)setNavigation {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor flatBlueColor]] forBarMetrics:UIBarMetricsCompact];
    self.navigationItem.title = @"个人中心";
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setValueForView {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"userName"] != nil) {
        self.userName = [userDefaults objectForKey:@"userName"];
        [self requestUserDataWithUserName:self.userName];
    }
    self.userInfo.UserNameText.userInteractionEnabled = NO;
    
}

-(void)requestUserDataWithUserName:(NSString *)aName {

    AVQuery *query = [AVQuery queryWithClassName:@"Post"];
    [query whereKey:@"username" equalTo:aName];
    self.userInfo.UserNameText.text = self.userName;
    [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        if (error)
        {
            NSLog(@"getFirstObject 请求失败。%@", error);
        }
        else
        {
            
            _userInfo.genderText.text = [object objectForKey:@"gender"];
            _userInfo.SignText.text = [object objectForKey:@"Sign"];
            _userInfo.ageText.text = [object objectForKey:@"age"];
            
            [object[@"attached"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
             {
                 NSLog(@"%@", data);
                 _userInfo.heardImg.image = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]].image;
                 [_userInfo.bgImg setImageToBlur:[UIImage imageWithData:data] blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
                 
             }];
        }
    }];

}

-(void)selectAction:(UIButton *)sender
{
    self.userInfo.genderText.text = sender.titleLabel.text;
    [self.userInfo.genderText resignFirstResponder];
}

//编辑按钮
-(void)EditAction:(UIButton *)sender
{
    //修改数据
    if ([_userInfo.editBtn.titleLabel.text isEqualToString:@"编辑"])
    {
        _userInfo.UserNameText.userInteractionEnabled = YES;
        _userInfo.genderText.userInteractionEnabled = YES;
        _userInfo.ageText.userInteractionEnabled = YES;
        _userInfo.SignText.userInteractionEnabled = YES;
//        _userInfo.UserNameText.borderStyle = UITextBorderStyleRoundedRect;
        _userInfo.genderText.borderStyle = UITextBorderStyleRoundedRect;
        _userInfo.ageText.borderStyle = UITextBorderStyleRoundedRect; 
        _userInfo.SignText.borderStyle = UITextBorderStyleRoundedRect;
        _userInfo.UserNameText.backgroundColor = [UIColor whiteColor];
        _userInfo.genderText.backgroundColor = [UIColor whiteColor];
        _userInfo.ageText.backgroundColor = [UIColor whiteColor];
        _userInfo.SignText.backgroundColor = [UIColor whiteColor];
        
        [_userInfo.editBtn setTitle:@"保存" forState:UIControlStateNormal];
    }
    else if ( [_userInfo.editBtn.titleLabel.text isEqualToString:@"保存"])
    {
        _userInfo.UserNameText.userInteractionEnabled = NO;
//        _userInfo.UserNameText.borderStyle = UITextBorderStyleNone;
        _userInfo.genderText.userInteractionEnabled = NO;
        _userInfo.genderText.borderStyle = UITextBorderStyleNone;    
        _userInfo.ageText.userInteractionEnabled = NO;
        _userInfo.ageText.borderStyle = UITextBorderStyleNone;    
        _userInfo.SignText.userInteractionEnabled = NO;
        _userInfo.SignText.borderStyle = UITextBorderStyleNone;
        _userInfo.UserNameText.backgroundColor = [UIColor clearColor];
        _userInfo.genderText.backgroundColor = [UIColor clearColor];
        _userInfo.ageText.backgroundColor = [UIColor clearColor];
        _userInfo.SignText.backgroundColor = [UIColor clearColor];
        
        AVQuery *query = [AVQuery queryWithClassName:@"Post"];
        
        [query whereKey:@"username" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]];
        [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error)
         {
             if (error) {
                 AVObject *post = [AVObject objectWithClassName:@"Post"];
                 [post setObject:self.string forKey:@"userID"];
                 [post setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]   forKey:@"username"];
                 [post setObject:_userInfo.genderText.text  forKey:@"gender"];
                 [post setObject:_userInfo.SignText.text forKey:@"Sign"];
                 [post setObject:_userInfo.ageText.text forKey:@"age"];

                 [post saveInBackground];
             }else {
                 AVObject *post = [AVObject objectWithoutDataWithClassName:@"Post" objectId:object[@"objectId"]];
                 [post setObject:self.string forKey:@"userID"];
                 [post setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]   forKey:@"username"];
                 [post setObject:_userInfo.genderText.text  forKey:@"gender"];
                 [post setObject:_userInfo.SignText.text forKey:@"Sign"];
                 [post setObject:_userInfo.ageText.text forKey:@"age"];
                 [post saveInBackground];
             }
         }];
        
        [_userInfo.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
}

- (void)dateChanged:(id)sender
{
    UIDatePicker *picker = (UIDatePicker *)sender;
    picker.maximumDate = [NSDate date];
    NSLog(@"%@", picker.maximumDate);
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [formatter stringFromDate:picker.date];
    self.userInfo.ageText.text = dateStr;
   
}
 
//拍照片
-(void)AddBgImage
{
    _myActionSheet =[ [UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开相机",@"从手机相册获取", nil];
    [_myActionSheet showInView:_userInfo.bgImg];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == _myActionSheet.cancelButtonIndex)
    {
        [actionSheet dismissWithClickedButtonIndex:2 animated:YES];
    }
    switch (buttonIndex)
    {
        case 0://打开照相机拍照
            //判断是否支持相机
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                [self takePhoto];
            }
            else
            {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有检测到摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
        case 1://打开本地相册
            [self LocalPhoto];
            break;
        default:
            break;
    } 
}

//打开相机
-(void)takePhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;//设置拍照后图片可被编辑
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
    
}

//本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [UIImage imageWithImageSimple:[info objectForKey:@"UIImagePickerControllerOriginalImage"] scaleToSize:CGSizeMake(150, 150)];
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        _imageString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingFormat:@"/%@_image.png", [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        _filePath = [[NSString alloc]initWithFormat:@"%@/%@_image.png",DocumentsPath,[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]];
        NSLog(@"%@", _filePath);
        [self dismissViewControllerAnimated:YES completion:nil];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(62, 62, 85, 84)];
        imageview.image=image;
        self.userInfo.heardImg.image = image;
        [self.userInfo.bgImg setImageToBlur:image blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:^{
            
        }];
        self.img = image;
        UIProgressView *progress = [[UIProgressView alloc]initWithFrame:CGRectMake(20, 90, 100, 40)];
        CGAffineTransform transform =CGAffineTransformMakeScale(1.0f,2.0f);
        progress.transform = transform;
        progress.progressTintColor = [UIColor blueColor];
        
        [self.userInfo.heardImg addSubview:progress];
        NSData *imageData = UIImagePNGRepresentation(image);
        AVFile *imageFile = [AVFile fileWithName:@"/image.png" data:imageData];
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded)
            {
                [progress setHidden:YES];
            }
            else
            {
                NSLog(@"%@",[error description]);
                
            }
        }
        progressBlock:^(NSInteger percentDone)
         {
             progress.progress = percentDone/100;
             
         }];
        if (self.userInfo.genderText.text == nil&&self.userInfo.ageText.text == nil &&self.userInfo.SignText.text == nil )
        {
            NSLog(@"%@", self.userName);
            AVObject *post1 = [AVObject objectWithClassName:@"Post"];
            [post1 setObject:self.userName  forKey:@"username"];
            [post1 setObject:imageFile forKey:@"attached"];
            [post1 saveInBackground];
        }
        else
        {
        AVQuery *query = [AVQuery queryWithClassName:@"Post"];
       
        [query whereKey:@"username" equalTo:self.userName];
        [query getFirstObjectInBackgroundWithBlock:^(AVObject *object, NSError *error)
         {
             AVObject *post = [AVObject objectWithoutDataWithClassName:@"Post" objectId:object[@"objectId"]];
             [post setObject:imageFile forKey:@"attached"];
             [post saveInBackground];
        }];
        }
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.userInfo.UserNameText.hidden = YES;
        self.userInfo.genderText.hidden = YES;
        self.userInfo.ageText.hidden = YES;
        self.userInfo.SignText.hidden = YES;
        self.userInfo.UserNameLable.hidden = YES;
        self.userInfo.genderLable.hidden = YES;
        self.userInfo.ageLable.hidden = YES;
        self.userInfo.SignLable.hidden = YES;
        
        [self.userInfo.infoScroll viewWithTag:[[[NSString stringWithFormat:@"%ld", (long)textField.tag] substringToIndex:4] integerValue]].hidden = NO;
        textField.hidden = NO;
        
        
        CGPoint center1 = self.userInfo.UserNameText.center;
        CGPoint center2 = self.userInfo.UserNameLable.center;
          
        textField.center = center1;
        [self.userInfo.infoScroll viewWithTag:[[[NSString stringWithFormat:@"%ld", (long)textField.tag] substringToIndex:4] integerValue]].center = center2;
        
        
    } completion:^(BOOL finished) {
        
    }];

    
    return YES;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.userInfo.genderText resignFirstResponder];
    [self.userInfo.ageText resignFirstResponder];
    [self.userInfo.SignText resignFirstResponder];

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.userInfo.UserNameText.hidden = NO;
        self.userInfo.genderText.hidden = NO;
        self.userInfo.ageText.hidden = NO;
        self.userInfo.SignText.hidden = NO;
        self.userInfo.UserNameLable.hidden = NO;
        self.userInfo.genderLable.hidden = NO;
        self.userInfo.ageLable.hidden = NO;
        self.userInfo.SignLable.hidden = NO;
        
        self.userInfo.UserNameLable.frame = CGRectMake(CGRectGetMinX(self.userInfo.bgImg.frame) + 40, 40, 100, 40);
        self.userInfo.UserNameText.frame = CGRectMake(CGRectGetMaxX(self.userInfo.UserNameLable.frame) + 10, CGRectGetMinY(self.userInfo.UserNameLable.frame), CGRectGetWidth([[UIScreen mainScreen] bounds]) - CGRectGetWidth(self.userInfo.UserNameLable.frame) - 100, CGRectGetHeight(self.userInfo.UserNameLable.frame));
       
        
        self.userInfo.genderLable.frame = CGRectMake(CGRectGetMinX(self.userInfo.UserNameLable.frame), CGRectGetMaxY(self.userInfo.UserNameLable.frame) + 20, CGRectGetWidth(self.userInfo.UserNameLable.frame), CGRectGetHeight(self.userInfo.UserNameLable.frame));
        self.userInfo.genderText.frame = CGRectMake(CGRectGetMinX(self.userInfo.UserNameText.frame), CGRectGetMaxY(self.userInfo.UserNameText.frame) + 20, CGRectGetWidth(self.userInfo.UserNameText.frame), CGRectGetHeight(self.userInfo.UserNameText.frame));
       
        
        self.userInfo.ageLable.frame = CGRectMake(CGRectGetMinX(self.userInfo.genderLable.frame), CGRectGetMaxY(self.userInfo.genderLable.frame) + 20, CGRectGetWidth(self.userInfo.genderLable.frame), CGRectGetHeight(self.userInfo.genderLable.frame));
        self.userInfo.ageText.frame = CGRectMake(CGRectGetMinX(self.userInfo.genderText.frame), CGRectGetMaxY(self.userInfo.genderText.frame) + 20, CGRectGetWidth(self.userInfo.genderText.frame), CGRectGetHeight(self.userInfo.genderText.frame));
     
        
        self.userInfo.SignLable.frame = CGRectMake(CGRectGetMinX(self.userInfo.ageLable.frame), CGRectGetMaxY(self.userInfo.ageLable.frame) + 20, CGRectGetWidth(self.userInfo.ageLable.frame), CGRectGetHeight(self.userInfo.ageLable.frame));
        self.userInfo.SignText.frame = CGRectMake(CGRectGetMinX(self.userInfo.ageText.frame), CGRectGetMaxY(self.userInfo.ageText.frame) + 20, CGRectGetWidth(self.userInfo.ageText.frame), CGRectGetHeight(self.userInfo.ageText.frame));
       
 
        
    } completion:^(BOOL finished) {
        
    }];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
