//
//  ViewController.m
//  抽屉效果
//
//  Created by 黄启明 on 2016/11/17.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import "ViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIViewController *leftDrawer;
@property (nonatomic, strong) UIViewController *center;
@property (nonatomic, strong) UIViewController *rightDrawer;
@property (nonatomic, strong) MMDrawerController *drawerController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _leftDrawer = [[UIViewController alloc] init];
    _leftDrawer.view.backgroundColor = [UIColor redColor];
    _center = [[UIViewController alloc] init];
    _center.view.backgroundColor = [UIColor blueColor];
    _rightDrawer = [[UIViewController alloc] init];
    _rightDrawer.view.backgroundColor = [UIColor orangeColor];
    [self setupLeftMenuButton];
    [self setupRightMenuButton];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    self.button.backgroundColor = [UIColor orangeColor];
    [self.button setTitle:@"跳转" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.center.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)setupRightMenuButton{
    MMDrawerBarButtonItem * rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    [self.center.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
}


- (void)change {
    
    UIColor * barColor = [UIColor
                          colorWithRed:247.0/255.0
                          green:249.0/255.0
                          blue:250.0/255.0
                          alpha:1.0];
    [self.center.navigationController.navigationBar setBarTintColor:barColor];
    
    
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.center];
    
    _drawerController = [[MMDrawerController alloc]
                         initWithCenterViewController:nav
                         leftDrawerViewController:self.leftDrawer
                         rightDrawerViewController:self.rightDrawer];
    
    
    self.drawerController.maximumLeftDrawerWidth = 200;
    self.drawerController.maximumRightDrawerWidth = 200;
    
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self presentViewController:self.drawerController animated:YES completion:nil];
    
}

-(void)leftDrawerButtonPress:(id)sender{

    [self.center.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    NSLog(@"left");
}

-(void)rightDrawerButtonPress:(id)sender{
    [self.center.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    NSLog(@"right");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
