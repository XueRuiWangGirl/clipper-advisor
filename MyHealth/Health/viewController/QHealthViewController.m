//
//  QHealthViewController.m
//  MyHealth
//
//  Created by imac on 15/10/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "QHealthViewController.h"
#import "PersonHealthView.h"
#import "QPersonHealthView.h"
#import "QHealthSettingViewController.h"
#import "QDataScrollView.h"
#import "QHealthScrollView.h"
#import "QHealthWebViewController.h"

@interface QHealthViewController () <UIScrollViewDelegate>

@end

@implementation QHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self buildView];
}

#pragma mark - build all view

- (void)buildView
{
    self.title = @"Health";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postWebView:) name:@"postURLString" object:nil];
    [self writeMyData];
    [self buildPersonHealth1];
    [self buildRightButton];
    [self buildDataView];
    [self buildHealthView];
}

- (void)buildRightButton
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"我的" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)buildPersonHealth
{
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    NSLog(@"%f",navHeight);
    PersonHealthView *personHealth = [[PersonHealthView alloc]initWithNavigationHeiht:navHeight];
//    PersonHealthView *personHealth = [[PersonHealthView alloc]init];
    [personHealth addLabel:[self readMyDataForArray:@"myData"]];
    [self.view addSubview:personHealth];
}

- (void)buildPersonHealth1
{
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    NSLog(@"%f",navHeight);
    QPersonHealthView *personHealth = [[QPersonHealthView alloc]initWithNavigationHeiht:navHeight];
    [self.view addSubview:personHealth];
}


- (void)buildDataView
{
    QDataScrollView *dataScrollView = [[QDataScrollView alloc]initForMyself];
    [dataScrollView addViewWithEatArray:[self readMyDataForArray:@"steps"] andRunArray:[self readMyDataForArray:@"breakfastHot"]];
    CGPoint newPoint = dataScrollView.contentOffset;
    newPoint.x = dataScrollView.frame.size.width;
    dataScrollView.contentOffset = newPoint;
    NSLog(@"dataScrollView : %@",NSStringFromCGPoint(dataScrollView.contentOffset));
    dataScrollView.tag = 2001;
    dataScrollView.delegate = self;
    [self.view addSubview:dataScrollView];
}

- (void)buildHealthView
{
    QHealthScrollView *healthScrollView = [[QHealthScrollView alloc]initForMyself];
    [healthScrollView addView];
    CGPoint newPoint = healthScrollView.contentOffset;
    newPoint.x = healthScrollView.frame.size.width;
    healthScrollView.contentOffset = newPoint;
    NSLog(@"dataScrollView : %@",NSStringFromCGPoint(healthScrollView.contentOffset));
    healthScrollView.tag = 3001;
    healthScrollView.delegate = self;
    [self.view addSubview:healthScrollView];
}

#pragma mark - buttonClick

- (void)rightButtonClick
{
    QHealthSettingViewController *healthSetting_vc = [[QHealthSettingViewController alloc]init];
    [self.navigationController pushViewController:healthSetting_vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)postWebView:(NSNotification *)notification
{
    QHealthWebViewController *healthWebVC = [[QHealthWebViewController alloc]init];
    healthWebVC.URLString = notification.userInfo[@"URLString"];
    [self.navigationController pushViewController:healthWebVC animated:YES];
}

- (void)writeMyData
{
    NSArray *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesStr = [caches firstObject];
    NSLog(@"cachesStr = %@",cachesStr);
    
    NSString *myDataFilePath = [cachesStr stringByAppendingPathComponent:@"myData.plist"];
    NSString *myEatFilePath = [cachesStr stringByAppendingPathComponent:@"myEat.plist"];
    NSString *myRunFilePath = [cachesStr stringByAppendingPathComponent:@"myRun.plist"];
    
    //临时调试数据
    NSArray *myData = @[@"1994",@"Male",@"B",@"Aries",@"100",@"100",@"100"];
    NSArray *myHealthEat = @[@"12345",@"12345"];
    NSArray *myHealthRun = @[@"54321",@"54321"];
    
    [myData writeToFile:myDataFilePath atomically:YES];
    [myHealthEat writeToFile:myEatFilePath atomically:YES];
    [myHealthRun writeToFile:myRunFilePath atomically:YES];
    
}

- (NSArray *)readMyDataForArray:(NSString *)fileName
{
    NSArray *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesStr = [caches firstObject];
    NSLog(@"cachesStr = %@",cachesStr);
    
    NSString *myDataFilePath = [cachesStr stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    return [NSArray arrayWithContentsOfFile:myDataFilePath];
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
