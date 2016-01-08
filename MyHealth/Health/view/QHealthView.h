//
//  QHealthView.h
//  MyHealth
//
//  Created by 秦森 on 15/10/24.
//  Copyright © 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QHealthView : UIView

@property (nonatomic, strong) UILabel *lable;

+ (QHealthView *)loadWithNib;

@property (weak, nonatomic) IBOutlet UIImageView *imageOne;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *descLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *timeLabelOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;

@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *descLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *timeLabelTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;

@property (nonatomic, strong) NSString *URLStringOne;
@property (nonatomic, strong) NSString *URLStringTwo;

@end
