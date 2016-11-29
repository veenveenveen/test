//
//  UIImage+CircleImage.m
//  test
//
//  Created by 黄启明 on 2016/11/21.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

- (instancetype)circleImage {
    //获取上下文
    UIGraphicsBeginImageContext(self.size);
    //上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //添加一个圈
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.width);
    CGContextAddEllipseInRect(context, rect);
    //裁剪
    CGContextClip(context);
    //画在上下文
    [self drawInRect:rect];
    //获取新图片
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return newImg;
}

+ (instancetype)circleImageWith:(NSString *)name {
    return [[self imageNamed:name] circleImage];
}

@end
