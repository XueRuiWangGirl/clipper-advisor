//
//  FoodMenuViewController.m
//  MyHealth
//
//  Created by imac on 15/10/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "FoodMenuViewController.h"
#import "OneFoodViewController.h"
#import "OneFoodModel.h"

@interface FoodMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *foodMenuTableView;
//存储plist数据
@property (nonatomic, strong) NSArray *arr;
//标题
@property (nonatomic, strong) NSArray *arr_head;

@end

@implementation FoodMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"食物列表";
    [self.view addSubview:self.foodMenuTableView];
}
#pragma mark - 懒加载
- (UITableView *)foodMenuTableView
{
    if (!_foodMenuTableView) {
        _foodMenuTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _foodMenuTableView.delegate = self;
        _foodMenuTableView.dataSource = self;
    }
    return _foodMenuTableView;
}

- (NSArray *)arr_head
{
    if (!_arr_head) {
        _arr_head = @[@"蔬菜",@"水果",@"主食"];
    }
    return _arr_head;
}
- (NSArray *)arr
{
    if (!_arr) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Foods" ofType:@"plist"];
        // 2.加载数组
        NSArray *dicArr = [NSArray arrayWithContentsOfFile:path];
        // 3.将dictArray里面的所有字典转成模型对象,放到新的数组中
//        NSMutableArray *newArray = [NSMutableArray array];
//        
//        for (NSDictionary *dict in dicArr) {
//            // 3.1.创建模型对象
//            OneFoodModel *foodInfoModel = [OneFoodModel foodInfoWithDict:dict];
//            // 3.2.添加模型对象到数组中
//            [newArray addObject:foodInfoModel];
//        }
        //_arr = newArray;
        
        _arr = dicArr;
       // NSLog(@"arr == %@",_arr);
    }
    return _arr;
}

#pragma mark - tableView datasource,delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arr_head.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *arr = self.arr[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [self.foodMenuTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   // cell.textLabel.text = self.arr[indexPath.section][indexPath.row];
    NSDictionary *dic = self.arr[indexPath.section][indexPath.row];
    OneFoodModel *model = [OneFoodModel foodInfoWithDict:dic];
    cell.textLabel.text = model.foodName;
    
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneFoodViewController *one2 = [[OneFoodViewController alloc]init];
    [self.navigationController pushViewController:one2 animated:YES];
    //指定代理，传递食物信息
    self.delegate = one2;
//    if ([self.delegate respondsToSelector:@selector(passFoodName:)]) {
//        [self.delegate passFoodName:self.arr[indexPath.section][indexPath.row]];
    //传递字典（食物具体信息）
    if ([self.delegate respondsToSelector:@selector(passFoodDic:)]) {
        [self.delegate passFoodDic:self.arr[indexPath.section][indexPath.row]];
       // NSLog(@"cansu =%@",self.arr[indexPath.section][indexPath.row]);
    }
        

}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.arr_head[section];
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
