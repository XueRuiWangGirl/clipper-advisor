//
//  QDataView.h
//  MyHealth
//
//  Created by 秦森 on 15/10/24.
//  Copyright © 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDataView : UIView

+ (QDataView *)loadWithNib;

@property (weak, nonatomic) IBOutlet UILabel *dataTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *eatLabel;
@property (weak, nonatomic) IBOutlet UILabel *runLabel;

@end
