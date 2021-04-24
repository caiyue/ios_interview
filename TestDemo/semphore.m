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
    
    // 信号量访问有一个timeout 延迟，可以用来在监控卡顿的时候在timeout时间内能否切换到下一个状态来监控卡顿
    dispatch_semaphore_wait(semaphore ,1);

    dispatch_async(dispatch_get_main_queue(), ^{
        sleep(2);
        dispatch_semaphore_signal(semaphore);
    });
    

    // 实现自旋锁 while循环 + 标记位
}



@end
