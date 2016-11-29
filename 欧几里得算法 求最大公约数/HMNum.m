//
//  HMNum.m
//  test
//
//  Created by 黄启明 on 2016/11/24.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import "HMNum.h"

@implementation HMNum

+ (NSUInteger)getNumber:(NSUInteger)p and:(NSUInteger)q {
    if (q == 0) {
        return p;
    }
    NSUInteger r = p % q;
    return [self getNumber:q and:r];
}

@end
