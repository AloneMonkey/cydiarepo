//
//  SettingForm.m
//  MDSettingCenter
//
//  Created by monkey on 2017/11/5.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import "SettingForm.h"
#import <objc/runtime.h>

@implementation SettingForm{
    NSMutableDictionary *_valuesByKey;
    NSMutableArray *_fieldsArr;
}

+(SettingForm *)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _valuesByKey = [NSMutableDictionary dictionary];
        _fieldsArr = [NSMutableArray array];
    }
    return self;
}

-(void)registerForm:(id<FXForm>) formClass{
    NSString* className = NSStringFromClass([formClass class]);
    if(![className hasSuffix:@"Form"]){
        NSLog(@"register class name must endwith Form");
        return;
    }
    NSString* key = [className substringToIndex:className.length-4];
    
    objc_property_t property = class_getProperty([SettingForm class], [key UTF8String]);
    if(property){
        NSLog(@"class name exists, please change another name");
        return;
    }
    
    objc_property_attribute_t attribute1 = {"T", [[NSString stringWithFormat:@"@\"%@Form\"", key] UTF8String]};
    objc_property_attribute_t attribute2 = {"S", ""};
    objc_property_attribute_t attribute3 = {"N", ""};
    objc_property_attribute_t attribute4 = {"V", [[NSString stringWithFormat:@"_%@", key] UTF8String]};
    objc_property_attribute_t attributesList[] = {attribute1, attribute2, attribute3, attribute4};
    class_addProperty([SettingForm class], [key UTF8String], attributesList, 4);
    
    if([formClass respondsToSelector:@selector(setting)]){
        NSMutableDictionary* settings = [[formClass performSelector:@selector(setting)] mutableCopy];
        [settings setValue:key forKey:FXFormFieldKey];
        [_fieldsArr addObject:settings];
    }
    
    [self setValue:formClass forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if (value){
        _valuesByKey[key] = value;
    }else{
        [_valuesByKey removeObjectForKey:key];
    }
}

- (id)valueForUndefinedKey:(NSString *)key{
    return _valuesByKey[key];
}

- (NSArray *)fields{
    return _fieldsArr;
}

@end
