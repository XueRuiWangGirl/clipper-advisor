//
//  AllView.m
//  MyHealth
//
//  Created by imac on 15/10/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "AllView.h"

@implementation AllView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (UITextField *)UITextFiledFrame:(CGRect)frame andPlaceholder:(NSString *)place andAdjustsFont:(BOOL)sizeFit andLayerWidth:(CGFloat)width andBorderColor:(UIColor *)cgcolor
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = place;
    textField.adjustsFontSizeToFitWidth = sizeFit;
    textField.layer.borderWidth = width;
    textField.layer.borderColor = [cgcolor CGColor];
    return textField;
}
+ (UIButton *)UIButtonFrame:(CGRect)frame andBackgroundColor:(UIColor *)color andTitle:(NSString *)title andTitleColor:(UIColor *)titleColor
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = color;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    return button;
}
+ (UILabel *)UILableFrame:(CGRect)frame addBackgroundColor:(UIColor *)color andTitle:(NSString *)title
{
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    lable.backgroundColor = color;
    lable.text = title;
    return lable;
}
@end
