//
//  SuspendBall.m
//  MDSettingCenter
//
//  Created by AloneMonkey on 2017/10/25.
//  Copyright (c) 2017年 MonkeyDev. All rights reserved.
//

#import "UIView+Frame.h"
#import "MDSuspendBall.h"
#import "MDConstants.h"
#import "MDSettingsViewController.h"

@implementation MDSuspendBall

+ (instancetype)sharedInstance {
    static MDSuspendBall *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MDSuspendBall alloc] initWithFrame:CGRectMake(0, 64, 40, 40)];
    });
    return instance;
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = self.width / 2;
        self.bgColor = [UIColor grayColor];
        //背景颜色
        self.backgroundColor = [self.bgColor colorWithAlphaComponent:0.6];
        
        //点击事件
        [self addTarget:self action:@selector(showSetting) forControlEvents:UIControlEventTouchUpInside];
        
        //移动事件
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureMove:)];
        [self addGestureRecognizer:pan];
        
    }
    return self;
}

-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.backgroundColor = [bgColor colorWithAlphaComponent:0.6];
}

-(void)addToWindow:(UIWindow*) window{
    if(!window){
        window = [[UIApplication sharedApplication].windows firstObject];
    }
    MDSuspendBall *suspendBall = [MDSuspendBall sharedInstance];
    [suspendBall removeFromSuperview];
    [window addSubview:suspendBall];
    [window bringSubviewToFront:suspendBall];
}

//点击悬浮球事件
- (void)showSetting{
    UIViewController *topController = [UIApplication sharedApplication].windows[0].rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    MDSettingsViewController* settingViewController = [MDSettingsViewController sharedInstance];
    UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    
    [topController presentViewController:navigationViewController animated:YES completion:^{
        
    }];
}

//限制悬浮球的位置并自动贴左右两边
- (void)gestureMove:(UIPanGestureRecognizer *)pan{
    
    self.backgroundColor = [self.bgColor colorWithAlphaComponent:1];
  
    CGPoint point = [pan locationInView:self.superview];
    self.middleX = point.x;
    self.middleY = point.y;
    
    if(pan.state == UIGestureRecognizerStateEnded){
        if (point.x < 0) {
            [UIView animateWithDuration:0.5 animations:^{
                self.x = 0;
            }];
        }
        
        if ( point.x > MDScreenWidth) {
            [UIView animateWithDuration:0.5 animations:^{
                self.x = MDScreenWidth - self.width;
            }];
        }
        
        if (point.y > MDScreenHeight) {
            [UIView animateWithDuration:0.5 animations:^{
                self.y = MDScreenHeight - self.width;
            }];
        }
        
        if (point.y < 64) {
            [UIView animateWithDuration:0.5 animations:^{
                self.y = 64;
            }];
        }
        
        CGPoint endPoint = [pan locationInView:self.superview];
        
        if (endPoint.x <= MDScreenWidth / 2) {
            [UIView animateWithDuration:0.5 animations:^{
                self.x = 0;
            }];
        }
        
        if (endPoint.x > MDScreenWidth / 2) {
            [UIView animateWithDuration:0.3 animations:^{
                self.x = MDScreenWidth - self.width;
            }];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 animations:^{
                self.backgroundColor = [self.bgColor colorWithAlphaComponent:0.6];
            }];
        });
    }
}

@end
