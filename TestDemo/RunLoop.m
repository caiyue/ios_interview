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



//- (void)start
//{
//    if (observer)
//        return;
//
//    // 信号
//    semaphore = dispatch_semaphore_create(0);
//
//    // 注册RunLoop状态观察
//    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
//    observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
//                                       kCFRunLoopAllActivities,
//                                       YES,
//                                       0,
//                                       &runLoopObserverCallBack,
//                                       &context);
//    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
//
//    // 在子线程监控时长
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        while (YES)
//        {
//            long st = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC));
//            if (st != 0)
//            {
//                if (!observer)
//                {
//                    timeoutCount = 0;
//                    semaphore = 0;
//                    activity = 0;
//                    return;
//                }
//
//                if (activity==kCFRunLoopBeforeSources || activity==kCFRunLoopAfterWaiting)
//                {
//                    if (++timeoutCount < 5)
//                        continue;
//
//                    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc] initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeBSD
//                                                                                       symbolicationStrategy:PLCrashReporterSymbolicationStrategyAll];
//                    PLCrashReporter *crashReporter = [[PLCrashReporter alloc] initWithConfiguration:config];
//
//                    NSData *data = [crashReporter generateLiveReport];
//                    PLCrashReport *reporter = [[PLCrashReport alloc] initWithData:data error:NULL];
//                    NSString *report = [PLCrashReportTextFormatter stringValueForCrashReport:reporter
//                                                                              withTextFormat:PLCrashReportTextFormatiOS];
//
//                    NSLog(@"------------\n%@\n------------", report);
//                }
//            }
//            timeoutCount = 0;
//        }
//    });
//}


// https://juejin.cn/post/6844903944867545096

@end
