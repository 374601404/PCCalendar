//
//  PCCalendarHeaderView.h
//  PHHComponentsProj
//
//  Created by 彭煌环 on 2018/7/18.
//  Copyright © 2018年 彭煌环. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PCCalendarMonthBtnType){
    PCCalendarMonthBtn_Previous = 0,   //上一个月
    PCCalendarMonthBtn_Next = 1        //下一个月
};

typedef void (^PCCalendarMonthBtnClicked)(PCCalendarMonthBtnType type); //按钮点击block

@interface PCCalendarHeaderView : UIView

@property(strong,nonatomic) NSDate *currentSelectedMonth;   //当前的月份
@property(copy,nonatomic) PCCalendarMonthBtnClicked btnClickedHandler;

+ (instancetype)initWithFrame:(CGRect)frame currentSelectedMonth:(NSDate *)currentSelectedMonth btnClickedHandler:(PCCalendarMonthBtnClicked)btnClickedHandler;

@end
