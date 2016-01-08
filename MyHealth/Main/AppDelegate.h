//
//  AppDelegate.h
//  MyHealth
//
//  Created by imac on 15/10/21.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNavigatioController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MainNavigatioController *nav;
- (void)passValue;
@end

