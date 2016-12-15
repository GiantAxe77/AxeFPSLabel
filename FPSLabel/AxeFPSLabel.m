//
//  AxeFPSLabel.m
//  test_yymodel
//
//  Created by GiantAxe on 16/12/14.
//  Copyright © 2016年 GiantAxe. All rights reserved.
//

#import "AxeFPSLabel.h"

#import "YYWeakProxy.h"

@interface AxeFPSLabel ()
{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
}
@end

@implementation AxeFPSLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    // 初始化
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    
    _font = [UIFont fontWithName:@"Courier" size:14];
    if (_font)
    {
        _subFont = [UIFont fontWithName:@"Courier" size:4];
    }
    else
    {
        _font = [UIFont fontWithName:@"Georgia" size:14];
        _subFont = [UIFont fontWithName:@"Georgia" size:4];
    }
    
    // 开启定时器
    _link = [CADisplayLink displayLinkWithTarget:[YYWeakProxy proxyWithTarget:self] selector:@selector(update:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)update:(CADisplayLink *)link
{
    // 第一次进来
    if(_lastTime == 0)
    {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    
    // 两帧间隔时间
    NSTimeInterval delta = link.timestamp - _lastTime;
    
    // 过滤刷新次数
    if (delta < 1) return;
    
    // 计算FPS
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    self.text = [NSString stringWithFormat:@"%d FPS", (int)round(fps)];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:_subFont range:NSMakeRange(text.length - 4, 1)];
    self.attributedText = text;
    
}

- (void)dealloc
{
    [_link invalidate];
    NSLog(@"timer release");
}

@end
