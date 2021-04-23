//
//  CustomerAView.m
//  TestDemo
//
//  Created by 蔡月 on 2021/3/1.
//

#import "CustomerAView.h"

@implementation CustomerAView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"ViewA-Btn-A" forState:UIControlStateNormal];
        _btn.backgroundColor = [UIColor orangeColor];
        _btn.frame = CGRectMake(0, 0, 80, 50);
        [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn];
    }
    return self;
     
}

- (void)click {
    NSLog(@"you click A View");
}

- (UIButton *)btn {
    return _btn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
