//
//  OneDayView.h
//  MyHealth
//
//  Created by imac on 15/10/27.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneDayView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *breakfast_text;
@property (nonatomic, strong) UITableView *lunch_text;
@property (nonatomic, strong) UITableView *dinner_text;
@property (nonatomic, strong) NSMutableArray *array;
//早餐食物名称
@property (nonatomic, strong) NSMutableArray *breakFastArr;
//午餐食物名称
@property (nonatomic, strong) NSMutableArray *lunchArr;
//晚餐食物名称
@property (nonatomic, strong) NSMutableArray *dinnerArr;
@property (nonatomic, strong) UIButton *breakfastBtn;
@property (nonatomic, strong) UIButton *lunchBtn;
@property (nonatomic, strong) UIButton *dinnerBtn;
@property (nonatomic, strong) NSMutableArray *passBreakfastArr;
@property (nonatomic, strong) NSMutableArray *passLunchArr;
@property (nonatomic, strong) NSMutableArray *passDinnerArr;
@property (nonatomic, strong) NSMutableArray *getBreakfastArr;
@property (nonatomic, strong) NSMutableArray *getLunchArr;
@property (nonatomic, strong) NSMutableArray *getDinnerArr;

@end
