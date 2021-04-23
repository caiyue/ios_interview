//
//  semphore.m
//  TestDemo
//
//  Created by 蔡月 on 2021/3/1.
//

#import "semphore.h"
#import <dispatch/semaphore.h>
#import <UIKit/UIKit.h>

@implementation semphore

- (void)test {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore ,DISPATCH_TIME_FOREVER);

    dispatch_async(dispatch_get_main_queue(), ^{
        sleep(2);
        dispatch_semaphore_signal(semaphore);
    });
    
    
    
    // 实现自旋锁

}



@end
