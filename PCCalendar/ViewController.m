//
//  ViewController.m
//  PCCalendar
//
//  Created by 彭煌环 on 2018/7/20.
//  Copyright © 2018年 彭煌环. All rights reserved.
//

#import "ViewController.h"
#import "PCCalendarView.h"
#import "CommonUIMacro.h"
#import "NSDate+PCCalendar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    PCCalendarView *calendarView = [PCCalendarView initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH/1.0, 330 * SCREEN_WIDTH/375.f/1.0) CalendarDateClickedHandler:^(NSDate *date) {
        NSLog(@"点击的日期为:%@",[date stringWithDateFormat:@"yyyy年MM月"]);
    }];
    calendarView.selectedDate = [NSDate date];
    [self.view addSubview:calendarView];
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(80, 500, 100, 50)];
    shadowView.backgroundColor = [UIColor redColor];
    shadowView.layer.cornerRadius = 5.0;
    shadowView.layer.shadowColor = [UIColor whiteColor].CGColor;
    shadowView.layer.shadowRadius = 10.f;
    shadowView.layer.shadowOffset = CGSizeMake(5, 5);
    shadowView.layer.shadowOpacity = 1.0;
    [self.view addSubview:shadowView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
