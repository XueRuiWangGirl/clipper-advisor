//
//  RRunView.m
//  MyHealth
//
//  Created by imac on 15/10/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RRunView.h"
#define KScreenWidth [UIScreen mainScreen].bounds.size.width  //屏幕宽
#define KScreenHeight [UIScreen mainScreen].bounds.size.height //屏幕高
#define kStatusButtonControlSpacing (KScreenWidth-100*3)/4 //控件间距
#define kStatusButtonWidth 100 //按钮宽度
#define kStatusButtonHeight kStatusButtonWidth*0.7 //按钮高度
#define kStatusButtonTitleFontSize 12
#define kStatusLableTextFontSize 14
@implementation RRunView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"background.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self addSubview:self.stepsBtn];
        [self addSubview:self.distanceBtn];
        [self addSubview:self.distanceLable];
        [self addSubview:self.calorieBtn];
        [self addSubview:self.calorieLable];
        [self addSubview:self.timeBtn];
        [self addSubview:self.timelable];
        [self addSubview:self.showLable];
    }
    return self;
}

-(RRunButton *)stepsBtn
{
    if (!_stepsBtn) {
        
        _stepsBtn = [[RRunButton alloc] initWithFrame:CGRectMake((KScreenWidth*0.4)/2, 64+(KScreenHeight/17)+10, KScreenWidth*0.6, KScreenHeight*0.3)];
        [_stepsBtn setBackgroundImage:[[UIImage imageNamed:@"steps.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_stepsBtn setBackgroundColor:[UIColor clearColor]];
//        [_stepsBtn setTitle:@"3400" forState:UIControlStateNormal];
        _stepsBtn.titleLabel.font = [UIFont systemFontOfSize:30];
        [_stepsBtn addTarget:self action:@selector(stepsClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _stepsBtn;
}
-(RRunButton *)distanceBtn
{
    if (!_distanceBtn) {
        _distanceBtn = [[RRunButton alloc] initWithFrame:CGRectMake(kStatusButtonControlSpacing, KScreenHeight*0.7, kStatusButtonWidth, kStatusButtonHeight)];
        [_distanceBtn setBackgroundImage:[[UIImage imageNamed:@"5.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//        [_distanceBtn setTitle:@"3.4" forState:UIControlStateNormal];
        _distanceBtn.titleLabel.font = [UIFont systemFontOfSize:26];
        [_distanceBtn addTarget:self action:@selector(distanceClick:) forControlEvents:UIControlEventTouchUpInside];
        [_distanceBtn addSubview:self.distanceLable];
    }
    return _distanceBtn;
}
- (RRunLable *)distanceLable
{
    if (!_distanceLable) {
        _distanceLable = [[RRunLable alloc] initWithFrame:CGRectMake(self.distanceBtn.frame.origin.x, CGRectGetMaxY(self.distanceBtn.frame)-10, self.distanceBtn.frame.size.width, 40)];
        _distanceLable.text = @"路程/公里";
        
    }
    return _distanceLable;
}

-(RRunButton *)calorieBtn
{
    if (!_calorieBtn) {
        _calorieBtn = [[RRunButton alloc] initWithFrame:CGRectMake(kStatusButtonControlSpacing+CGRectGetMaxX(self.distanceBtn.frame), KScreenHeight*0.7, kStatusButtonWidth, kStatusButtonHeight)];
        [_calorieBtn setBackgroundImage:[[UIImage imageNamed:@"5.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//        [_calorieBtn setTitle:@"340" forState:UIControlStateNormal];
        _calorieBtn.titleLabel.font = [UIFont systemFontOfSize:26];
        [_calorieBtn addTarget:self action:@selector(calorieClick:) forControlEvents:UIControlEventTouchUpInside];
        [_calorieBtn addSubview:self.calorieLable];
    }
    return _calorieBtn;
}
- (RRunLable *)calorieLable
{
    if (!_calorieLable) {
        _calorieLable = [[RRunLable alloc] initWithFrame:CGRectMake(self.calorieBtn.frame.origin.x, CGRectGetMaxY(self.calorieBtn.frame)-10, self.calorieBtn.frame.size.width, 40)];
        _calorieLable.text = @"热量/千卡";
        
    }
    return _calorieLable;
}
-(RRunButton *)timeBtn
{
    if (!_timeBtn) {
        _timeBtn = [[RRunButton alloc] initWithFrame:CGRectMake(kStatusButtonControlSpacing+CGRectGetMaxX(self.calorieBtn.frame), KScreenHeight*0.7, kStatusButtonWidth, kStatusButtonHeight)];
        [_timeBtn setBackgroundImage:[[UIImage imageNamed:@"5.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_timeBtn setTitle:@"45" forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:26];
        [_timeBtn addTarget:self action:@selector(timeClick:) forControlEvents:UIControlEventTouchUpInside];
        [_timeBtn addSubview:self.timelable];
    }
    return _timeBtn;
}
- (RRunLable *)timelable
{
    if (!_timelable) {
        _timelable = [[RRunLable alloc] initWithFrame:CGRectMake(self.timeBtn.frame.origin.x, CGRectGetMaxY(self.timeBtn.frame)-10, self.timeBtn.frame.size.width, 40)];
        _timelable.text = @"活跃/分钟";
        
    }
    return _timelable;
}


-(RRunLable *)showLable
{
    if (!_showLable) {
        _showLable = [[RRunLable alloc] initWithFrame:CGRectMake((KScreenWidth-300)/2, CGRectGetMaxY(self.stepsBtn.frame)+KScreenHeight*0.06,   300, 50)];
        _showLable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"show.png"]];
//        _showLable.layer.borderWidth = 2;
//        _showLable.layer.borderColor = [[UIColor grayColor] CGColor];
        _showLable.text = @"别坐太久，起来拉伸一下吧！";
        
    }
    return _showLable;
}
- (void)stepsClick:(RRunButton *)button
{
    NSString *title = [button.titleLabel.text substringToIndex:button.titleLabel.text.length];
    int steps =[title intValue];
    if(steps<500)
    {
        NSString *show = [NSString stringWithFormat:@"相当于%.1f节火车车厢的长度",steps/50.0];
        self.showLable.text = show;
    }else
    {
        self.showLable.text = [NSString stringWithFormat:@"相当于走过%.1f个中央大街的长度",steps/2900.0];
    }
    
}
- (void)distanceClick:(RRunButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"distanceClick" object:nil];
}
- (void)timeClick:(RRunButton *)button
{
}
- (void)calorieClick:(RRunButton *)button
{
    BOOL select = YES;
    if (select) {
        float rice = [button.titleLabel.text floatValue]/232.0;
        self.showLable.text = [NSString stringWithFormat:@"消耗了约%.1f碗米饭的热量",rice];
        select = NO;
    }else{
        float apple = [button.titleLabel.text floatValue]/85.0;
        self.showLable.text = [NSString stringWithFormat:@"消耗了约%.1f个苹果的热量",apple];
    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
