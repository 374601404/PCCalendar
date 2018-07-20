//
//  PCCalendarScrollView.m
//  PHHComponentsProj
//
//  Created by 彭煌环 on 2018/7/19.
//  Copyright © 2018年 彭煌环. All rights reserved.
//

#import "PCCalendarScrollView.h"
#import "UIView+Frame.h"
#import "PCCalendarCollectionView.h"
#import "NSDate+PCCalendar.h"

@interface PCCalendarScrollView()<UIScrollViewDelegate>

@property(strong,nonatomic) PCCalendarCollectionView *preMonthCollectionView;
@property(strong,nonatomic) PCCalendarCollectionView *currMonthCollectionView;
@property(strong,nonatomic) PCCalendarCollectionView *nextMonthCollectionView;

@end

@implementation PCCalendarScrollView

- (void)setDate:(NSDate *)date{
    _date = date;
    [self pc_updateScrollView]; //更新3个Collectionview的数据，并重置偏移量
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(self.width * 3, self.height);
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        [self pc_setupUI];
    }
    return self;
}

- (void)pc_setupUI{
    //上月
    self.preMonthCollectionView = [[PCCalendarCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:self.preMonthCollectionView];
    //当月
    self.currMonthCollectionView = [[PCCalendarCollectionView alloc] initWithFrame:CGRectMake(self.width, 0, self.width, self.height)];
    [self addSubview:self.currMonthCollectionView];
    //下月
    self.nextMonthCollectionView = [[PCCalendarCollectionView alloc] initWithFrame:CGRectMake(self.width * 2, 0, self.width, self.height)];
    [self addSubview:self.nextMonthCollectionView];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //切换的精髓
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (contentOffsetX <= 0) {
        //上页
        self.date = [self.date preMonthDate];
    } else if(contentOffsetX >= (scrollView.width * 2 - 2)){//减2很关键 在宽度尺寸不标准时，contentOffsetX可能略小于scrollView.width * 2
        //下页
        self.date = [self.date nextMonthDate];
    }
}

#pragma mark private helper
- (void)pc_updateScrollView{
    self.preMonthCollectionView.date = [self.date preMonthDate];
    self.currMonthCollectionView.date = self.date;
    self.nextMonthCollectionView.date = [self.date nextMonthDate];
    self.contentOffset = CGPointMake(self.frame.size.width, 0); //重置偏移量，循环
}

@end
