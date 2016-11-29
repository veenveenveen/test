//
//  ViewControllerB.m
//  test
//
//  Created by 黄启明 on 2016/11/11.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import "ViewControllerB.h"



@interface ViewControllerB ()

@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation ViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)previousClick:(id)sender {
    if (![self.textFiled.text isEqual: @""]) {
        self.mblock(self.textFiled.text,[UIColor greenColor]);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
