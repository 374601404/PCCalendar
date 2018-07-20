//
//  NSDate+PCCalendar.h
//  PHHComponentsProj
//
//  Copy from YBCalendar:https://github.com/gaoyanbin1314/YBCalendar
//

#import <Foundation/Foundation.h>

@interface NSDate (PCCalendar)

- (NSString *)stringWithDateFormat:(NSString *)dateFormat;
// 获取date当前月的第一天是星期几 return:(周日)0--(周六)6
- (NSInteger)weekdayOfMonthFirstDay;

//获取当前的时间 NSDateComponents 对象
- (NSDateComponents *)components;
//添加day天后的date
- (NSDate *)dateAddDay:(NSInteger)day;

//返回上个月的date
- (NSDate *)preMonthDate;

//返回下个月的date
- (NSDate *)nextMonthDate;

//加上month个月后的的date
- (NSDate *)dateAddMonth:(NSInteger)month;

//与另一个date比较是否为同一个月
- (NSComparisonResult)compareByMonthWith:(NSDate *)anotherDate;

- (BOOL)isToday;

- (BOOL)isTheSameDay:(NSDate *)date;

@end
