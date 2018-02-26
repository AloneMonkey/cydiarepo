//
//  StoneTweak.mm
//  StoneTweak
//
//  Created by AloneMonkey on 2018/2/26.
//  Copyright (c) 2018年 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"

CHDeclareClass(YWSDevice);

CHOptimizedMethod0(self, BOOL, YWSDevice, isJailbrokenDevice){
    return NO;
}

CHConstructor{
	@autoreleasepool{
		CHLoadLateClass(YWSDevice);
		CHHook0(YWSDevice, isJailbrokenDevice);
	}
}
