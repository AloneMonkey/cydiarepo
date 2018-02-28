//
//  SettingForm.h
//  MDSettingCenter
//
//  Created by monkey on 2017/11/5.
//  Copyright © 2017年 Coder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"

@interface SettingForm : NSObject <FXForm>

+(SettingForm*)sharedInstance;

-(void)registerForm:(id<FXForm>) formClass;

@end
