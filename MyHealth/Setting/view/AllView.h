//
//  AllView.h
//  MyHealth
//
//  Created by imac on 15/10/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllView : UIView
+ (UITextField *)UITextFiledFrame:(CGRect)frame andPlaceholder:(NSString *)place andAdjustsFont:(BOOL)sizeFit andLayerWidth:(CGFloat)width andBorderColor:(UIColor *)cgcolor;
+ (UIButton *)UIButtonFrame:(CGRect)frame andBackgroundColor:(UIColor *)color andTitle:(NSString *)title andTitleColor:(UIColor *)titleColor;
+ (UILabel *)UILableFrame:(CGRect)feramr addBackgroundColor:(UIColor *)color andTitle:(NSString *)title;
@end
