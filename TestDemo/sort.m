//
//  sort.m
//  TestDemo
//
//  Created by 蔡月 on 2021/2/28.
//

#import "sort.h"

/**
 堆排序 https://www.cnblogs.com/chengxiao/p/6129630.html
 1、构建大顶堆，寻找非叶子节点，保证根节点比左右节点要大
 2、重复下一个非叶子节点，继续调整，如果调整某非叶子节点导致其他非叶子节点需要重新调整，那就继续调整
 3、初始的大顶堆构造完成
 4、将堆顶元素与末尾元素交换，将最大元素"沉"到数组末端;
 5、重新调整结构，使其满足堆定义，然后继续交换堆顶元素与当前末尾元素
 */


void quick_sort( int *a, int n)
{
    int i, j, p, tmp;
    if (n < 2)  return;

    p = a[n / 2];   // Get the middle element as pivot ..
    for (i = 0, j = n - 1;  ;i++, j--) {
        while (a[i] < p) {
            i++;
        }

        // 不能包括 等于 p
        while (a[j] > p) {
            j--;
        }

        if (i >= j)
            break;;
        tmp = a[i];
        a[i] = a[j];
        a[j] = tmp;
    }
    

    quick_sort(a, i);
    quick_sort(a + i, n - i);
}


int bSearchRe(int *a, int length, int value) {
    if (length < 2) return -1;
    int middle = length / 2;
    if (value < a[middle]) {
        return bSearchRe(a, middle, value);
    } else {
        return bSearchRe(a + middle, length - middle, value);
    }
    return -1;
}

int bSearch(int *a, int lenght ,int value) {
    int low = 0;
    int high = lenght - 1;
    while (low <= high) {
        int middle = low + (high - low)/2;
        if (a[middle] < value) {
            low = middle + 1;
        } else if (a[middle] > value){
            high = middle - 1;
        }
        return middle;
    }
    return  -1;
}


void merge(int* num, int start, int mid, int end)
{
    int *temp = (int *)malloc((end-start+1) * sizeof(int));    //申请空间来存放两个有序区归并后的临时区域
     int i = start;
       int j = mid + 1;
       int k = 0;
  
       while (i <= mid && j <= end)
       {
           if (num[i] <= num[j])
           {
               temp[k++] = num[i++];
           }
           else
           {
               temp[k++] = num[j++];
           }
       }
  
       while (i <= mid)
       {
           temp[k++] = num[i++];
       }
       while (j <= end)
       {
           temp[k++] = num[j++];
       }
  
       //将临时区域中排序后的元素，整合到原数组中
       for (i = 0; i < k; i++)
       {
           num[start + i] = temp[i];
       }
  
       free(temp);
}

void merge_sort(int* arr, int start, int end)
{
    if (start < end) {
        int mid = (start + end) / 2;
        // 归
        merge_sort(arr, start, mid);
        merge_sort(arr, mid + 1, end);
        
        merge(arr, start, mid, end);
    }
}

@implementation sort

- (void)test {
//    int a[] = {1, 2, 3 , 10, 20, 15, 17, 19, 22, 16};
//    // 数组 【4， 1， 5 ，10， 20， 15】
//    quick_sort(a, 10);
    
    int b[] = {4, 1, 5, -10, 20, 15};
    
    quick_sort(b, 6);
    
    for (int i = 0; i < 6; i++) {
        printf("sort result ==%d\n", b[i]);
    }
    
}



@end
