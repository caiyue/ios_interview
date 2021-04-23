//
//  Request.m
//  TestDemo
//
//  Created by 蔡月 on 2021/3/6.
//

#import "Request.h"

@implementation Request

- (void)test {
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:nil delegate:nil];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:nil];
    
    
    
    [conn cancel];
}

@end
