//
//  PCCalendarView.m
//  PHHComponentsProj
//
//  Created by 彭煌环 on 2018/7/16.
//  Copyright © 2018年 彭煌环. All rights reserved.
//

#import "PCCalendarView.h"
#import "CommonUIMacro.h"
#import "UIColor+HexString.h"
#import "PCCalendarHeaderView.h"
#import "PCCalendarScrollView.h"


@interface PCCalendarView()

@property(strong,nonatomic)PCCalendarHeaderView *headerView;
@property(strong,nonatomic)PCCalendarScrollView *calendarScrollView;


@end


@implementation PCCalendarView

- (void)setSelectedDate:(NSDate *)selectedDate{
    _selectedDate = selectedDate;
    self.headerView.currentSelectedMonth = selectedDate;
    self.calendarScrollView.date = selectedDate;
}

#pragma mark UIView LifeCycle
+ (instancetype)initWithFrame:(CGRect)frame CalendarDateClickedHandler:(CalendarDateClickedHandler)handler{
    PCCalendarView *calendarView = [[PCCalendarView alloc] initWithFrame:frame];
    calendarView.handler = handler;
    return calendarView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self pc_setpUI];
        [self addObserver];
    }
    return self;
}

- (void)dealloc{
    [self.calendarScrollView removeObserver:self forKeyPath:@"date"];
    [self.calendarScrollView removeObserver:self forKeyPath:@"currMonthCollectionView.selectedDate"];
}

#pragma mark private helper
- (void)pc_setpUI{
    __weak typeof(self) weakSelf = self;
    _headerView = [PCCalendarHeaderView initWithFrame:CGRectMake(0, 0, self.frame.size.width, 82/375.f * self.frame.size.width) currentSelectedMonth:self.selectedDate ? self.selectedDate:[NSDate date] btnClickedHandler:^(PCCalendarMonthBtnType type) {
        if (type == PCCalendarMonthBtn_Previous) {
            [weakSelf.calendarScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        } else if(type == PCCalendarMonthBtn_Next){
            [weakSelf.calendarScrollView setContentOffset:CGPointMake(weakSelf.frame.size.width * 2, 0) animated:YES];
        }
    }];
    [self addSubview:self.headerView];
    _calendarScrollView = [[PCCalendarScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), self.frame.size.width, self.frame.size.width *(330 - 82)/375.f)];
    [self addSubview:self.calendarScrollView];
}

- (void)addObserver{
    [self.calendarScrollView addObserver:self forKeyPath:@"date" options:NSKeyValueObservingOptionNew context:nil];
    [self.calendarScrollView addObserver:self forKeyPath:@"currMonthCollectionView.selectedDate" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //key-value observing 解耦
    if ([keyPath isEqualToString:@"currMonthCollectionView.selectedDate"]) {
        NSDate *date = change[NSKeyValueChangeNewKey];
        if (self.handler) {
            self.handler(date);
        }
    }
    if ([keyPath isEqualToString:@"date"]) {
        NSDate *newDate = change[NSKeyValueChangeNewKey];
        self.headerView.currentSelectedMonth = newDate;
    }
}

@end
