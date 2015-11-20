//
//  AboutUsViewController.m
//  YewNoteMe
//
//  Created by youyou on 15/10/21.
//  Copyright (c) 2015年 刘晓阳. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UIImageView *myImage;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_setView];
    // Do any additional setup after loading the view.
}

- (void)p_setView
{
    self.myImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.myImage.image = [UIImage imageNamed:@"6.jpg"];
    [self.view addSubview:_myImage];
    
    // self.myImage.contentMode =  UIViewContentModeScaleAspectFill;
    
    [self.myImage setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.myImage.contentMode =  UIViewContentModeScaleAspectFill;
    self.myImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.myImage.clipsToBounds  = YES;
    
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 500, 70, 30)];
    self.label1.text = @"1.0.0";
    [self.view addSubview:_label1];
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.label1.frame), CGRectGetMaxY(self.label1.frame), 200, CGRectGetHeight(self.label1.frame))];
    self.label2.text = @"---- yesNote团队";
    [self.view addSubview:_label2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
