//
//  HomeTopItem.h
//  MyHealth
//
//  Created by imac on 15/11/5.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTopItem : UIView
@property (weak, nonatomic) IBOutlet UIButton *TopButton;
+ (instancetype)item;
- (void)setTitle:(NSString *)title;
- (void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon;
@end
