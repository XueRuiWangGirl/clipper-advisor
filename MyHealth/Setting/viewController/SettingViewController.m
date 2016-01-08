//
//  SettingViewController.m
//  MyHealth
//
//  Created by imac on 15/10/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SettingViewController.h"
#import "CBCViewController.h"
#import "RegisterViewController.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL pass;
}
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) SetTableViewCell *set;
@property (nonatomic, strong) UITableView *table;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    pass = YES;
    self.navigationItem.title = @"设置";
    [self.view addSubview:self.table];
    
}
- (NSArray *)array
{
    if (!_array) {
        _array = [NSArray arrayWithObjects:@"关于我们",@"告诉我们",@"清除缓存", nil];
    }
    return _array;
}
- (NSDictionary *)dic
{
    if (!_dic) {
        _dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"set" ofType:@"plist"]];
    }
    return _dic;
}
- (UITableView *)table

{
    if (!_table) {

        self.table = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        [self.table registerNib:[UINib nibWithNibName:@"SetTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
    self.table.dataSource = self;
    self.table.delegate = self;
    }
    return _table;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0&&indexPath.section == 0) {
        
        static NSString *str = @"MyCell";
        SetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (pass == YES) {
            NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *path = [arrayPath[0] stringByAppendingPathComponent:@"Value.plist"];
            NSArray *array = @[@"用户名",@"信息",@"image"];
            [array writeToFile:path atomically:YES];
            pass = NO;
            return cell;
        }else{
        NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path = [arrayPath[0] stringByAppendingPathComponent:@"Value.plist"];
        NSArray *value = [NSArray arrayWithContentsOfFile:path];
        cell.userNameLabel.text = value[0];
        cell.informationLabel.text = value[1];
        cell.userNamrImage.image = [UIImage imageNamed:value[2]];
            pass = YES;
            return cell;
        }
    }else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = self.array[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell.textLabel setFont:[UIFont systemFontOfSize:20]];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0&&indexPath.section == 0) {
        return 120;
    }
    else
        return 60;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CBCViewController *cbc = [[CBCViewController alloc] init];
        [self.navigationController pushViewController:cbc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)clickBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)click
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.table reloadData];
    [self.navigationController setNavigationBarHidden:NO];
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
