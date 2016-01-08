//
//  OTabBar.m
//  MyHealth
//
//  Created by imac on 15/10/25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "OTabBar.h"
#import "OTabBarButton.h"

@interface OTabBar ()
@property (nonatomic, strong) OTabBarButton *buttons;
@end
@implementation OTabBar
- (void)setItems:(NSArray *)items
{
    _items = items;
    
    // 遍历模型数组，创建对应tabBarButton
    [ _items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         
         CGFloat width=self.frame.size.width;
         CGFloat btnW=width/_items.count;
         CGFloat btnH=self.frame.size.height;
         self.buttons=[[OTabBarButton alloc]initWithFrame:CGRectMake(idx*btnW, 0, btnW, btnH)];
         self.buttons.layer.borderWidth=1;
         self.buttons.layer.borderColor=[[UIColor blackColor]CGColor];
         [self.buttons addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
         self.buttons.tag = idx;
         if (_buttons.tag==0) {
             [self btnClick:_buttons];
         }
         _buttons.item=obj;
         [self addSubview:self.buttons];
     }];
}

// 点击tabBarButton调用
-(void)btnClick:(UIButton *)button
{
 
    
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
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
