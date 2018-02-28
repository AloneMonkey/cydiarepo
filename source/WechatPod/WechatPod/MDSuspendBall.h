//
//  SuspendBall.h
//  MDSettingCenter
//
//  Created by AloneMonkey on 2017/10/25.
//  Copyright (c) 2017年 MonkeyDev. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MDSuspendBall : UIButton

/**
 悬浮球的颜色
 */
@property (nonatomic, strong) UIColor* bgColor;

+ (instancetype)sharedInstance;

-(void)addToWindow:(UIWindow*) window;

@end
