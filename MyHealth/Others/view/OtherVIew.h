//
//  OtherVIew.h
//  MyHealth
//
//  Created by imac on 15/10/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherLab.h"
#define StepLabX ([UIScreen mainScreen].bounds.size.width)/3.4
#define StepLabY ([UIScreen mainScreen].bounds.size.height)/4
//#define showLabX ([UIScreen mainScreen].bounds.size.width)-280
//#define showLabY ([UIScreen mainScreen].bounds.size.height)-360
#define achvLabX ([UIScreen mainScreen].bounds.size.width)/3.2
#define achvLabY ([UIScreen mainScreen].bounds.size.height)/2.5
@interface OtherVIew : UIView
@property (nonatomic,strong)OtherLab *StepLab;
@property (nonatomic,strong)OtherLab *achivLab;
//@property (nonatomic,strong)OtherLab *showStepLab;

@end
