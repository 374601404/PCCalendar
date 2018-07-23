//
//  PCCalendarHeaderView.m
//  PHHComponentsProj
//
//  Created by 彭煌环 on 2018/7/18.
//  Copyright © 2018年 彭煌环. All rights reserved.
//

#import "PCCalendarHeaderView.h"
#import "CommonUIMacro.h"
#import "UIColor+HexString.h"
#import "NSDate+PCCalendar.h"
#import "UIView+Frame.h"

#define ADAPTIVE_SIZE_FLOAT(a) self.width*((a)/[UIScreen mainScreen].bounds.size.width)

@interface PCCalendarHeaderView()

@property(strong,nonatomic) UILabel *titleLab;      //标题
@property(strong,nonatomic) UIButton *preMonthBtn;    //上一个月
@property(strong,nonatomic) UIButton *nextMonthBtn;   //下一个月
@property(strong,nonatomic) NSMutableArray<UILabel *> *weekDayLabs;//星期

@end

@implementation PCCalendarHeaderView

#pragma mark UIView LifeCycle

+ (instancetype)initWithFrame:(CGRect)frame currentSelectedMonth:(NSDate *)currentSelectedMonth btnClickedHandler:(PCCalendarMonthBtnClicked)btnClickedHandler{
    PCCalendarHeaderView *headerView = [[PCCalendarHeaderView alloc] initWithFrame:frame];
    headerView.currentSelectedMonth = currentSelectedMonth;
    headerView.btnClickedHandler = btnClickedHandler;
    return headerView;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//设置背景色
        [self pc_setupUI];
    }
    return self;
}

- (void)layoutSubviews{
    
    self.preMonthBtn.width = ADAPTIVE_SIZE_FLOAT(17);
    self.preMonthBtn.height = ADAPTIVE_SIZE_FLOAT(13);
    self.preMonthBtn.x = ADAPTIVE_SIZE_FLOAT(19);
    self.preMonthBtn.y = ADAPTIVE_SIZE_FLOAT(16);
    
    self.nextMonthBtn.width = ADAPTIVE_SIZE_FLOAT(17);
    self.nextMonthBtn.height = ADAPTIVE_SIZE_FLOAT(13);
    self.nextMonthBtn.x = self.width - ADAPTIVE_SIZE_FLOAT(17 + 19);
    self.nextMonthBtn.y = ADAPTIVE_SIZE_FLOAT(16);
    
    self.titleLab.width = ADAPTIVE_SIZE_FLOAT(139);
    self.titleLab.height = ADAPTIVE_SIZE_FLOAT(22);
    self.titleLab.centerX = self.centerX;
    self.titleLab.y = ADAPTIVE_SIZE_FLOAT(11);
    
    CGFloat weekleftInset = ADAPTIVE_SIZE_FLOAT(16);
    CGFloat weekY = self.height - ADAPTIVE_SIZE_FLOAT(17 + 9);
    [self.weekDayLabs enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.x = weekleftInset + idx * ADAPTIVE_SIZE_FLOAT(33 + 19);
        obj.y = weekY;
        obj.width = ADAPTIVE_SIZE_FLOAT(33);
        obj.height = ADAPTIVE_SIZE_FLOAT(13);
    }];
    
}

#pragma mark UI setup
- (void)pc_setupUI{
    //设置标题
    [self pc_setupTitleLab];
    //设置切换月份按钮
    [self pc_setupPreAndNextBtn];
    //设置星期
    [self pc_setupWeekLabs];
}


- (void)pc_setupPreAndNextBtn{
    //顶部切换月份按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"yj_common_backstyleOne_normal.png"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"yj_common_backstyleOne_selected.png"] forState:UIControlStateSelected];
    leftBtn.tag = PCCalendarMonthBtn_Previous;
    [leftBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.preMonthBtn = leftBtn;
    [self addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"yj_common_forwardstyleOne_normal.png"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"yj_common_forwardstyleOne_selected.png"] forState:UIControlStateSelected];
    rightBtn.tag = PCCalendarMonthBtn_Next;
    [rightBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.nextMonthBtn = rightBtn;
    [self addSubview:rightBtn];
}

- (void)pc_setupTitleLab{
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.textColor = [UIColor colorWithHexString:@"0x666666"];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:ADAPTIVE_SIZE_FLOAT(16)];
    [self addSubview:dateLabel];
    self.titleLab = dateLabel;
}

- (void)pc_setupWeekLabs{
    NSArray<NSString *> *titles = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = [UIColor colorWithHexString:@"0x333333"];
        lab.text = obj;
        [self addSubview:lab];
        [self.weekDayLabs addObject:lab];
    }];
}

#pragma mark lazy-load components
- (NSArray<UILabel *> *)weekDayLabs{
    if (!_weekDayLabs) {
        _weekDayLabs = [NSMutableArray array];
    }
    return _weekDayLabs;
}

#pragma mark pulic helper
- (void)setCurrentSelectedMonth:(NSDate *)currentSelectedMonth{
    _currentSelectedMonth = currentSelectedMonth;
    NSString *currentMonthStr = [currentSelectedMonth stringWithDateFormat:@"yyyy年MM月"];
    self.titleLab.text = currentMonthStr;
}

#pragma mark private helper

- (void)btnClicked:(UIButton *)btn{
    if (_btnClickedHandler) {
        self.btnClickedHandler(btn.tag);
    }
}

@end
