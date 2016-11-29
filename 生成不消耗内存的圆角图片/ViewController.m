//
//  ViewController.m
//  生成不消耗内存的圆角图片
//
//  Created by 黄启明 on 2016/11/21.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+CircleImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    UIImage *image = [UIImage circleImageWith:@"bbb.jpg"];
    imgView.image = image;
    imgView.contentMode = UIViewContentModeScaleAspectFit   ;
    [self.view addSubview:imgView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
