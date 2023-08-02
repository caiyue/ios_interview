//
//  SecondViewController.m
//  TestDemo
//
//  Created by caiyue on 2021/3/24.
//

#import "TimerSecondViewController.h"
#import "KMCardViewController.h"
#import <UserNotifications/UserNotifications.h>


@interface SecondPageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation SecondPageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.frame = CGRectMake(0, 10, 150, 80);
    }
    return self;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.layer.cornerRadius = 6;
        _nameLabel.layer.borderWidth = 1;
        _nameLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _nameLabel.layer.masksToBounds = YES;
    }
    return _nameLabel;
}

@end


@interface TimerSecondViewController () <UITableViewDelegate, UITableViewDataSource>
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
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    // 解决办法是使用，timer使用block回调，避免使用target，或者使用NSProxy 中间类，这个中间类持有弱引用controller。
    // https://juejin.cn/post/6844903968250789896
    
    
    // CADisplayLink也是强引用target，runloop也强持有CADisplayLink  所以也可以使用Proxy中间对象
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(refre)];
//    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100,
                                                                           UIScreen.mainScreen.bounds.size.width,
                                                                           UIScreen.mainScreen.bounds.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if (!cell) {
        cell = [[SecondPageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    }
    cell.nameLabel.backgroundColor = [UIColor orangeColor];
    cell.nameLabel.text = @"啊啊咔咔咔咔咔咔咔咔";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondPageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 2) {
        KMCardViewController *vc = [[KMCardViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    [UIView animateWithDuration:2.0 animations:^{
        cell.nameLabel.frame = CGRectMake(0, 20, 300, 60);
    }];
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
