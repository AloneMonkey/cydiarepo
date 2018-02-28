//
//  WeChatMessageHook.m
//  WechatPod
//
//  Created by monkey on 2017/8/2.
//  Copyright © 2017年 Coder. All rights reserved.
//

/**
     1. 消息防撤回
     2. 游戏作弊
 */

#import <CaptainHook/CaptainHook.h>
#import "WeChatHeader.h"
#import "WeChatServiceManager.h"
#import "WechatPodForm.h"
#import <Foundation/Foundation.h>

CHDeclareClass(CMessageMgr);

CHOptimizedMethod1(self, void, CMessageMgr, onRevokeMsg,CMessageWrap*, msgWrap){
    BOOL isSender = [objc_getClass("CMessageWrap") isSenderFromMsgWrap:msgWrap];
    
    if(!pluginConfig.revoke || isSender){
        CHSuper1(CMessageMgr, onRevokeMsg, msgWrap);
        return;
    }
    
    CMessageWrap *newMsgWrap = [[objc_getClass("CMessageWrap") alloc] initWithMsgType:0x2710];
    
    NSString* revokePersonName = nil;
    
    //获取撤回人
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<!\\[CDATA\\[(.*?)撤回了一条消息\\]\\]>" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *result = [regex matchesInString:msgWrap.m_nsContent options:0 range:NSMakeRange(0, msgWrap.m_nsContent.length)].firstObject;
    
    if (result.numberOfRanges >= 2) {
        revokePersonName = [msgWrap.m_nsContent substringWithRange:[result rangeAtIndex:1]];
    }
    
    NSString* sendContent = [NSString stringWithFormat:@"已阻止 %@ 将消息撤回", revokePersonName ? revokePersonName : msgWrap.m_nsFromUsr];
    
    [newMsgWrap setM_uiStatus:0x4];
    [newMsgWrap setM_nsContent:sendContent];
    [newMsgWrap setM_nsToUsr:msgWrap.m_nsToUsr];
    [newMsgWrap setM_nsFromUsr:msgWrap.m_nsFromUsr];
    [newMsgWrap setM_uiCreateTime:[msgWrap m_uiCreateTime]];
    
    [[WeChatServiceManager sharedCMessageMgr] AddLocalMsg:msgWrap.m_nsFromUsr MsgWrap:newMsgWrap];
}

CHOptimizedMethod2(self, void, CMessageMgr, AddEmoticonMsg, NSString*, msg, MsgWrap, CMessageWrap*, msgWrap){
    
    //1   猜拳   2  骰子  0  自定义表情
    if([msgWrap m_uiMessageType] == 47 && ([msgWrap m_uiGameType] == 2|| [msgWrap m_uiGameType] == 1)){
        
        NSInteger random = 0;
        
        if(([msgWrap m_uiGameType] == 1 && pluginConfig.finalMorra >= 1 && pluginConfig.finalMorra <= 3)){
            random = pluginConfig.finalMorra;
        }
        
        if(([msgWrap m_uiGameType] == 2 && pluginConfig.finalDice >=4 && pluginConfig.finalDice <= 9)){
             random = pluginConfig.finalDice;
        }
        
        if(random > 0 && random < 10){
            [msgWrap setM_nsEmoticonMD5:[objc_getClass("GameController") getMD5ByGameContent:random]];
            [msgWrap setM_uiGameContent:random];
        }
    }
    
    CHSuper2(CMessageMgr, AddEmoticonMsg, msg, MsgWrap, msgWrap);
}

CHConstructor{
    CHLoadLateClass(CMessageMgr);
    CHClassHook1(CMessageMgr, onRevokeMsg);
    CHClassHook2(CMessageMgr, AddEmoticonMsg, MsgWrap);
}
