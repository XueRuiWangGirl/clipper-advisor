//
//  RRunViewController.h
//  MyHealth
//
//  Created by imac on 15/10/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MainViewController.h"
@import HealthKit;

@interface RRunViewController : MainViewController

@property (nonatomic) HKHealthStore *healthStore;
@end
