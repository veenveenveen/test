//
//  main.c
//  test
//
//  Created by 黄启明 on 2016/11/10.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#include <stdio.h>

#import <Foundation/Foundation.h>

typedef NSString *(^MyBlock)(NSString *str);

int main(int argc, const char * argv[]) {
    
    
    printf("Hello, World!\n");
    printf("%d\n",UINT8_MAX);
    
    __block int a = 0;
    void (^blo)() = ^{
        printf("%d\n",a);
    };
    blo();
    a = 20;
    blo();
    
    MyBlock block1 = ^(NSString *str) {
        NSLog(@"%@",str);
        return @"hello";
    };
    
    NSString *str = block1(@"hello world");
    NSLog(@"%@",str);
    
    return 0;
}

