//
//  searchCity.h
//  MyHealth
//
//  Created by imac on 15/11/10.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchCity : NSObject
/** 城市名字 */
@property (nonatomic, copy) NSString *name;
/** 城市名字的拼音 */
@property (nonatomic, copy) NSString *pinYin;
/** 城市名字的拼音声母 */
@property (nonatomic, copy) NSString *pinYinHead;
/** 区域(存放的都是MTRegion模型) */
@property (nonatomic, strong) NSArray *regions;
@end
