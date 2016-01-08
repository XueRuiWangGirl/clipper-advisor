//
//  OneFoodViewController.h
//  MyHealth
//
//  Created by imac on 15/10/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passFoodNameToEatPageDelegate <NSObject>
//向Eat首页传值
- (void)passFoodNameToEatPage:(NSString *)foodName;
@end

@interface OneFoodViewController : UIViewController
@property (nonatomic, weak) id<passFoodNameToEatPageDelegate>delegate;
//存储食物列表传过来的食物名称
@property ( nonatomic, strong) NSString *passFoodName;
//食物热量
@property (nonatomic, assign) NSNumber *passHot;

@end
