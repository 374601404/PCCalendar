//
//  PCCalendarView.h
//  PHHComponentsProj
//
//  Created by 彭煌环 on 2018/7/16.
//  Copyright © 2018年 彭煌环. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CalendarDateClickedHandler)(NSDate *date);

@interface PCCalendarView : UIView

@property(strong,nonatomic) NSDate *selectedDate;   //设置选中的日期
@property(copy,nonatomic) CalendarDateClickedHandler handler;

//frame的宽高比例应为375:330,handler可为空
+ (instancetype)initWithFrame:(CGRect)frame CalendarDateClickedHandler:(CalendarDateClickedHandler)handler;

@end
