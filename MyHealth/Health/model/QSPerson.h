//
//  QSPerson.h
//  MyHealth
//
//  Created by 秦森 on 15/10/25.
//  Copyright © 2015年 imac. All rights reserved.
//
//个人信息的数据层，用于封装个人信息的数据

#import <Foundation/Foundation.h>

@interface QSPerson : NSObject

@property (nonatomic, strong) NSMutableArray *allSettingArray;//所有信息的名字

@property (nonatomic, strong) NSArray *firstLineArray;//信息显示窗口第一行的信息内容

@property (nonatomic, strong) NSArray *secondLineArray;//信息显示窗口第二行的信息内容

@property (nonatomic, strong) NSArray *thirdLineArray;//信息显示窗口第三行的信息内容

@end
