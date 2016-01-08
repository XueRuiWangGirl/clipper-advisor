//
//  MainNavigatioController.m
//  MyHealth
//
//  Created by imac on 15/10/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MainNavigatioController.h"

@interface MainNavigatioController () <UINavigationControllerDelegate>

@end

@implementation MainNavigatioController

+ (void)initialize
{
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
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
