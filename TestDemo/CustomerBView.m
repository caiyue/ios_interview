//
//  CustomerBView.m
//  TestDemo
//
//  Created by 蔡月 on 2021/3/1.
//

#import "CustomerBView.h"
#import "CustomerAView.h"

@implementation CustomerBView

+ (void)initialize {
    NSLog(@"initialize in subclass");
    typedef void (^myBlock)(int n);
}

+ (void)load {
    NSLog(@"load in subclass");
}

- (instancetype)initWithFrame:(CGRect)frame {
    // 和后面的self 是同一个对象，但是没有layer对象，经过frame参数才会有layer对象
    NSLog(@"self=====%@",self);
    if (self = [super initWithFrame:frame]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"ViewB-Btn-B1" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake(100, 100, 80, 30);
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 setTitle:@"ViewB-Btn-B2" forState:UIControlStateNormal];
        btn2.backgroundColor = [UIColor redColor];
        btn2.frame = CGRectMake(100, 600, 80, 30);
        [btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
    }
    
    return self;
}


// 返回当前其他的View来响应，或者通过property传入view来响应（是否同级都没有问题），
// 或者直接在该方法里返回nil，让父视图响应即可。

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    CustomerAView *aView = [self.superview viewWithTag:1000];
//    return aView.btn;
//}


// 如果点击的Button超过父视图的位置，一般是不响应的，如果需要响应，已重写pointInside来支持。

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    return YES;
//}




- (void)click:(UIButton *)sender {
    NSLog(@"you click B View hash:%d", self.hash);

    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, 0, 20);
    transform = CGAffineTransformScale(transform, 0.2, 0.2);
//    transform = CGAffineTransformTranslate(transform, 0, -(currentHeight / scale / 2) * (1 - scale) / scale);
    sender.transform = transform;
}



- (void)dealloc {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
