//
//  WeChatRequestHook.m
//  WechatPod
//
//  Created by monkey on 2017/8/5.
//  Copyright © 2017年 Coder. All rights reserved.
//

/**
     1. 修改bundle id
 */

#import <CaptainHook/CaptainHook.h>
#import <Foundation/Foundation.h>

#pragma mark ManualAuthAesReqData

CHDeclareClass(ManualAuthAesReqData)

CHOptimizedMethod1(self, void, ManualAuthAesReqData, setBundleId, NSString*, bundleId){
    bundleId = @"com.tencent.xin";
    CHSuper1(ManualAuthAesReqData, setBundleId, bundleId);
}

CHConstructor{
    CHLoadLateClass(ManualAuthAesReqData);
    CHClassHook1(ManualAuthAesReqData, setBundleId);
}

