//
//  BloomFilter.m
//  TestDemo
//
//  Created by 蔡月 on 2021/9/20.
//

#import "BloomFilter.h"

@implementation BloomFilter

- (void)test {
    
    /*
     布隆过滤器，主要是用在内存要求较低的情况下，用的。比如在100w个数据里找某个数据，如果用一般的数据，数组，链表会占用很大内存。
     映射： 布隆过滤器主要思路是 提供bit位数组，并都初始化为0，每一bit只有可能是0/1，并通过多个hash函数生成bit的index，根据index找到这些bit，并设置成1。
     查询操作：根据查询的数据，重复上面的步骤，根据多个hash函数生成多个bit的index，如果有一个bit为0，说明肯定没有这个数据，如果都为1，只能说明又可能存在，因为这些bit 又可能是其他的数字所设置的。
     
     结论：布隆过滤器查询某个数据，查询的bit 存在0，说明肯定不存在这个数据，如果都为1，则说明可能存在，也有可能不存在。
     
     hash函数是布隆过滤器的基础。
     
     **/
    
//https://blog.csdn.net/DamonRush/article/details/104653952
}

@end
