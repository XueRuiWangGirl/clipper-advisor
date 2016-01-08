//
//  QHealthSettingViewController.m
//  MyHealth
//
//  Created by 秦森 on 15/10/24.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "QHealthSettingViewController.h"
#import "QHealthSettingTableViewCell.h"
#import "QHealthSettingSonViewController.h"
#import "QSPerson.h"

@interface QHealthSettingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *selfInformationTableView;

@property (nonatomic, strong) QSPerson *personInformation;

@property (nonatomic, strong) NSArray *personInformationArray;

@end

@implementation QHealthSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self buildView];
}

#pragma mark - build all view

- (void)buildView
{
    self.title = @"我的信息";
    [self readMyData];
    [self.view addSubview:self.selfInformationTableView];
    [self buildRightButton];
}

- (void)buildRightButton
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
}


#pragma mark - delay load

- (UITableView *)selfInformationTableView
{
    if (! _selfInformationTableView) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _selfInformationTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _selfInformationTableView.delegate = self;
        _selfInformationTableView.dataSource = self;
        [_selfInformationTableView registerNib:[UINib nibWithNibName:@"QHealthSettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"HealthSettingTableViewCellIdentifier"];
    }
    return _selfInformationTableView;
}

- (QSPerson *)personInformation
{
    if (! _personInformation) {
        _personInformation = [[QSPerson alloc]init];
    }
    return _personInformation;
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.personInformation.allSettingArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QHealthSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HealthSettingTableViewCellIdentifier"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.nameLable.text = self.personInformation.allSettingArray[indexPath.row];
    cell.dataLabel.text = self.personInformationArray[indexPath.row];
    return cell;
}

#pragma mark - table delgate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"row index = %ld",(long)indexPath.row);
    QHealthSettingSonViewController *settingSon_VC = [[QHealthSettingSonViewController alloc]initWithNibName:@"QHealthSettingSonViewController" bundle:nil];
    settingSon_VC.title = self.personInformation.allSettingArray[indexPath.row];
    settingSon_VC.array = @[settingSon_VC.title , self.personInformationArray[indexPath.row]];
//    settingSon_VC.nameLabel.text = self.personInformation.allSettingArray[indexPath.row];
//    settingSon_VC.vauleLabel.text = self.personInformationArray[indexPath.row];
    [self.navigationController pushViewController:settingSon_VC animated:YES];
}

#pragma mark - button click

- (void)rightButtonClick
{
    NSLog(@"进入编辑状态！");
}


#pragma mark - data read

- (void)readMyData
{
    NSArray *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesStr = [caches firstObject];
    NSLog(@"cachesStr = %@",cachesStr);
    
    NSString *myDataFilePath = [cachesStr stringByAppendingPathComponent:@"myData.plist"];
    self.personInformationArray = [NSArray arrayWithContentsOfFile:myDataFilePath];
    NSLog(@"personInformationArray = %@",self.personInformationArray);
}

- (NSArray *)readMyDataForArray
{
    NSArray *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesStr = [caches firstObject];
    NSLog(@"cachesStr = %@",cachesStr);
    
    NSString *myDataFilePath = [cachesStr stringByAppendingPathComponent:@"myData.plist"];
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
