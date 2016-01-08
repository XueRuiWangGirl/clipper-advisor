//
//  LslEatViewController.m
//  MyHealth
//
//  Created by imac on 15/10/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//  二版

#import "LslEatViewController.h"
#import "FoodMenuViewController.h"
#import "OneDayView.h"
#import "OneFoodViewController.h"
@interface LslEatViewController ()<UIScrollViewDelegate,passFoodNameToEatPageDelegate>
@property (nonatomic, strong) UIBarButtonItem *leftBarButton;
@property (nonatomic, strong) UIBarButtonItem *rightBarButton;
//竖滑
@property (nonatomic, strong) UIScrollView *scrollView_H;
//横滑
@property (nonatomic, strong) UIScrollView *scrollView_W;
@property (nonatomic, strong) OneDayView *today_vc;
@property (nonatomic, strong) OneDayView *yesterday_vc;
@property (nonatomic, strong) OneDayView *lastday_vc;
//显示更多内容
@property (nonatomic, strong) UILabel *more_lab;
//用于传值
@property (nonatomic, strong) NSString *passName;
@end

@implementation LslEatViewController
#pragma mark - life
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController setToolbarHidden:YES animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Healthy Eat";
    //back
//    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    //"+"
    self.navigationItem.rightBarButtonItem = self.rightBarButton;
    [self addToView];
}
#pragma mark - addToView
- (void)addToView
{
    [self.scrollView_H addSubview:self.scrollView_W];
    [self.view addSubview:self.scrollView_H];
    
}
#pragma mark - 懒加载
- (UILabel *)more_lab
{
    if (!_more_lab) {
        _more_lab = [[UILabel alloc]initWithFrame:CGRectMake(40, 800, 330, 100)];
        _more_lab.font = [UIFont systemFontOfSize:20];
        _more_lab.text = @"今天吃的有点多，要多多运动哦！";
        _more_lab.backgroundColor = [UIColor clearColor];
        _more_lab.textAlignment = NSTextAlignmentCenter;
    }
    return _more_lab;
}
#pragma mark - left,right
//返回主页
- (UIBarButtonItem *)leftBarButton
{
    if (!_leftBarButton) {
        _leftBarButton = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(leftClick)];
    }
    return _leftBarButton;
}
//添加“+”按钮，用于进入食物列表页面
- (UIBarButtonItem *)rightBarButton
{
    if (!_rightBarButton) {
        _rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightClick)];
    }
    return _rightBarButton;
}
#pragma mark - scrollView_H
//竖滑的scroll，查看更多内容
- (UIScrollView *)scrollView_H
{
    if (!_scrollView_H) {
        _scrollView_H = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //设置滑动范围
        _scrollView_H.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"eatBack.jpg"]];
        _scrollView_H.delegate = self;
        //取消水平和竖直滚动轴
        _scrollView_H.showsHorizontalScrollIndicator = NO;
        _scrollView_H.showsVerticalScrollIndicator = NO;
        [_scrollView_H addSubview:imageView];
        [_scrollView_H addSubview:self.more_lab];
    }
    return _scrollView_H;
}
#pragma mark - scrollView_W
//横滑的scroll，查看前两天记录
- (UIScrollView *)scrollView_W
{
    if (!_scrollView_W) {
        _scrollView_W = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //设置滑动范围
        _scrollView_W.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height);
        _scrollView_W.pagingEnabled = YES;
        _scrollView_W.delegate = self;
        //取消滚动轴
        _scrollView_W.showsHorizontalScrollIndicator = NO;
        _scrollView_W.showsVerticalScrollIndicator = NO;
        self.today_vc = [[OneDayView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.yesterday_vc = [[OneDayView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.lastday_vc = [[OneDayView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //添加视图
        [_scrollView_W addSubview:self.today_vc];
        [_scrollView_W addSubview:self.lastday_vc];
        [_scrollView_W addSubview:self.yesterday_vc];
    }
    return _scrollView_W;
}
#pragma mark - click methods
//返回主页
- (void)leftClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//进入食物列表页面
- (void)rightClick
{
    FoodMenuViewController *foodMenu_vc = [[FoodMenuViewController alloc]init];
    [self.navigationController pushViewController:foodMenu_vc animated:YES];
}
#pragma mark - scrollView delegate
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (scrollView.tag == self.scrollView_W.tag) {
        [scrollView resignFirstResponder];
    }
}
#pragma mark - oneFoodViewDelegate
- (void)passFoodNameToEatPage:(NSString *)foodName
{
    //self.passName = foodName;
    [self.today_vc.array addObject:foodName];
    
    //NSLog(@"foodname == %@",foodName);
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
