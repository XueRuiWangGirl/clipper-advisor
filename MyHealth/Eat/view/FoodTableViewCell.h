//
//  FoodTableViewCell.h
//  MyHealth
//
//  Created by imac on 15/11/10.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLab;
@property (weak, nonatomic) IBOutlet UILabel *foodDetailLab;
@property (weak, nonatomic) IBOutlet UITextView *foodText;
@property (weak, nonatomic) IBOutlet UILabel *foodEvaluationLab;
@property (weak, nonatomic) IBOutlet UIImageView *tuijianImage;
@property (weak, nonatomic) IBOutlet UIImageView *foodEvaluImage;


@end
