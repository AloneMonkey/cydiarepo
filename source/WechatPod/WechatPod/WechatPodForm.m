//
//  WechatPodForm.m
//  WechatPod
//
//  Created by monkey on 2017/11/5.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <CaptainHook/CaptainHook.h>
#import "WechatPodForm.h"

WechatPodForm* pluginConfig = nil;

@implementation WechatPodForm{
    CLLocationCoordinate2D _coordinate;
}

+(WechatPodForm *)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _step = 0;
        _location = CLLocationCoordinate2DMake(0,0);
        _revoke = YES;
        _morra = 0;
        _dice = 6;
    }
    return self;
}

-(NSUInteger)finalMorra{
    return _morra + 1;
}

-(NSUInteger)finalDice{
    return _dice + 3;
}

- (NSArray *)fields
{
    return @[
             @{FXFormFieldKey: @"revoke",
               FXFormFieldTitle: @"防撤回"
               },
             @{FXFormFieldKey: @"step",
               FXFormFieldType: FXFormFieldTypeInteger,
               FXFormFieldTitle: @"微信步数"
               },
             @{FXFormFieldKey: @"morra",
               FXFormFieldTitle: @"猜拳",
               FXFormFieldOptions: @[@"剪刀", @"石头", @"布"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]
               },
             @{FXFormFieldKey: @"dice",
               FXFormFieldTitle: @"骰子点数",
               @"stepper.minimumValue": @(1),
               @"stepper.maximumValue": @(6),
               FXFormFieldCell: [FXFormStepperCell class]
               },
             @{FXFormFieldKey: @"location",
               FXFormFieldTitle: @"修改定位",
               FXFormFieldViewController: @"WechatMapViewController"
               }
             ];
}

-(NSDictionary*)setting{
    return @{
             FXFormFieldHeader: @"WECHATPOD",
             FXFormFieldFooter: @"by AloneMonkey",
             FXFormFieldTitle: @"WechatPod",
             FXFormFieldInline: @YES   //首页还是在内部VC显示
             };
}

@end

CHConstructor{
    pluginConfig = [WechatPodForm sharedInstance];
    [[SettingForm sharedInstance] registerForm:pluginConfig];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[MDSuspendBall sharedInstance] addToWindow:nil];
    });
}
