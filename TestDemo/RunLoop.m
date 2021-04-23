//
//  RunLoop.m
//  TestDemo
//
//  Created by 蔡月 on 2021/3/14.
//

#import "RunLoop.h"
#import <CoreFoundation/CFRunLoop.h>
#import <UIKit/UIKit.h>

@implementation RunLoop

- (void)test {
    CFRunLoopActivity observedActivities = kCFRunLoopBeforeTimers | kCFRunLoopBeforeSources | kCFRunLoopBeforeWaiting | kCFRunLoopAfterWaiting;
    CFRunLoopObserverRef ob = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, observedActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
//        NSLog(@"activieyt=====%d", activity);
//        signal信号量
//        搞个子线程，wait 信号量，并设置超时时间2s
//        当超时返回后，判断上次的runloop状态，如果是afterWating状态，就认为是卡顿
    });
    
    CFRunLoopAddObserver(CFRunLoopGetMain(), ob, kCFRunLoopCommonModes);
    
    
    dispatch_semaphore_t semp = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (true) {
            int ret = dispatch_semaphore_wait(semp, 2);
            if (ret == -1) {
                NSLog(@"发生了卡顿");
                // 开始获取堆栈信息
            }
        }
    });
    
}

- (void)refre {
    NSLog(@"CADisplayLink refresh");
}

@end
