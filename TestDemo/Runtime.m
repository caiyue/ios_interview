//
//  Runtime.m
//  TestDemo
//
//  Created by caiyue on 2021/4/1.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Runtime.h"

@implementation Runtime

- (void)test {
    NSInvocation *invo;
    // target selector
    // set para
    
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:@selector(method:sec:)];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];

    invocation.target = self;
    invocation.selector = @selector(method:sec:);

    NSString *name = @"SJM";
    NSNumber *age = @30;
    // 参数必须从第2个索引开始，因为前两个已经被target和selector使用
    [invocation setArgument:&name atIndex:2];
    [invocation setArgument:&age atIndex:3];
    
    [invocation invoke];
}

- (void)method:(NSString *)p1 sec:(NSNumber *)p2 {

    NSLog(@"%@::%@", p1, p2);
}

@end

