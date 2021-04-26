//
//  ViewController.m
//  TestDemo
//
//  Created by 蔡月 on 2021/2/26.
//

#import "ViewController.h"
#import "sort.h"
#import <WebKit/WebKit.h>
#import "CustomerAView.h"
#import "CustomerBView.h"
#import "CustomerBView2.h"
#import <dispatch/queue.h>
#import "semphore.h"
#import "GCD.h"
#import "Array.h"
#import "Runtime.h"

#import "ARC.h"
#import "Link.h"
#import <CoreFoundation/CoreFoundation.h>
#import "TimerSecondViewController.h"
#import <JavaScriptCore/JSVirtualMachine.h>
#import <JavaScriptCore/JSContext.h>

@interface ViewController ()<WKNavigationDelegate, WKScriptMessageHandler>
@property (nonnull, copy) NSString *name;
@property (nonatomic, strong) GCD *gcd;
@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return  [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (instancetype)init {
    return [super init];
}

- (void)talk {
    NSLog(@"%@ are walking", self);
}


- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self talk];
    
    CustomerAView *aView = [[CustomerAView alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    aView.backgroundColor = [UIColor systemPinkColor];
    aView.tag = 1000;
    [self.view addSubview:aView];
    
    
    CustomerBView2 *bView = [[CustomerBView2 alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    bView.backgroundColor = [UIColor clearColor];
//    bView.alpha = 0;
    [self.view addSubview:bView];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"页面跳转" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(100, 500, 80, 50);
    [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
    
    
    // 穿行队列卡死
//    dispatch_queue_t queue = dispatch_queue_create("com.queue.caiyue", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"11");
//    dispatch_async(queue, ^{
//        NSLog(@"a");
//        dispatch_sync(queue, ^{
//            NSLog(@"b");
//        });
//    });
//    NSLog(@"22");
    
    
    [[ARC new] test];
    [[Link new] test];
    [[sort new] test];
    [[semphore new] test];
    [[Array new] test];
    
    [[Runtime new] test];

    
    
    Class cls = [self class];
    int a = 10;
    int b = 20;
    int c = 30;
    void *fp = &cls;
    [(__bridge  id)fp talk];
    NSLog(@"%d,%d, %d", a, b, c);
    
//    [self performSelector:@selector(test)];
//    [self testPrint];
    [self test2];

    
    // 普通对象，在哪个线程release，就在哪个线程执行dealloc，UI对象只在主线程释放。
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    });
    

    dispatch_async(dispatch_get_main_queue(), ^{
       self.gcd = [GCD new];
        // 生产者 & 消费者
        // [self.gcd test];
    });
    
    
    NSProxy *proxy = [NSProxy alloc];
    // 不走方法查询，消息转发是直接到forwardInvocation,然后走doesNotRecognizeSelector。
    // [proxy performSelector:@selector(didProxy)];
    // 可以用来做中间转发，比如在弱引用的timer或者消息转发很合适
    // 轻量级，比NSObject轻很多
    
    
    // context中的全局对象，oc和js能相互调用就是因为这个globalObject 可以通过context来设置全局方法和数据，通过jsvalue转换
    // 两端都可以访问，其他跨语音访问大概率也是
    JSContext *context = [JSContext currentContext];
    NSLog(@"%@",context.globalObject);
    
    
   
    //https://www.jianshu.com/p/213702004d0d
    UIImageView *firstView = [[UIImageView alloc] initWithFrame:CGRectZero];
    firstView.image = [UIImage imageNamed:@"live_card_gift_balance_icon_diamond"];
    firstView.backgroundColor = [UIColor redColor];
    
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectZero];
    secondView.backgroundColor = [UIColor orangeColor];
    
    UIView *thridView = [[UIView alloc] initWithFrame:CGRectZero];
    thridView.backgroundColor = [UIColor blueColor];
    
    UIView *forthView = [[UIView alloc] initWithFrame:CGRectZero];
    forthView.backgroundColor = [UIColor greenColor];

    // UIStackView
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[firstView, secondView, thridView, forthView]];
    stackView.frame = CGRectMake(200, 250, 0, 0);
//    stackView.backgroundColor = [UIColor systemPinkColor];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;
    // 不用写stackview的大小，只需要固定他的位置就行了，然后通过设置spaciing和distribution接口确定stackview的大小。
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.spacing = 20;
    stackView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:stackView];
    
    
    // UIWebView
    WKWebView *webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 350, 320, 50)];
    webview.backgroundColor = [UIColor orangeColor];
    [webview loadHTMLString:@"<a href=\"calendar://\">Click me!</a>" baseURL:nil];
    [self.view addSubview:webview];
    
}


