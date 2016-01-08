//
//  QDataScrollView.h
//  MyHealth
//
//  Created by 秦森 on 15/10/24.
//  Copyright © 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDataScrollView : UIScrollView

- (instancetype)initForMyself;

- (void)addView;

- (void)addViewWithEatArray:(NSArray *)eatArray andRunArray:(NSArray *)runArray;

@end
