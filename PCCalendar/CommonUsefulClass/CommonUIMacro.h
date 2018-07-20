//
//  CommonUIMacro.h
//  PHHComponentsProj
//
//  Created by 彭煌环 on 2018/7/17.
//  Copyright © 2018年 彭煌环. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define ADAPTIVEWITH_STANDARD(a) [UIScreen mainScreen].bounds.size.width*((a)/375.f)
#define ADAPTIVEHEIGHT_STANDARD(b) [UIScreen mainScreen].bounds.size.height*((b)/667.f)

@interface CommonUIMacro : NSObject

@end
