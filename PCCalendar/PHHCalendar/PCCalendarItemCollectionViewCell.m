//
//  PCCalendarItemCollectionViewCell.m
//  PHHComponentsProj
//
//  Created by 彭煌环 on 2018/7/18.
//  Copyright © 2018年 彭煌环. All rights reserved.
//

#import "PCCalendarItemCollectionViewCell.h"
#import "UIView+Frame.h"
#import "UIColor+HexString.h"

@implementation PCCalendarItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

//UIView生命周期方法首先执行，在这里初始化
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    self.contentLab.layer.cornerRadius = self.width/2.0f;
    self.contentLab.layer.masksToBounds = YES;
}

- (void)setType:(PCCalendarItemType)type{
    _type = type;
    //为了避免复用出现问题，重置cell的设置
    self.contentLab.textColor = [UIColor colorWithHexString:@"0x2E2E39"];
    self.contentLab.backgroundColor = [UIColor whiteColor];
    
    switch (type) {
        case PCCalendarItemType_CurrMon:
            self.contentLab.textColor = [UIColor colorWithHexString:@"2E2E39"];
//            self.contentLab.font = [UIFont fontWithName:@"" size:16];无.SFNSDisplay字体
            break;
            
        case PCCalendarItemType_PrevMon:
            self.contentLab.textColor = [UIColor colorWithHexString:@"D7D7D7"];
            break;
            
        case PCCalendarItemType_NextMon:
            self.contentLab.textColor = [UIColor colorWithHexString:@"D7D7D7"];
            break;
            
        case PCCalendarItemType_Today:
            self.contentLab.textColor = [UIColor colorWithHexString:@"0xFBB300"];
            break;
            
        case PCCalendarItemType_Selected:
            self.contentLab.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
            self.contentLab.backgroundColor = [UIColor colorWithHexString:@"FBB300"];
            break;
            
        default:
            self.contentLab.textColor = [UIColor colorWithHexString:@"2E2E39"];
            break;
    }
}

@end
