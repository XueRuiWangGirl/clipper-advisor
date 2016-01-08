//
//  OTabBarButton.m
//  MyHealth
//
//  Created by imac on 15/10/25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "OTabBarButton.h"

@implementation OTabBarButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置字体颜色
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

        
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return self;
}
-(void)setItem:(UITabBarItem *)item
{
    _item=item;
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    //监听属性的变化
    [_item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];

    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];

    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片
    CGFloat Width=self.frame.size.width;
    CGFloat height=self.frame.size.height*0.7;
    
    self.imageView.frame=CGRectMake(0, 0, Width, height);
    
    CGFloat height2=self.frame.size.height-height;
    self.titleLabel.frame=CGRectMake(0, height, Width, height2);
    
}
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
