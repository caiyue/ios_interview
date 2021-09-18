//
//  SecondViewController.m
//  TestDemo
//
//  Created by caiyue on 2021/3/24.
//

#import "TimerSecondViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface TimerSecondViewController ()
@end

@implementation TimerSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"关闭页面" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(0, 40, 80, 50);
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];

    
    // 定时器强持有target
//    __weak typeof (self) weakSelf = self;
    NSTimer *timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(repeat) userInfo:nil repeats:YES];
    // runloop 强持有timer
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    // 解决办法是使用，timer使用block回调，避免使用target，或者使用NSProxy 中间类，这个中间类持有弱引用controller。
    // https://juejin.cn/post/6844903968250789896
    
    
    // CADisplayLink也是强引用target，runloop也强持有CADisplayLink  所以也可以使用Proxy中间对象
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(refre)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 发送本地push推送
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        if (center == nil) {
            return;
        }
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"title";
        content.body = @"this is body";
        content.sound = [UNNotificationSound defaultSound];
        content.userInfo = @{};;
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"caiyue" content:content trigger:nil];
        if (request == nil) {
            return;
        }
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            if (error) {
//                DDLogInfo(@"本地push发送失败-%@", error);
            } else {
//                DDLogInfo(@"本地push发送成功");
            }
        }];
    });
}

- (void)repeat {
    NSLog(@"timer repoeat");
}

- (void)refre {
    NSLog(@"CADisplayLink repoeat");
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc {
    NSLog(@"second View Controller dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
