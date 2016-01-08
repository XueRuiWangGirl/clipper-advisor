//
//  QHealthWebViewController.m
//  MyHealth
//
//  Created by 秦森 on 15/11/10.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "QHealthWebViewController.h"

@interface QHealthWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *healthWebView;

@end

@implementation QHealthWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"健康咨询";
    NSLog(@"web view URL %@",self.URLString);
    [self.healthWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]]];
    // Do any additional setup after loading the view from its nib.
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
