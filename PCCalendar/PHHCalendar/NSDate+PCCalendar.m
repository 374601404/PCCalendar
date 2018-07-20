//
//  NSDate+PCCalendar.m
//  PHHComponentsProj
//
//  Copy from YBCalendar:https://github.com/gaoyanbin1314/YBCalendar
//

#import "NSDate+PCCalendar.h"

@implementation NSDate (PCCalendar)

- (NSString *)stringWithDateFormat:(NSString *)dateFormat{NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

- (NSInteger)weekdayOfMonthFirstDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//设置星期一起始 为 1
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [components setDay:1];
    NSDate *firstDate = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDate];
    return firstComponents.weekday - 1;
}

- (NSDateComponents *)components{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //定义时间成分的组成 位字段
    NSCalendarUnit unit =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self];
}

- (NSDate *)dateAddDay:(NSInteger)day{
    NSTimeInterval timeinterval = [self timeIntervalSince1970];
    timeinterval += day * 24 * 60 * 60;
    return [NSDate dateWithTimeIntervalSince1970:timeinterval];
}

- (NSDate *)preMonthDate{
    return [self dateAddMonth:-1];
}

- (NSDate *)nextMonthDate{
    return [self dateAddMonth:1];
}

- (NSDate *)dateAddMonth:(NSInteger)month{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *lastDateComponents = [[NSDateComponents alloc] init];
    [lastDateComponents setMonth:month];
    //calendar caculation
    NSDate *newDate = [calendar dateByAddingComponents:lastDateComponents toDate:self options:0];
    return newDate;
}

- (NSComparisonResult)compareByMonthWith:(NSDate *)anotherDate{
    NSString *curMonth = [self stringWithDateFormat:@"yyyy.MM"];
    NSString *anotherMonth = [anotherDate stringWithDateFormat:@"yyyy.MM"];
    return [curMonth compare:anotherMonth];
}

- (BOOL)isToday{
    return [self calWithValue:0];
}

- (BOOL)isTheSameDay:(NSDate *)date{
    //得到给定时间的处理后的时间的components
    NSDateComponents *dateComponents=self.ymdDate.components;
    
    //得到当前时间的处理后的时间的components
    NSDateComponents *nowComponents=date.ymdDate.components;
    
    //比较
    BOOL res=dateComponents.year==nowComponents.year && dateComponents.month==nowComponents.month && dateComponents.day==nowComponents.day;
    
    return res;
}


#pragma mark private helper
-(BOOL)calWithValue:(NSInteger)value{
    
    //得到给定时间的处理后的时间的components
    NSDateComponents *dateComponents=self.ymdDate.components;
    
    //得到当前时间的处理后的时间的components
    NSDateComponents *nowComponents=[NSDate date].ymdDate.components;
    
    //比较
    BOOL res=dateComponents.year==nowComponents.year && dateComponents.month==nowComponents.month && (dateComponents.day + value)==nowComponents.day;
    
    return res;
}

/*
 *  清空时分秒，保留年月日
 */
-(NSDate *)ymdDate{
    
    //定义fmt
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    
    //设置格式:去除时分秒
    fmt.dateFormat=@"yyyy-MM-dd";
    
    //得到字符串格式的时间
    NSString *dateString=[fmt stringFromDate:self];
    
    //再转为date
    NSDate *date=[fmt dateFromString:dateString];
    
    return date;
}

@end
