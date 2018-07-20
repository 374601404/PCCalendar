//
//  PCCalendarCollectionView.m
//  PHHComponentsProj
//
//  Created by 彭煌环 on 2018/7/18.
//  Copyright © 2018年 彭煌环. All rights reserved.
//

#import "PCCalendarCollectionView.h"
#import "NSDate+PCCalendar.h"
#import "UIView+Frame.h"
#import "PCCalendarItemCollectionViewCell.h"

@interface PCCalendarCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong,nonatomic)NSDate *selectedDate;//选中的日子
@property(strong,nonatomic)NSIndexPath *selectedIndexpath;

@end

@implementation PCCalendarCollectionView

- (void)setDate:(NSDate *)date{
    _date = date;
    [self reloadData];//重载数据
}

- (instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.itemSize = CGSizeMake(frame.size.width *(34.f/[UIScreen mainScreen].bounds.size.width), frame.size.width *(34.f/[UIScreen mainScreen].bounds.size.width));
    collectionViewLayout.minimumLineSpacing = frame.size.width *(5.f/[UIScreen mainScreen].bounds.size.width);
    collectionViewLayout.minimumInteritemSpacing = frame.size.width *(18.f/[UIScreen mainScreen].bounds.size.width);
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, frame.size.width *(14.f/[UIScreen mainScreen].bounds.size.width), 0, frame.size.width *(14.f/[UIScreen mainScreen].bounds.size.width));//日历距左右间距为14.5f
    
    self = [super initWithFrame:frame collectionViewLayout:collectionViewLayout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];    //背景色
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([PCCalendarItemCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([PCCalendarItemCollectionViewCell class])];
    }
    return self;
}


#pragma mark private helper
- (NSDate *)getDateFromIndexPath:(NSIndexPath *)indexPath{
    //本月的第一天是周几 0--6
    NSInteger firstWeekday = [_date weekdayOfMonthFirstDay];
    //与今天差多少天 日历第一行开始显示当月的日期
    NSInteger day = (firstWeekday + 1) + (self.date.components.day - 1) - (indexPath.row + 1);
    return [self.date dateAddDay:-day];
}

- (void)updateSelectedIndexPath:(NSIndexPath *)indexPath{
    PCCalendarItemCollectionViewCell *cell = (PCCalendarItemCollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
    if (cell.type != PCCalendarItemType_Selected) {
        [self reloadData];
    }
}

- (void)updateContentOffset{
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    if ([self.selectedDate compareByMonthWith:self.date] == NSOrderedAscending) {//上个月
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if([self.selectedDate compareByMonthWith:self.date] == NSOrderedDescending){//下个月
        [scrollView setContentOffset:CGPointMake(scrollView.width * 2, 0) animated:YES];
    }
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6 * 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PCCalendarItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PCCalendarItemCollectionViewCell class]) forIndexPath:indexPath];
    //获取indexpath对应的日期
    NSDate *date = [self getDateFromIndexPath:indexPath];
    NSInteger day = date.components.day;
    NSString *dayStr = @(day).stringValue;
    cell.contentLab.text = dayStr;
    //根据日期设置效果
    if ([date compareByMonthWith:self.date] == NSOrderedAscending) {
        cell.type = PCCalendarItemType_PrevMon;
    } else if([date compareByMonthWith:self.date] == NSOrderedDescending){
        cell.type = PCCalendarItemType_NextMon;
    }else{
        if ([date isToday]) {
            cell.type = PCCalendarItemType_Today;
        } else {
            cell.type = PCCalendarItemType_CurrMon;
        }
    }
    
    if ([date isTheSameDay:self.selectedDate]) {
        cell.type = PCCalendarItemType_Selected;//选中效果
    }
    
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectedDate = [self getDateFromIndexPath:indexPath];
    //可选-更新偏移量
    [self updateContentOffset];
    //更新选中状态
    [self updateSelectedIndexPath:indexPath];
}

@end
