//
//  PersonHealthView.m
//  MyHealth
//
//  Created by imac on 15/10/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "PersonHealthView.h"
#import "QSPerson.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width-4
#define HEIGHT ([UIScreen mainScreen].bounds.size.height-66)/3-4
#define WIDTH_1 (self.frame.size.width-8)/8
#define WIDTH_2 (self.frame.size.width-8)/6
#define WIDTH_3 (self.frame.size.width-8)/4
#define HEIGHT_LABEL 50


@interface PersonHealthView ()

@property (nonatomic, strong) QSPerson *person;

@end

@implementation PersonHealthView

#pragma mark - init

- (instancetype)init
{
    if (self = [super init]) {
        CGRect frame = CGRectMake(2, 2, 200, 200);
        self.frame = frame;
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (instancetype)initWithNavigationHeiht:(CGFloat)navHeight
{
    if (self = [super init]) {
        CGRect frame = CGRectMake(2, navHeight+22, WIDTH, HEIGHT);
        NSLog(@"%@",NSStringFromCGRect(frame));
        self.frame = frame;
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

#pragma mark - delay load

- (QSPerson *)person
{
    if (!_person) {
        _person = [[QSPerson alloc]init];
    }
    return _person;
}

#pragma mark - add view

- (void)addButton
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn.layer.cornerRadius = 15;
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)addLabel
{
    int lineOne = 3010;
    for (int i = 0; i <8; i++) {
        CGRect frame = CGRectMake(4+WIDTH_1*i, 20, WIDTH_1, 50);
        UILabel *lable = [[UILabel alloc]initWithFrame:frame];
        if (i%2 == 0) {
            lable.text = self.person.firstLineArray[i/2];
        }
        lable.textAlignment = NSTextAlignmentCenter;
        NSLog(@"lineOne = %@",lable.text);
        lable.tag = lineOne + i;
        lable.layer.borderWidth = 1;
        lable.layer.borderColor = [[UIColor redColor] CGColor];
        [self addSubview:lable];
    }
    
    int lineTwo = 3020;
    for (int i = 0; i <6; i++) {
        CGRect frame = CGRectMake(4+WIDTH_2*i, 85, WIDTH_2, 50);
        UILabel *lable = [[UILabel alloc]initWithFrame:frame];
        if (i%2 == 0) {
            lable.text = self.person.secondLineArray[i/2];
        }
        lable.textAlignment = NSTextAlignmentCenter;
        NSLog(@"lineTwo = %@",lable.text);
        lable.tag = lineTwo + i;
        lable.layer.borderWidth = 1;
        lable.layer.borderColor = [[UIColor greenColor] CGColor];
        [self addSubview:lable];
    }
    
    int lineThree = 3030;
    for (int i = 0; i <4; i++) {
        CGRect frame = CGRectMake(4+WIDTH_3*i, 150, WIDTH_3, 50);
        UILabel *lable = [[UILabel alloc]initWithFrame:frame];
        if (i%2 == 0) {
            lable.text = self.person.thirdLineArray[i/2];
        }
        lable.textAlignment = NSTextAlignmentCenter;
        NSLog(@"lineThree = %@",lable.text);
        lable.tag = lineThree + i;
        lable.layer.borderWidth = 1;
        lable.layer.borderColor = [[UIColor blueColor] CGColor];
        [self addSubview:lable];
    }
    
}

- (void)addLabel:(NSArray *)array
{
    int lineOne = 3010;
    for (int i = 0; i <8; i++) {
        CGRect frame = CGRectMake(4+WIDTH_1*i, 20, WIDTH_1, 50);
        UILabel *lable = [[UILabel alloc]initWithFrame:frame];
        if (i%2 == 0) {
            lable.text = self.person.firstLineArray[i/2];
        }
        else{
            lable.text = array[i/2];
        }
        lable.textAlignment = NSTextAlignmentCenter;
        NSLog(@"lineOne = %@",lable.text);
        lable.tag = lineOne + i;
        lable.layer.borderWidth = 1;
        lable.layer.borderColor = [[UIColor redColor] CGColor];
        [self addSubview:lable];
    }
    
    int lineTwo = 3020;
    for (int i = 0; i <6; i++) {
        CGRect frame = CGRectMake(4+WIDTH_2*i, 85, WIDTH_2, 50);
        UILabel *lable = [[UILabel alloc]initWithFrame:frame];
        if (i%2 == 0) {
            lable.text = self.person.secondLineArray[i/2];
        }
        else{
            lable.text = array[4 + (i/2)];
        }
        lable.textAlignment = NSTextAlignmentCenter;
        NSLog(@"lineTwo = %@",lable.text);
        lable.tag = lineTwo + i;
        lable.layer.borderWidth = 1;
        lable.layer.borderColor = [[UIColor greenColor] CGColor];
        [self addSubview:lable];
    }
    
    int lineThree = 3030;
    for (int i = 0; i <4; i++) {
        CGRect frame = CGRectMake(4+WIDTH_3*i, 150, WIDTH_3, 50);
        UILabel *lable = [[UILabel alloc]initWithFrame:frame];
        if (i%2 == 0) {
            lable.text = self.person.thirdLineArray[i/2];
        }
        lable.textAlignment = NSTextAlignmentCenter;
        NSLog(@"lineThree = %@",lable.text);
        lable.tag = lineThree + i;
        lable.layer.borderWidth = 1;
        lable.layer.borderColor = [[UIColor blueColor] CGColor];
        [self addSubview:lable];
    }
    
}


#pragma mark - button click

- (void)buttonClick:(UIButton *)sender
{
    NSLog(@"%@",sender);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
