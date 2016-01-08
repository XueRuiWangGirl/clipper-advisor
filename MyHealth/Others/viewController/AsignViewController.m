//
//  AsignViewController.m
//  MyHealth
//
//  Created by imac on 15/10/25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "AsignViewController.h"

@interface AsignViewController ()

@property (strong, nonatomic) IBOutlet UIButton *clickBtn;
@property (strong, nonatomic) IBOutlet UILabel *timeLable;
@property (strong, nonatomic) IBOutlet UILabel *CatuleLable;
@property (strong, nonatomic) IBOutlet UIButton *statBtn;
@property (strong, nonatomic) IBOutlet UIButton *canlceBtn;
@property (nonatomic, assign) int a;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int b;
@end

@implementation AsignViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNavigationTitle" object:nil userInfo:@{@"myNavigationTitle" : @"动起来"}];
    _a = 0;
    _b = 0;
    [self AllLable];
}
#pragma mark -- 添加所有的lable、button
- (void)AllLable
{
    //添加点击事件计数的代码
[_clickBtn addTarget:self action:@selector(clickBtnO) forControlEvents:UIControlEventTouchUpInside];
    
    //添加显示时间的lable
    self.timeLable.text = @"00:00:00";
    self.timeLable.textColor = [UIColor blackColor];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    
    //添加显示开始的Button
    [_statBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_statBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _statBtn.layer.cornerRadius = 90;
    [self.statBtn addTarget:self action:@selector(starClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加取消按钮
    _canlceBtn.backgroundColor = [UIColor orangeColor];
    [_canlceBtn addTarget:self action:@selector(CanlcBtn) forControlEvents:UIControlEventTouchUpInside];
    _canlceBtn.hidden = YES;
    
    //添加计数的lable
    self.CatuleLable.textAlignment = NSTextAlignmentCenter;
    self.CatuleLable.backgroundColor = [UIColor clearColor];
    self.CatuleLable.layer.borderWidth = 1;
    self.CatuleLable.layer.borderColor = [[UIColor blackColor] CGColor];
    self.CatuleLable.layer.backgroundColor = [[UIColor purpleColor] CGColor];
    self.CatuleLable.layer.cornerRadius = 90;
}
#pragma mark -- 开始的点击事件的点击响应事件
- (void)starClick
{
    if ([self.statBtn.titleLabel.text isEqualToString:@"开始"]) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeOne) userInfo:nil repeats:YES];
        self.canlceBtn.hidden = NO;
        _statBtn.hidden = YES;
        [_statBtn setTitle:@"继续" forState:UIControlStateNormal];
        _clickBtn.enabled = YES;
    }
    else
    {
        self.clickBtn.enabled = YES;
        [self.timer setFireDate:[NSDate distantPast]];
        self.statBtn.hidden = YES;
    }
    [_canlceBtn setTitle:@"暂停" forState:UIControlStateNormal];

}
#pragma mark -- 点击计数
- (void)clickBtnO
{
    _b += 1;
    NSString *strNumber = [NSString stringWithFormat:@"%d",_b];
    NSString *str = [strNumber stringByAppendingString:@"个"];
    self.CatuleLable.text = str;
    
    
}
- (void)CanlcBtn
{
    if ([_canlceBtn.titleLabel.text isEqualToString:@"暂停"]) {
        self.statBtn.hidden = NO;
        [self.statBtn setTitle:@"继续" forState:UIControlStateNormal];
        [self.canlceBtn setTitle:@"清零" forState:UIControlStateNormal];
        [self.timer setFireDate:[NSDate distantFuture]];
        self.clickBtn.enabled = NO;
    }
    else{
    self.statBtn.hidden = NO;
        [self.timer invalidate];
        self.clickBtn.hidden = NO;
        [self.canlceBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [self.statBtn setTitle:@"开始" forState:UIControlStateNormal];
        self.timeLable.text = @"00:00:00";
        self.canlceBtn.hidden = YES;
        _b = 0;
        _a = 0;
        self.CatuleLable.text = @"0个";
    }
}
#pragma mark -- 定时器的响应事件
- (void)timeOne
{
    _a +=1;
    int hao = _a%100;
    int second = (_a/100)%60;
    int mint = (_a/100)/60;
    if (hao<10) {
        NSString *strHao = [NSString stringWithFormat:@"0%d",hao];
        if (second<10)
        {
            NSString *strSecond = [NSString stringWithFormat:@"0%d:",second];
            NSString *haoSec = [strSecond stringByAppendingString:strHao];
            if (mint<10) {
                NSString *strMint = [NSString stringWithFormat:@"0%d:",mint];
                NSString *lable = [strMint stringByAppendingString:haoSec];
                self.timeLable.text = lable;
            }
            else
            {
                NSString *strMint = [NSString stringWithFormat:@"%d:",mint];
                NSString *lable = [strMint stringByAppendingString:haoSec];
                self.timeLable.text = lable;
            }
        }
        else
        {
            NSString *strSecond = [NSString stringWithFormat:@"%d:",second];
            NSString *haoSec = [strSecond stringByAppendingString:strHao];
            if (mint<10) {
                NSString *strMint = [NSString stringWithFormat:@"0%d:",mint];
                NSString *lable = [strMint stringByAppendingString:haoSec];
                self.timeLable.text = lable;
            }
            else
            {
                NSString *strMint = [NSString stringWithFormat:@"%d:",mint];
                NSString *lable = [strMint stringByAppendingString:haoSec];
                self.timeLable.text = lable;
            }
            
        }
    }else
    {
        NSString *strHao = [NSString stringWithFormat:@"%d",hao];
        if (second<10)
        {
            NSString *strSecond = [NSString stringWithFormat:@"0%d:",second];
            NSString *haoSec = [strSecond stringByAppendingString:strHao];
            if (mint<10) {
                NSString *strMint = [NSString stringWithFormat:@"0%d:",mint];
                NSString *lable = [strMint stringByAppendingString:haoSec];
                self.timeLable.text = lable;
            }
            else
            {
                NSString *strMint = [NSString stringWithFormat:@"%d:",mint];
                NSString *lable = [strMint stringByAppendingString:haoSec];
                self.timeLable.text = lable;
            }
        }
        else
        {
            NSString *strSecond = [NSString stringWithFormat:@"%d:",second];
            NSString *haoSec = [strSecond stringByAppendingString:strHao];
            if (mint<10) {
                NSString *strMint = [NSString stringWithFormat:@"0%d:",mint];
                NSString *lable = [strMint stringByAppendingString:haoSec];
                self.timeLable.text = lable;
            }
            else
            {
                NSString *strMint = [NSString stringWithFormat:@"%d:",mint];
                NSString *lable = [strMint stringByAppendingString:haoSec];
                self.timeLable.text = lable;
            }
            
        }
        
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"achiv.jpg"]];
    
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
