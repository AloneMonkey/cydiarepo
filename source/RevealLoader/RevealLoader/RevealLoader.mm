//
//  RevealLoader.mm
//  RevealLoader
//
//  Created by AloneMonkey on 2018/2/28.
//  Copyright (c) 2018年 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import <dlfcn.h>
#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"

#define SETTING_FILE_PARH       @"/var/mobile/Library/Preferences/com.alonemonkey.RevealLoader.plist"
#define REVEAL_LIBRARY_PATH     @"/Library/RevealLoader/libReveal.dylib"

CHConstructor
{
	@autoreleasepool
	{
        NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:SETTING_FILE_PARH];
        NSString *libraryPath = REVEAL_LIBRARY_PATH;
        
        if([[prefs objectForKey:[NSString stringWithFormat:@"RevealEnabled-%@", [[NSBundle mainBundle] bundleIdentifier]]] boolValue]) {
            if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]){
                dlopen([libraryPath UTF8String], RTLD_NOW);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"IBARevealRequestStart" object:nil];
                NSLog(@"RevealLoader loaded %@", libraryPath);
            }
        }
	}
}
