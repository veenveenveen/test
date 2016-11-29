//
//  ViewController.m
//  TEST_OC
//
//  Created by 黄启明 on 2016/11/21.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
//分类
@interface ViewController (Addition)

@property (nonatomic, copy) NSString *name;

@end
//扩展
@interface ViewController ()

@property (nonatomic, assign) int age;

@end

static const void *kName = @"name";

@implementation ViewController


//使用runtime为分类增加属性
- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, kName, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, kName);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"hello";
    self.age = 18;
    NSLog(@"name = %@",self.name);
    NSLog(@"age = %d",self.age);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
