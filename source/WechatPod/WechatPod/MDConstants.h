//
//  MDConstants.h
//  MDSettingCenter
//
//  Created by AloneMonkey on 2017/10/26.
//  Copyright © 2017年 MonkeyDev. All rights reserved.
//

#ifndef MDConstants_h
#define MDConstants_h

#import <UIKit/UIKit.h>

#define MDWeakSelf(self) autoreleasepool{} __weak typeof(self) weakSelf = self;

#define MDScreenHeight             UIScreen.mainScreen.bounds.size.height
#define MDScreenWidth              UIScreen.mainScreen.bounds.size.width
#define MDScreenSize               UIScreen.mainScreen.bounds.size

#define MD_SINGLE_LINE_WIDTH       (1.0/[UIScreen mainScreen].scale)

#define MDFont9                [UIFont systemFontOfSize:9]
#define MDFont10               [UIFont systemFontOfSize:10]
#define MDFont11               [UIFont systemFontOfSize:11]
#define MDFont12               [UIFont systemFontOfSize:12]
#define MDFont13               [UIFont systemFontOfSize:13]
#define MDFont14               [UIFont systemFontOfSize:14]
#define MDFont15               [UIFont systemFontOfSize:15]
#define MDFont16               [UIFont systemFontOfSize:16]
#define MDFont17               [UIFont systemFontOfSize:17]
#define MDFont18               [UIFont systemFontOfSize:18]
#define MDFont19               [UIFont systemFontOfSize:19]
#define MDFont21               [UIFont systemFontOfSize:21]
#define MDFont24               [UIFont systemFontOfSize:24]
#define MDFont25               [UIFont systemFontOfSize:25]

extern CGFloat const kLeftMargin;
extern CGFloat const kRightMargin;

#define MD_COPYRIGHT           @"MSSettingCenter For MonkeyDev"
#define MD_DONE                @"完成"

#endif /* MDConstants_h */
