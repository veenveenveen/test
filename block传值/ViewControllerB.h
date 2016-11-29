//
//  ViewControllerB.h
//  test
//
//  Created by 黄启明 on 2016/11/11.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSString *str,UIColor *color);

@interface ViewControllerB : UIViewController

@property (nonatomic, copy) MyBlock mblock;

@end
