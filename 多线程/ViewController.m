//
//  ViewController.m
//  多线程
//
//  Created by 黄启明 on 2016/11/17.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
#import "FMDB.h"


void *pthreadRoutine(void *);

@interface ViewController (){
    pthread_attr_t _attr;
    pthread_t _pthreadID;
    int _returnVal;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
    
    
}

- (void)test1 {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%zu",index);
    });
    NSLog(@"done");
}

- (void)test {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMethod) object:nil];
    [thread start];
    
    _returnVal = pthread_attr_init(&_attr);
    _returnVal = pthread_attr_setdetachstate(&_attr, PTHREAD_CREATE_DETACHED);
    int threadError = pthread_create(&_pthreadID, &_attr, &pthreadRoutine, NULL);
    _returnVal = pthread_attr_destroy(&_attr);
    if (threadError != 0) { // Report an error.
        sleep(10);
        return;
    }
}
void *pthreadRoutine(void *data){
    int count = 0;
    while (1) {
        printf("count = %d\n",count++);
        sleep(1);
    }
    return NULL;
}

- (void)threadMethod {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
