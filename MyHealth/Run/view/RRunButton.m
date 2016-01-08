//
//  RRunButton.m
//  MyHealth
//
//  Created by imac on 15/10/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RRunButton.h"

@implementation RRunButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:24];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.backgroundColor = [UIColor clearColor];
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
