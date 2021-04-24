//
//  Image.m
//  TestDemo
//
//  Created by caiyue on 2021/4/24.
//

#import "Image.h"
#import <UIKit/UIKit.h>

@implementation Image

- (void)test {
    // CATiledLayer是为载入大图造成的性能问题提供的一个解决方案，他将需要绘制的内容分割成许多小块，
    // 然后在许多线程里按需异步绘制相应的小块，具体如何划分小块和缩放时的加载策略，与CATiledLayer三个重要属性有关
    // https://zhuanlan.zhihu.com/p/31323034
    CATiledLayer *layer;
}

@end
