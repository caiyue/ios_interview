//
//  ARC.m
//  TestDemo
//
//  Created by 蔡月 on 2021/3/4.
//

#import "ARC.h"
#import <objc/objc.h>
#import <objc/message.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@implementation ARC

- (void)test {
    
    /*
     当 发送 class 消息 时不管是 self 还是 super 其消息主体依然是 self ,也就是说 self 和 super 指向的 是同一个对象。只是 查找方法的位置 区别，一个从本类，一个从本类的超类。
    
    一般情况下 class 方法 只有在 根类 NSObject 中定义，极少情况有子类重写 class 方法，
     
    所以 [slef class] 和 [super class] 都是在 根类中 找方法实现， 消息接收主体 又都是 a
     */
   
    NSLog(@"NSObject superClass ==%@, %@, %@", [[NSObject new] superclass], [self class], [super class]);
    
    NSProxy *p = [NSProxy alloc];
    
    NSMutableArray* ary = [[NSMutableArray array] retain];

    NSString *str = [NSString stringWithFormat:@"test"];

    [str retain];

    [ary addObject:str];

    NSLog(@"%@%d",str,[str retainCount]);

    [str retain];

    [str release];

    [str release];

    NSLog(@"%@%d",str,[str retainCount]);

    [ary removeAllObjects];

    NSLog(@"%@%d",str,[str retainCount]);

    NSMutableArray* ary2 = [[NSMutableArray array] retain];
    NSString *str2 = [NSString stringWithFormat:@"test"];

    [str2 retain];

    [ary2 addObject:str];

    NSLog(@"%@%d",str2,[str2 retainCount]);

    [str2 retain];

    [str2 release];

    [str2 release];

    NSLog(@"%@%d",str2,[str2 retainCount]);

    [ary2 removeAllObjects];

    NSLog(@"%@%d",str2,[str2 retainCount]);

    
//    获取所有的方法，包括被cateogry覆盖的方法
//    class_copyMethodList(Class  _Nullable cls, <#unsigned int * _Nullable outCount#>)
    
    NSMutableArray *a = [NSMutableArray array];
    [a addObject:@(1)];
    [a addObject:@(2)];
    [a addObject:@(3)];
    
    //  不能删除元素
//    for (NSNumber *nu in a) {
//        [a removeObject:nu];
//    }
    
//    CGImageSourceUpdateData();
}

- (ARC *)getInstance {
    return [ARC new];
}

- (Class)class {
    Class cls = NSClassFromString(@"char");
    return cls;
}

- (void)dealloc {
    
}

@end
