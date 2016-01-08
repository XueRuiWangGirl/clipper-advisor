//
//  OneView.m
//  MyHealth
//
//  Created by imac on 15/11/10.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "OneView.h"

@implementation OneView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
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
