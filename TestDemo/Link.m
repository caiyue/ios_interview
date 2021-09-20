//
//  Link.m
//  TestDemo
//
//  Created by 蔡月 on 2021/3/10.
//

#import "Link.h"

typedef struct Node {
    int value;
    struct Node *next;
} *LinkNode;

@implementation Link

- (void)test {
    // 链表 增删改
    LinkNode head = [self initNode];
    [self addNode:head value:1];
    [self addNode:head value:2];
    [self addNode:head value:7];
    [self addNode:head value:8];

    
    LinkNode head2 = [self initNode];
    [self addNode:head2 value:1];
    [self addNode:head2 value:3];
    [self addNode:head2 value:5];
    [self addNode:head2 value:9];
    
//    [self print: head];

    // 链表反转
//    LinkNode newHead = [self reverse:head];
//    [self print:newHead];
    
    
    // 链表合并
    LinkNode combineLink = [self combineNode:head secondNode:head2];
    [self print:combineLink];
    
    // LRU算法
    
    
    // 字符串反转
    
    // 二叉树遍历 前中后

    
//    [[sort new] test];
    
    
    //  虽然数组是深复制，但是元素依然是浅复制
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        [array addObject:@(i)];
    }
    NSArray *newArray = [array mutableCopy]; // 生成了一个不可变对象
}

- (LinkNode)combineNode:(LinkNode)head secondNode:(LinkNode)secondHead {
    if (head == NULL) return secondHead;
    if (secondHead == NULL) return head;
    
    LinkNode pre = [self initNode];
    LinkNode newHead = pre;
    
    LinkNode p1 = head;
    LinkNode p2 = secondHead;

    
    while (p1 && p2) {
        if (p1->value <= p2->value) {
            pre->next = p1;
            p1 = p1->next;
        } else {
            pre->next = p2;
            p2 = p2->next;
        }
        pre = pre->next;
    }

    if (p1 == NULL) {
        pre->next = p2;
    }

    if (p2 == NULL) {
        pre->next = p1;
    }
    
    return newHead->next;
}

- (LinkNode)initNode {
    LinkNode head = (LinkNode )malloc(sizeof(struct Node));
    head->value = 0;
    head->next = NULL;
    return head;
}

- (void)addNode:(LinkNode)head value:(int)value {
    LinkNode p = head;
    while (p->next) {
        p = p->next;
    }
    LinkNode node = (LinkNode )malloc(sizeof(struct Node));
    node->value = value;
    node->next = NULL;
    p->next = node;
}

- (LinkNode)removeNode:(LinkNode)node head:(LinkNode)head {
    LinkNode p = head;
    if (head == node) {
        p = head->next;
        free(head);
        return p;
    } else {
        while (p->next != node) {
            p = p->next;
        }
        p->next = node->next;
        node->next = NULL;
        free(node);
    }
    return  head;
}

- (void)modify:(LinkNode)node  head:(LinkNode)head value:(int)value {
    LinkNode p = head;
    while (p != node) {
        p = p->next;
    }
    p->value = value;
}

- (void)print:(LinkNode)head {
    LinkNode p = head;
    while (p) {
        NSLog(@"%d", p->value);
        p = p->next;
    }
}

- (LinkNode)reverse:(LinkNode)head {
    LinkNode current = head;
    LinkNode pre = NULL;
    while (current) {
        LinkNode nextNode = current->next;
        current->next = pre;
        pre = current;
        current = nextNode;
    }
    return pre;
}


- (LinkNode)removeRepeatNode:(LinkNode)head {
    if (head->next == NULL) {
        return head;
    }
    
    LinkNode current = head;
    while (current) {
        LinkNode nextNode = current->next;
        if (nextNode->value == current->value) {
            // 删除下一节点
            current->next = nextNode->next;
            free(nextNode);
        }
        current = current->next;
    }
    return head;
}

//  链表排序
- (void)sortLink:(LinkNode)head {
    LinkNode end = NULL;
    LinkNode firstNode = head;
    LinkNode secondNode = head->next;

    firstNode = head;
    secondNode = head->next;
    while (end != head) {
        while (firstNode && secondNode) {
            // swap
            
            firstNode = firstNode->next;
            secondNode = secondNode->next;
        }
        
        firstNode = head;
        secondNode = head->next;
        end = firstNode->next;
    }
}

// 环形链表
- (BOOL)findCircleLink:(LinkNode)head {
    if (head == NULL || head->next == NULL) return NO;
        LinkNode faster = head;
        LinkNode slower = head;
           while (faster->next != NULL && faster->next->next != NULL) {
               slower = slower->next;
               faster = faster->next->next;
               if (faster == slower)
                   return YES;
           }
    return NO;
}

/*
 跳表，是为了解决链表遍历效率的问题O(n)，一般跳表适合有序链表，为了提高效率，可以根据链表，生成索引，索引一般是相隔几个节点设置这一个，这样，查询数据，就能根据索引节点来查询，就相当于在链表之上跳着查询，可以极大提高效率，索引可以设置多层，索引越多，查询效率越高。redis 这个缓冲用的就是跳表来实现的，效率很高。
 **/

@end
