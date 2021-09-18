//
//  GCD.m
//  TestDemo
//
//  Created by caiyue on 2021/3/20.
//

#import "GCD.h"

@implementation GCD

+ (void)load {
    
}

+ (void)initialize {
    
}

//  生产者，消费者，
- (void)test {
    // __block 是引用，不加是值引用
     __block int a = 10;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"a===%d", a);
    });
    a = 20;
    
    
    // 当前产品数量
    __block int productCount = 0;
    // 缓冲区大小
    const int bufferSize = 5;
    
    // 至少需要2个锁。
    dispatch_semaphore_t semaphoreProduce = dispatch_semaphore_create(bufferSize);
    // 后续的signal 会导致比初始值大
    dispatch_semaphore_t semaphoreConsume = dispatch_semaphore_create(0);
    

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (true) {
            dispatch_semaphore_wait(semaphoreProduce, DISPATCH_TIME_FOREVER);
            [NSThread sleepForTimeInterval:1];
            if (productCount >= bufferSize) {
                // 主要是用来执行空转 循环可以重新开始，相当于 continue的意思，但是因为本次执行完毕，需要signal自身。
                dispatch_semaphore_signal(semaphoreProduce);
            } else {
                productCount++;
                NSLog(@"生产商品，商品总量：%d", productCount);
                dispatch_semaphore_signal(semaphoreConsume);
            }
        }
     });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (true) {
            dispatch_semaphore_wait(semaphoreConsume, DISPATCH_TIME_FOREVER);
            [NSThread sleepForTimeInterval:1];
            if (productCount == 0 ) {
                // 主要是用来执行空转 循环可以重新开始，相当于 continue的意思，但是因为本次执行完毕，需要signal自身。
                dispatch_semaphore_signal(semaphoreConsume);
            } else {
                productCount--;
                NSLog(@"消费商品，商品总量：%d", productCount);
                dispatch_semaphore_signal(semaphoreProduce);
            }
        }
      });

}


- (void)dealloc {
    [super dealloc];
}


@end
