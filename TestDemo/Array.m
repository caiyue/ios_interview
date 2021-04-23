//
//  Array.m
//  TestDemo
//
//  Created by 蔡月 on 2021/3/6.
//

#import "Array.h"

@implementation Array

- (void)randomWithLength:(int)n {
    // 先生成 1 - n的数组
    NSMutableArray *srcArray = [NSMutableArray array];
    for (int i = 1; i <= n; i++) {
        [srcArray addObject:@(i)];
    }
    
//
//    NSMutableArray *resultArray = [NSMutableArray array];
//
//    while (resultArray.count < n) {
//        // 生成随机数，然后从srcArray中取元素
//        int randomIndex = arc4random () % srcArray.count + 1;
//
//        // 取到的元素是
//        NSNumber *selectedEle = srcArray[randomIndex];
//
//        // 将随机选中的元素添加到 resultArray里
//        [resultArray addObject:selectedEle];
//
//        // 将选中的元素从srcArray 数组中移除
//        [srcArray removeObject:selectedEle];
//    }
//
//    return resultArray;
    
    
    int index = n - 1;
    while (index >= 0) {
        NSNumber *lastObj = srcArray[index];
        int randomIndex = arc4random() % index;
        NSNumber *randomObj = srcArray[randomIndex];
//        exchangeValue(lastObj, randomObj);
        index--;
    }
   
}

- (void)test {
    int a[5] = {1,2,3, 4, 5};
    test(a,5);
}


void printNums(int *nums, int len){
    for(int i = 0; i < len ; i ++){
        printf("%d",nums[i]);
    }
    printf("\n");

}


// 输出数组的全序列
void test(int *nums, int len){
    if(nums == NULL) return;
    for(int i = 0 ; i < len; i++){
        for(int j = 0 ; j < len - 1; j++){
            printNums(nums,len);
            int temp = nums[j];
            nums[j] = nums[j+1];
            nums[j+1] = temp;
        }
    }
}

@end
