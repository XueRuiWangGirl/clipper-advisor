//
//  QDataView.m
//  MyHealth
//
//  Created by 秦森 on 15/10/24.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "QDataView.h"

@interface QDataView ()

@end

@implementation QDataView

#pragma mark - init

+ (QDataView *)loadWithNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"QDataView" owner:self options:nil] firstObject];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark - delay load


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
