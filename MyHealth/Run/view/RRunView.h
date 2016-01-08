//
//  RRunView.h
//  MyHealth
//
//  Created by imac on 15/10/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRunButton.h"
#import "RRunLable.h"
@interface RRunView : UIView
@property (nonatomic, strong) RRunButton *stepsBtn;
@property (nonatomic, strong) RRunButton *distanceBtn;
@property (nonatomic, strong) RRunLable *distanceLable;
@property (nonatomic, strong) RRunButton *calorieBtn;
@property (nonatomic, strong) RRunLable *calorieLable;
@property (nonatomic, strong) RRunButton *timeBtn;
@property (nonatomic, strong) RRunLable *timelable;
@property (nonatomic, strong) RRunLable *showLable;
@end
