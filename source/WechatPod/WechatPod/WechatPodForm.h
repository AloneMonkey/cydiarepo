//
//  WechatPodForm.h
//  WechatPod
//
//  Created by monkey on 2017/11/5.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSettingCenter.h"
#import <CoreLocation/CoreLocation.h>

@class WechatPodForm;

extern WechatPodForm* pluginConfig;

typedef NS_OPTIONS(NSInteger, MorraType)
{
    //segment 必须0开始
    MorraTypeScissors = 0,
    MorraTypeStone,
    MorraTypeCloth
};

//必须以Form结尾
@interface WechatPodForm : NSObject <FXForm>

+(WechatPodForm*)sharedInstance;

@property (nonatomic, assign) BOOL revoke;
@property (nonatomic, copy) NSString *step;
@property (nonatomic, assign) MorraType morra;
@property (nonatomic, assign) NSUInteger dice;
@property (nonatomic, assign) CLLocationCoordinate2D location;

- (NSUInteger) finalMorra;
- (NSUInteger) finalDice;

@end
