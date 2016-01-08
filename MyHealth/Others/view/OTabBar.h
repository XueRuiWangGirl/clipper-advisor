//
//  OTabBar.h
//  MyHealth
//
//  Created by imac on 15/10/25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OTabBar;
@protocol OTabBarDelegate <NSObject>

- (void)tabBar:(OTabBar *)tabBar didClickButton:(NSInteger)index;

@end
@interface OTabBar : UIView
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<OTabBarDelegate> delegate;
@end
