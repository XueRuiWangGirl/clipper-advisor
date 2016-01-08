//
//  HomeTopItem.m
//  MyHealth
//
//  Created by imac on 15/11/5.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "HomeTopItem.h"

@interface HomeTopItem ()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end
@implementation HomeTopItem
-(void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}
+(instancetype)item
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeTopItem" owner:nil options:nil] firstObject];
}
- (void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon
{
    [self.TopButton setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.TopButton setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
}

- (void)setTitle:(NSString *)title
{
    self.titleLable.text = title;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
