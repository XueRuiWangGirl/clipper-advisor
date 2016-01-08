//
//  OtherVIew.m
//  MyHealth
//
//  Created by imac on 15/10/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "OtherVIew.h"

@implementation OtherVIew


//-(OtherLab *)showStepLab
//{
//    if (!_showStepLab) {
//        _showStepLab=[[OtherLab alloc]initWithFrame:CGRectMake(showLabX, showLabY, 200, 60)];
//        _showStepLab.tintColor=[UIColor blackColor];
//        _showStepLab.backgroundColor=[UIColor clearColor];
//        _showStepLab.textAlignment=NSTextAlignmentCenter;
////        _showStepLab.font=[UIFont systemFontOfSize:80];
//    }
//    return _showStepLab;
//}

-(OtherLab *)StepLab
{
    if (!_StepLab) {
        _StepLab=[[OtherLab alloc]initWithFrame:CGRectMake(StepLabX, StepLabY, 200, 40)];
        _StepLab.text=@"单日突破10000步次数";
        _StepLab.font=[UIFont systemFontOfSize:20];
        _StepLab.textColor=[UIColor blackColor];
        
    }
    return _StepLab;
}
-(OtherLab *)achivLab
{
    if (!_achivLab) {
        _achivLab=[[OtherLab alloc]initWithFrame:CGRectMake(achvLabX, achvLabY, 169, 158)];
//        _achivLab.layer.backgroundColor=[[UIColor greenColor]CGColor];
//        _achivLab.layer.borderWidth=1;
        _achivLab.backgroundColor=[UIColor colorWithPatternImage:[[UIImage imageNamed:@"achiv2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        _achivLab.layer.cornerRadius=88;
    }
    return _achivLab;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {

//        [self addSubview:self.StepLab];
        [self addSubview:self.achivLab];
//        [self addSubview:self.showStepLab];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
