//
//  QSHealth.h
//  MyHealth
//
//  Created by 秦森 on 15/10/25.
//  Copyright © 2015年 imac. All rights reserved.
//
//健康信息推荐的数据层封装

#import <Foundation/Foundation.h>

@interface QSHealth : NSObject

@property (nonatomic, strong) NSArray *informationArray;//临时的信息显示（后期会更改）

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *desc;

@end
