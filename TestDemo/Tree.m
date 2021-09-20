//
//  Tree.m
//  TestDemo
//
//  Created by 蔡月 on 2021/2/28.
//

#import "Tree.h"


typedef struct Node{
    int data;
    struct Node *left;
    struct Node *right;
} BiTree;

@implementation Tree


void Create_BiTree(){
    BiTree *node = (BiTree *)malloc(sizeof(struct Node));
    node->data = 0; //生成树结点
    node->left = NULL;
    node->right = NULL;
}

void TraverseBiTree(BiTree *T) {    //先序遍历
    NSLog(@"%d", T->data);
        TraverseBiTree(T->left);
        TraverseBiTree(T->right);
    }


void preOrderTravel(BiTree *root) {
//    NSMutableArray *result = [NSMutableArray new];
//    stack<BinTree*> s;
//    BiTree *current = root;
    
 
    
//    while (current || stack.count > 0) {
//        while (current) {
//            result.push(current->data);
//            stack.push(current);
//            current = current->left;
//        }
//        current = stack.pop();
//        current = current->right;
//    }
//
//    return result;
}

void middleOrderTravel(BiTree *root) {
    
//    stack<BinTree*> s;
//     BinTree *p=root;
    
//     while(p!=NULL||!s.empty())
//     {
//         while(p!=NULL)
//         {
//             s.push(p);
//             p=p->lchild;
//         }
//         if(!s.empty())
//         {
//             p=s.top();
//             cout<<p->data<<"";
//             s.pop();
//             p=p->rchild;
//         }
//     }
}

void postOrderTravel(BiTree *root) {
//        List<Integer> result = new LinkedList<>();
//       Stack<TreeNode> toVisit = new Stack<>();
//       TreeNode cur = root;
//       TreeNode pre = null;
//
//       while (cur != null || !toVisit.isEmpty()) {
//           while (cur != null) {
//               toVisit.push(cur); // 添加根节点
//               cur = cur.left; // 递归添加左节点
//           }
//           cur = toVisit.peek(); // 已经访问到最左的节点了
//           //在不存在右节点或者右节点已经访问过的情况下，访问根节点
//           if (cur.right == null || cur.right == pre) {
//               toVisit.pop();
//               result.add(cur.val);
//               pre = cur;
//               cur = null;
//           } else {
//               cur = cur.right; // 右节点还没有访问过就先访问右节点
//           }
//       }
//       return result;
}


//- (int)deepOfMulTree(MNode *)root {
//    int deep = 0;
//    if (root->children == NULL) return 0;
//       deep++;
//       int maxDeep = 0;
//       for(int i = 0; i <= root->children.length; i++) {
//           MNode *node = root.children[i];
//           maxDeep = deepOfMulTree(node) >= maxDeep ? : maxDeep;
//       }
//       return maxDeep + 1;
//}


// 二叉树左右反转
void reverseTree(BiTree *root) {
    if (root == NULL) return;
    if (root->left == NULL || root->right == NULL) return;
    
    BiTree *temp = root->left;
    root->left = root->right;
    root->right = temp;
    
    reverseTree(root->left);
    reverseTree(root->right);
}

// 层级遍历
void levelTravel(BiTree *root) {
//    Queue<BiTree *> queue = new Queue();
//         //首先将根节点加入栈中
//         queue.push(root);
//         //遍历二叉树
//         while (!queue.isEmpty()) {
//             BiTree *tempNode = queue.deQueue();
//             NSLog(@"%d", tempNode->data);
//
//             if(tempNode->left != null){
//                 queue.push(tempNode->left);
//             }
//             if(tempNode->right != null){
//                 queue.push(tempNode->right);
//             }
//         }
}

// 二叉树相邻两层遍历顺序相反
void traversalTreeWith(BiTree *root) {
//    List<Node> result = new ArrayList<>();
//    boolean status = true;
//    Stack<Node> layerNodes = new Stack<>();
//    layerNodes.add(root);
//    while (layerNodes.size() > 0) {
//        result.addAll(layerNodes);
//        layerNodes = getNextLayer(layerNodes, status);
//        status = !status;
//    }
//    System.out.println(result);
}

//public static Stack<Node> getNextLayer(Stack<Node> stack, boolean status) {
//    Stack<Node> layerNodes = new Stack();
//    while (stack.size() > 0) {
//        Node node = stack.pop();
//        if (status) {
//            if (node.right != null) {
//                layerNodes.add(node.right);
//            }
//            if (node.left != null) {
//                layerNodes.add(node.left);
//            }
//        } else {
//            if (node.left != null) {
//                layerNodes.add(node.left);
//            }
//            if (node.right != null) {
//                layerNodes.add(node.right);
//            }
//        }
//    }
//    return layerNodes;
//}


/*
 
 AVL：平衡二叉树，指的是节点的左右子树的高度差 <= 1
 
 二叉搜索树是：左节点比跟节点要小，右节点要比跟节点要大，中序遍历就是一个有序的集合。
 
 红黑树：
 （1）每个节点或者是黑色，或者是红色。
 （2）根节点是黑色。
 （3）每个叶子节点（NIL）是黑色。 [注意：这里叶子节点，是指为空(NIL或NULL)的叶子节点！]
 （4）如果一个节点是红色的，则它的子节点必须是黑色的。
 （5）从一个节点到该节点的子孙节点的所有路径上包含相同数目的黑节点。
 
 一般都会使用红黑树来替换二叉搜索树。
 
 
 B+树用来做数据库索引，一般根节点在内存中，其他节点在磁盘中。这样可以节省内存。
 B+树叶子节点用来存储数据，且用链表连接起来，其他节点用来存储索引，这个和跳表非常的相似。

 **/

@end
