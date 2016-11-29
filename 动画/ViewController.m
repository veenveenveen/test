//
//  ViewController.m
//  动画
//
//  Created by 黄启明 on 2016/11/21.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import "ViewController.h"

#define angle2Radion(angle) (angle / 180.0 * M_PI)

@interface ViewController ()

@property (nonatomic, strong) UIView *view1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view1 = [[UIView alloc] init];
    self.view1.frame = CGRectMake(0, 20, 40, 40);
    self.view1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.view1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self startAnim4];
}
//透明度 CABasicAnimation
- (void)startAnim1 {
    CABasicAnimation *ani = [[CABasicAnimation alloc] init];
    ani.keyPath = @"opacity";
    ani.fromValue = @1;
    ani.toValue = @0;
    ani.duration = 2.0;
    ani.repeatCount = 1;
    [self.view1.layer addAnimation:ani forKey:nil];
}
//按照路径移动 CAKeyframeAnimation
- (void)startAnim2 {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view1.center radius:20 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    anim.path = path.CGPath;
    anim.duration = 2.0;
    anim.repeatCount = 3;
    [self.view1.layer addAnimation:anim forKey:nil];
}
//抖动 CAKeyframeAnimation
- (void)startAnim3 {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@angle2Radion(-5),@angle2Radion(0),@angle2Radion(5),@angle2Radion(0),@angle2Radion(-5)];
    anim.duration = 0.5;
    anim.repeatCount = MAXFLOAT;
    [self.view1.layer addAnimation:anim forKey:nil];
}

#pragma mark -

//动画组
- (void)startAnim4 {
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CAKeyframeAnimation *ani = [[CAKeyframeAnimation alloc] init];
    ani.keyPath = @"opacity";
    ani.values = @[@1,@0.5,@0,@0.5,@1];
    ani.duration = 2.0;
    ani.repeatCount = 1;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view1.center radius:20 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    anim.path = path.CGPath;
    anim.duration = 2.0;
    anim.repeatCount = 3;
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animation];
    anima.keyPath = @"transform.rotation";
    anima.values = @[@angle2Radion(-5),@angle2Radion(0),@angle2Radion(5),@angle2Radion(0),@angle2Radion(-5)];
    anima.duration = 0.5;
    anima.repeatCount = MAXFLOAT;
    
    group.animations = @[ani,anim,anima];
    group.duration = 2;
    group.repeatCount = MAXFLOAT;
    
    [self.view1.layer addAnimation:group forKey:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
