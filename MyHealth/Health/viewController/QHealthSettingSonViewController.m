//
//  QHealthSettingSonViewController.m
//  MyHealth
//
//  Created by 秦森 on 15/10/25.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "QHealthSettingSonViewController.h"

@interface QHealthSettingSonViewController ()

@end

@implementation QHealthSettingSonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"----------%@",self.array);
    self.nameLabel.text = self.array[0];
    self.vauleLabel.text = self.array[1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
