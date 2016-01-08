//
//  RRunLable.m
//  MyHealth
//
//  Created by imac on 15/10/25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RRunLable.h"

@implementation RRunLable

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:18];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor grayColor];
//        self.backgroundColor = [UIColor orangeColor];
//        [self sizeToFit];
 
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
