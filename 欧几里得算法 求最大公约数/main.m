//
//  main.m
//  欧几里得算法 求最大公约数
//
//  Created by 黄启明 on 2016/11/24.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMNum.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSUInteger m = [HMNum getNumber:252 and:105];
        NSLog(@"最大公约数为 = %lu",(unsigned long)m);
        
    }
    return 0;
}
