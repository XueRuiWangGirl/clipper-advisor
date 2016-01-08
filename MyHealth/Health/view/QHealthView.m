//
//  QHealthView.m
//  MyHealth
//
//  Created by 秦森 on 15/10/24.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "QHealthView.h"
#import "QSHealth.h"
#import "MBProgressHUD+MJ.h"

@interface QHealthView ()

@property (nonatomic, strong) QSHealth *health;

@property (nonatomic, strong) NSMutableArray *healths;

@end

@implementation QHealthView

+ (QHealthView *)loadWithNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"QHealthView" owner:self options:nil] firstObject];
}


#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.lable];
    }
    return self;
}

#pragma mark - delay load

- (QSHealth *)health
{
    if (!_health) {
        _health = [[QSHealth alloc]init];
    }
    return _health;
}

- (UILabel *)lable
{
    if (!_lable) {
        _lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, 150)];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.font = [UIFont systemFontOfSize:40];
        _lable.textColor = [UIColor whiteColor];
        _lable.text = self.health.informationArray[0];
    }
    return _lable;
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (self.URLStringOne == self.URLStringTwo) {
        [MBProgressHUD showError:@"The Internet connection appears \n to be offline.-1009"];
    }
    else{
        if (sender.tag == 300001) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"postURLString" object:nil userInfo:@{@"URLString" : self.URLStringOne}];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"postURLString" object:nil userInfo:@{@"URLString" : self.URLStringTwo}];
        }

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
