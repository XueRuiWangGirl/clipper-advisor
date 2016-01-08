//
//  cityGroup.h
//  MyHealth
//
//  Created by imac on 15/11/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cityGroup : NSObject
/** 这组的标题 */
@property (nonatomic, copy) NSString *title;
/** 这组的所有城市 */
@property (nonatomic, strong) NSArray *cities;
@end
