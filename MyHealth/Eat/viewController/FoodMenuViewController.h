//
//  FoodMenuViewController.h
//  MyHealth
//
//  Created by imac on 15/10/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passFoodNameDelegate <NSObject>
//传值（食物名称）
- (void)passFoodName:(NSString *)foodName;
//传值（食物信息）
- (void)passFoodDic:(NSDictionary *)foodDic;
@end
@interface FoodMenuViewController : UIViewController
@property (nonatomic, weak)id<passFoodNameDelegate> delegate;
@end
