//
//  NSMyOperation.m
//  TestDemo
//
//  Created by caiyue on 2021/4/8.
//

#import "NSMyOperation.h"

@implementation NSMyOperation

// NSOperation 是抽象类，自定义类需要继承，并且实现至少main 和 start 方法
// 其他的状态相关字段，也需要重写
- (void)main {
    //
}

- (void)start {
    //
}

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isFinished {
    return NO;
}

@end
