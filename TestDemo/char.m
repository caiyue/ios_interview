//
//  char.m
//  TestDemo
//
//  Created by 蔡月 on 2021/3/1.
//

#import "char.h"
#import <Foundation/Foundation.h>

struct MNode {
   int value;
   struct MNode *children[];
};

@implementation char1

- (int *)exchangeRange:(int)startIndex startLength:(int)startLength endInde:(int)endIndex endLength:(int)endLength array:(int *)a {

if (a == NULL || startLength < 0 || endLength < 0) return NULL;
int *startP = a + startIndex;
int *endP = a + endIndex;
int exchangeLength = startLength > endLength ? endLength : startLength;

while (exchangeLength > 0)
{
    int temp = *startP;
    *startP = *endP;
    *endP = temp;
    exchangeLength--;
    startP++;
    endP++;
}

return a;
}


- (void)uniqChar{
    char a[] = "abcccddaa";
}

// 滑动窗口
- (int)maxLength:(char *) c {
    char *firsP = c;
    int startIndex = 0;
    int endIndex = 1;
    
    char *secondP = c + 1;
    int max = 0;
    while (*secondP != '\0') {
        BOOL same = [self hasSameChar:firsP endP:secondP value: *secondP];
        if (same) {
            firsP++;
            startIndex++;
        } else {
            secondP++;
            endIndex++;
            if (endIndex - startIndex > max) {
                max = endIndex - startIndex > max ? endIndex - startIndex: max;
            }
        }
    }
    
    return max;
}

- (BOOL)hasSameChar:(char *)startP endP:(char *)endP value:(char)value {
    return NO;
}


@end
