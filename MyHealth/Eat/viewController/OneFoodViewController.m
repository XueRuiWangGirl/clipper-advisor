//
//  OneFoodViewController.m
//  MyHealth
//
//  Created by imac on 15/10/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "OneFoodViewController.h"
#import "LslEatViewController.h"
#import "OneFoodModel.h"
#import "FoodMenuViewController.h"
#import "FoodTableViewCell.h"
@interface OneFoodViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,passFoodNameDelegate>
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIAlertView *alert;
//食物信息
@property (nonatomic, strong) NSArray *foodInfoArr;
//标题数组
@property (nonatomic, strong) NSArray *hearderArr;
//传过来的字典
@property (nonatomic, strong) NSMutableDictionary *passFoodDic;

@end

@implementation OneFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.segment];
}
#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        //指定代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //注册自定义cell
        [_tableView registerNib:[UINib nibWithNibName:@"FoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellidentifier"];
    }
    return _tableView;
}
- (UISegmentedControl *)segment
{
    if (!_segment) {
        NSArray *arr = @[@"添加到早餐",@"添加到午餐",@"添加到晚餐"];
        _segment = [[UISegmentedControl alloc]initWithItems:arr];
        _segment.frame = CGRectMake(0, self.view.bounds.size.height-40, self.view.bounds.size.width, 40);
        _segment.backgroundColor = [UIColor cyanColor];
        [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}
- (UIAlertView *)alert
{
    if (!_alert) {
        _alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"成功添加：%@",self.passFoodName] message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: @"返回首页",@"返回食物列表", nil];
    }
    return _alert;
}
- (NSArray *)foodInfoArr
{
    if (!_foodInfoArr) {
        // 1.获得plist文件的全路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Food" ofType:@"plist"];
        // 2.加载数组
        NSArray *dicArr = [NSArray arrayWithContentsOfFile:path];
        // 3.将dictArray里面的所有字典转成模型对象,放到新的数组中
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in dicArr) {
            // 3.1.创建模型对象
            OneFoodModel *foodInfoModel = [OneFoodModel foodInfoWithDict:dict];
            // 3.2.添加模型对象到数组中
            [newArray addObject:foodInfoModel];
        }
        // 4.赋值
        _foodInfoArr = newArray;
       
    }
    return _foodInfoArr;
}
- (NSMutableDictionary *)passFoodDic
{
    if (!_passFoodDic) {
        _passFoodDic = [NSMutableDictionary dictionary];
    }
    return _passFoodDic;
}
- (NSArray *)hearderArr
{
    if (!_hearderArr) {
        _hearderArr = @[@"详细信息",@"描述",@"评价"];
    }
    return _hearderArr;
}
#pragma mark - alertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
        {
            LslEatViewController *eatVC = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController: eatVC animated:YES];
        }
            break;
        case 2:
        {
            FoodMenuViewController *menuVC = self.navigationController.viewControllers[2];
            [self.navigationController popToViewController: menuVC animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark - segmentMethods
- (void)segmentClick:(UISegmentedControl *)seg
{
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"breakfast" object:nil userInfo:@{@"breakfastName":self.passFoodName,@"breakfastHot":self.passHot}];
            //弹出elart
            [self.alert show];

        }
            break;
        case 1:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"lunch" object:nil userInfo:@{@"lunchName":self.passFoodName,@"lunchHot":self.passHot}];
            //弹出elart
            [self.alert show];

        }
            break;
        case 2:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dinner" object:nil userInfo:@{@"dinnerName":self.passFoodName,@"dinnerHot":self.passHot}];
            //弹出elart
            [self.alert show];
        }
            break;
        
    }
}
#pragma mark - tableViewDatasource,Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return self.hearderArr.count;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSArray *arr = self.foodInfoArr[section];
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellidentifier";
    FoodTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    //model层
    OneFoodModel *foodInfoModel = [OneFoodModel foodInfoWithDict:self.passFoodDic];
    cell.foodDetailLab.text = foodInfoModel.calorie;
//    NSLog(@"calorie=%@",foodInfoModel.calorie);
    cell.foodNameLab.text = foodInfoModel.foodName;
    cell.foodImage.image = [UIImage imageNamed:foodInfoModel.foodImage];
    cell.foodText.text = foodInfoModel.foodDesc;
    cell.foodEvaluationLab.text = foodInfoModel.evaluation;
    cell.tuijianImage.image = [UIImage imageNamed:@"yes.png"];
    cell.foodEvaluImage.image = [UIImage imageNamed:foodInfoModel.foodImage];
    
    self.passHot = foodInfoModel.foodHot;
   // NSLog(@"passhot = %@",self.passHot);
    self.passFoodName = foodInfoModel.foodName;
    return cell;
}
#pragma mark - tableViewDelegate
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return self.hearderArr[section];
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 710;
}
#pragma mark - passFoodNameDelegate
- (void)passFoodName:(NSString *)foodName
{
    self.passFoodName = foodName;
}
- (void)passFoodDic:(NSDictionary *)foodDic
{
    self.passFoodDic = (NSMutableDictionary*)foodDic;
//   NSLog(@"fooddic = %@",foodDic);
//   NSLog(@"passfooddic = %@",self.passFoodDic);
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
