//
//  OneFoodModel.h
//  MyHealth
//
//  Created by imac on 15/11/3.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneFoodModel : NSObject
//食物图片
@property (nonatomic, strong) NSString *foodImage;
//食物名称
@property (nonatomic, strong) NSString *foodName;
//食物描述，section2
@property (nonatomic, strong) NSString *foodDesc;
//热量(大卡、卡路里)，detail
@property (nonatomic, assign) NSString *calorie;
//评价，section3
@property (nonatomic, strong) NSString *evaluation;
//热量
@property (nonatomic, assign) NSNumber *foodHot;

+ (id)foodInfoWithDict:(NSDictionary *)dict;
- (id)initWithDict:(NSDictionary *)dict;
@end
