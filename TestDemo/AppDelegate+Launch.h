//
//  AppDelegate+Launch.h
//  TestDemo
//
//  Created by 蔡月 on 2021/3/9.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Launch)

+ (void)test;

// category 可以添加property 只是无法生成ivar，无法调用set方法
@property (nonnull) NSString *test;

@end

NS_ASSUME_NONNULL_END
