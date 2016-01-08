//
//  QSHealth.m
//  MyHealth
//
//  Created by 秦森 on 15/10/25.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "QSHealth.h"

@implementation QSHealth

- (NSArray *)informationArray
{
    if (!_informationArray) {
        _informationArray = @[@"Health information"];
    }
    return _informationArray;
}

@end
