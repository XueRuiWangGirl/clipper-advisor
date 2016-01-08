//
//  QSPerson.m
//  MyHealth
//
//  Created by 秦森 on 15/10/25.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "QSPerson.h"

@interface QSPerson ()

@end

@implementation QSPerson

- (NSMutableArray *)allSettingArray
{
    //@[@"出生年份",@"性别",@"血型",@"星座",@"身高",@"体重",@"期望体重"];
    if (!_allSettingArray) {
        _allSettingArray = [[NSMutableArray alloc]initWithObjects:@"出生年份",@"性别",@"血型",@"星座",@"身高",@"体重",@"期望体重", nil];
    }
    return _allSettingArray;
}

- (NSArray *)firstLineArray
{
    if (!_firstLineArray) {
        _firstLineArray = @[@"年龄",@"性别",@"血型",@"星座"];
    }
    return _firstLineArray;
}

- (NSArray *)secondLineArray
{
    if (!_secondLineArray) {
        _secondLineArray = @[@"身高",@"体重",@"期望体重"];
    }
    return _secondLineArray;
}

- (NSArray *)thirdLineArray
{
    if (!_thirdLineArray) {
        _thirdLineArray = @[@"BMI",@"体型评价"];
    }
    return _thirdLineArray;
}

@end
