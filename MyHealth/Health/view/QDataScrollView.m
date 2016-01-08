//
//  QDataScrollView.m
//  MyHealth
//
//  Created by 秦森 on 15/10/24.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "QDataScrollView.h"
#import "QDataView.h"

#define WIDTH ([UIScreen mainScreen].bounds.size.width-4)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height-66)/3-4

@implementation QDataScrollView

#pragma mark - myself init

- (instancetype)initForMyself
{
    self = [super init];
    if (self) {
        CGRect frame = CGRectMake(2, 44+22+HEIGHT+2, WIDTH, HEIGHT);
        NSLog(@"%@",NSStringFromCGRect(frame));
        self.frame = frame;
        self.backgroundColor = [UIColor yellowColor];
        self.contentSize = CGSizeMake(WIDTH*2, 0);
        self.pagingEnabled = YES;
        self.directionalLockEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

#pragma mark - add view

- (void)addView
{
    CGRect frame1 = CGRectMake(0, 0, WIDTH, HEIGHT);
    CGRect frame2 = CGRectMake(WIDTH, 0, WIDTH, HEIGHT);
    QDataView *data1 = [QDataView loadWithNib];
    data1.frame = frame1;
    data1.dataTitleLabel.text = @"Yesterday";
//    data1.backgroundColor = [UIColor brownColor];
    QDataView *data2 = [QDataView loadWithNib];
    data2.frame = frame2;
    data2.dataTitleLabel.text = @"Today";
//    data2.backgroundColor = [UIColor blueColor];
    [self addSubview:data1];
    [self addSubview:data2];
}

- (void)addViewWithEatArray:(NSArray *)eatArray andRunArray:(NSArray *)runArray
{
    CGRect frame1 = CGRectMake(0, 0, WIDTH, HEIGHT);
    CGRect frame2 = CGRectMake(WIDTH, 0, WIDTH, HEIGHT);
    QDataView *data1 = [QDataView loadWithNib];
    data1.frame = frame1;
    data1.dataTitleLabel.text = @"Yesterday";
    data1.eatLabel.text = [NSString stringWithFormat:@"%@",eatArray[0]];
    data1.runLabel.text = runArray[0];
    //    data1.backgroundColor = [UIColor brownColor];
    QDataView *data2 = [QDataView loadWithNib];
    data2.frame = frame2;
    data2.dataTitleLabel.text = @"Today";
    data2.eatLabel.text = [NSString stringWithFormat:@"%@",eatArray[0]];
    data2.runLabel.text = runArray[0];
    //    data2.backgroundColor = [UIColor blueColor];
    [self addSubview:data1];
    [self addSubview:data2];
}

@end
