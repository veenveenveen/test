//
//  ViewController.m
//  block传值
//
//  Created by 黄启明 on 2016/11/11.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerB.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textA;
@property (nonatomic, strong) ViewControllerB *b;

@end

@implementation ViewController

- (IBAction)ntxtClick:(id)sender {
    __weak ViewController *wself = self;
    
    self.b.mblock = ^(NSString *str,UIColor *color) {
        
        wself.textA.text = str;
        
        wself.view.backgroundColor = color;
    };
    [self presentViewController:self.b animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.b = [[ViewControllerB alloc] initWithNibName:@"ControllerBxib" bundle:nil];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
