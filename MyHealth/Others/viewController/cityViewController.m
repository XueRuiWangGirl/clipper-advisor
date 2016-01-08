//
//  cityViewController.m
//  MyHealth
//
//  Created by imac on 15/11/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "cityViewController.h"
#import "cityGroup.h"
#import "citySearchResultViewController.h"
@interface cityViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,strong)citySearchResultViewController *citySearchResult;
//分类城市数组
@property (nonatomic, strong) NSArray *cityGroups;


@end

@implementation cityViewController
-(citySearchResultViewController *)citySearchResult
{
    if (!_citySearchResult) {
        citySearchResultViewController *citySearchResult=[[citySearchResultViewController alloc]init];
        [self addChildViewController:citySearchResult];
        self.citySearchResult=citySearchResult;
        [self.view addSubview:self.citySearchResult.view];
     
    }
    return _citySearchResult;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    self.title = @"切换城市";
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_navigation_close"] style:UIBarButtonItemStyleDone target:self action:@selector(closeClick)];
    //    self.tableView.sectionIndexBackgroundColor = [UIColor redColor];
    //右侧索引
    self.tableView.sectionIndexColor = [UIColor blackColor];
    
    // 加载城市数据
    self.cityGroups=[cityGroup objectArrayWithFilename:@"cityGroups.plist"];
  
    // Do any additional setup after loading the view from its nib.
}
- (void)closeClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 搜索框代理方法
/**
 *  键盘弹出:搜索框开始编辑文字
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 1.隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // 2.修改搜索框的背景图片
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    // 3.显示搜索框右边的取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    
}
/**
 *  键盘退下:搜索框结束编辑文字
 */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // 1.显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // 2.修改搜索框的背景图片
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    
    // 3.隐藏搜索框右边的取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    
    // 4.移除搜索结果
    self.citySearchResult.view.hidden = YES;
    searchBar.text = nil;
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        self.citySearchResult.view.hidden=NO;
        self.citySearchResult.searchText=searchText;
    }else
    {
        self.citySearchResult.view.hidden=YES;
    }
}
/**
 *  搜索框里面的文字变化的时候调用
 */
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    if (searchText.length) {
//        self.citySearchResult.view.hidden = NO;
//        self.citySearchResult.searchText = searchText;
//    } else {
//        self.citySearchResult.view.hidden = YES;
//    }
//}

#pragma mark-数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    cityGroup *group = self.cityGroups[section];
    return group.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cityGroup *group = self.cityGroups[indexPath.section];
    cell.textLabel.text = group.cities[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    cityGroup *group = self.cityGroups[section];
    return group.title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.cityGroups valueForKeyPath:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cityGroup *group = self.cityGroups[indexPath.section];
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CityDidChangeNotification" object:nil userInfo:@{@"SelectCityName":group.cities[indexPath.row]}];
    [self dismissViewControllerAnimated:YES completion:nil];
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
