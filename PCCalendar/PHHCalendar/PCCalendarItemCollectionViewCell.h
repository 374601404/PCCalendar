//
//  PCCalendarItemCollectionViewCell.h
//  PHHComponentsProj
//
//  Created by 彭煌环 on 2018/7/18.
//  Copyright © 2018年 彭煌环. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PCCalendarItemType){
    PCCalendarItemType_CurrMon = 0,
    PCCalendarItemType_PrevMon,
    PCCalendarItemType_NextMon,
    PCCalendarItemType_Today,
    PCCalendarItemType_Selected
};

@interface PCCalendarItemCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (assign,nonatomic) PCCalendarItemType type;

@end