- (void)testPrint{
    dispatch_semaphore_t source = dispatch_semaphore_create(1);
    __block NSInteger n = 100;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        while (YES) {
            dispatch_semaphore_wait(source, DISPATCH_TIME_FOREVER);
            NSLog(@"thread 1 : %ld",n--);
            if (n < 0) {
                dispatch_semaphore_signal(source);
                return;;
            }
            dispatch_semaphore_signal(source);
        }
    });
    
    dispatch_async(queue, ^{
        while (YES) {
            dispatch_semaphore_wait(source, DISPATCH_TIME_FOREVER);
            NSLog(@"thread 2 : %ld",n--);
            if (n < 0) {
                dispatch_semaphore_signal(source);
                return;
            }
            dispatch_semaphore_signal(source);
        }
    });
}

- (void)test2 {
    dispatch_queue_t queue = dispatch_queue_create("mycustom", DISPATCH_QUEUE_SERIAL);
       NSLog(@"dispatch111 start");
       dispatch_async(queue, ^{
           NSLog(@"sleep1111");
           NSLog(@"dispatch111 %@", [NSThread currentThread]);
           
//           dispatch_async(queue, ^{
//               NSLog(@"block in queue");
//           });
           
           // dispatch_sync 会等待，无论block任务是否有延迟
           [NSThread sleepForTimeInterval:5];
           NSLog(@"awake up111");
       });
//       dispatch_barrier_async(queue, ^{
//           NSLog(@"------------------- barrier");
//       });
       NSLog(@"dispatch2222 start");
    // 同步执行，会执行前面所有的任务，直到当前同步任务执行完毕
       dispatch_sync(queue, ^{
           NSLog(@"sleep 2222");
           NSLog(@"dispatch2222 %@", [NSThread currentThread]);
           [NSThread sleepForTimeInterval:3];
           NSLog(@"awake up222222");
       });
    
    
    NSLog(@"task:1");
    dispatch_async(queue, ^{
        NSLog(@"task:2");
    });
    NSLog(@"task:3");
    dispatch_sync(queue, ^{
        NSLog(@"task:4");
    });
    NSLog(@"task:5");


    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSelector:@selector(testP) withObject:nil afterDelay:0.2];
        [[self class] cancelPreviousPerformRequestsWithTarget:self];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self performSelector:@selector(testP2) withObject:nil afterDelay:0.1];
        
       // 曾经尝试将 [[NSRunLoop currentRunLoop]run]添加在performSelector: withObject: afterDelay:方法前，但发现延迟方法仍然不调用，这是因为若想开启某线程的Runloop，必须具有timer、source、observer任一事件才能触发开启。
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
    });

    
    // 只是自己创建的并发队列，如果是窜行队列或者全局队列，和dispatch_async没有区别
    dispatch_barrier_async(queue, ^{
        NSLog(@"this is a barrier async");
    });
    
    NSLog(@"this is after barrier async");
    
    dispatch_barrier_sync(queue, ^{
        NSLog(@"this is a barrier sync");
    });
}

- (void)testP {
    NSLog(@"perform=====2");
}

- (void)testP2 {
    NSLog(@"perform=====3");
}


- (void)addrunloop {
    
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES;
}

- (UIView *)superViewWithView:(UIView *)firstObj secondView:(UIView *)secondObj {
    
    // 公共父类
    UIView *firstSuperView = firstObj.superview;
    UIView *secondSuperView = secondObj.superview;
    
    NSMutableArray *superView1 = [NSMutableArray new];
    NSMutableArray *superView2 = [NSMutableArray new];

    while (firstSuperView) {
        [superView1 addObject:firstSuperView];
        firstSuperView = firstSuperView.superview;
    }
    
    while (secondSuperView) {
        [superView2 addObject:secondSuperView];
        secondSuperView = secondSuperView.superview;
    }
    

    // 求共同对象
    //    superView1
    //    superView2

    BOOL hasSame = FALSE;
    UIView *sameSuperView = nil;
    for (UIView *view in superView1) {
        hasSame = [superView2 containsObject:view];
        if (hasSame) {
            sameSuperView = view;
            break;
        }
    }
    
    return sameSuperView;
}

- (void)jump {
    TimerSecondViewController *sec = [[TimerSecondViewController alloc] init];
    [self presentViewController:sec animated:YES completion:nil];
}

@end
