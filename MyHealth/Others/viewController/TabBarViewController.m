//
//  TabBarViewController.m
//  MyHealth
//
//  Created by imac on 15/10/25.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "TabBarViewController.h"
#import "OTabBar.h"
#import "MainNavigatioController.h"
#import "AchivmentViewController.h"
#import "SearchCollectionViewController.h"
#import "AsignViewController.h"
@interface TabBarViewController ()<OTabBarDelegate>
@property (nonatomic,strong)NSMutableArray *items;

@end

@implementation TabBarViewController
-(NSMutableArray *)items
{
    if (!_items) {
        _items=[NSMutableArray array];
    }
    return _items;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNavigationTitle:) name:@"changeNavigationTitle" object:nil];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setAsignNavigationTitle:) name:@"changeAsignNavigationTitle" object:nil];
    [self setUpAllChildViewController];
    [self setUpTabBar];
  
    // Do any additional setup after loading the view from its nib.
}
- (void)setNavigationTitle:(NSNotification*) notification
{
    self.title = notification.userInfo[@"myNavigationTitle"];
    self.navigationItem.rightBarButtonItem=notification.userInfo[@"rightBarBtn"];
}
//- (void)setAsignNavigationTitle:(NSNotification*) notification
//{
////    NSLog(@"change navigation controller title!");
//    NSLog(@"%@",notification.userInfo[@"NavigationTitle"]);
//    self.title = notification.userInfo[@"NavigationTitle"];
//   
//}
#pragma mark - 设置tabBar
- (void)setUpTabBar
{
    // 自定义tabBar
    OTabBar *tabBar = [[OTabBar alloc] initWithFrame:self.tabBar.frame];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    // 添加自定义tabBar
    [self.view addSubview:tabBar];
    
    // 移除系统的tabBar
    [self.tabBar removeFromSuperview];
}
#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(OTabBar *)tabBar didClickButton:(NSInteger)index
{
    self.selectedIndex = index;
}
#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController
{
    AchivmentViewController *achiv=[[AchivmentViewController alloc]initWithNibName:@"AchivmentViewController" bundle:nil];
    
    [self setUpOneChildViewController:achiv image:[UIImage imageNamed:@"tabbar_home.png"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected.png"] title:@"个人成就"];
    SearchCollectionViewController *search=[[SearchCollectionViewController alloc]initWithNibName:@"SearchCollectionViewController" bundle:nil];
    [self setUpOneChildViewController:search image:[UIImage imageNamed:@"tabbar_discover.png"] selectedImage:[UIImage imageNamed:@"tabbar_discover_selected.png"] title:@"周边"];
    
    AsignViewController *asign=[[AsignViewController alloc]initWithNibName:@"AsignViewController" bundle:nil];
    [self setUpOneChildViewController:asign image:[UIImage imageNamed:@"asign.jpg"] selectedImage:[UIImage imageNamed:@"asign.jpg"] title:@"动起来"];
}
#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    //    // navigationItem模型
    //    vc.navigationItem.title = title;
    //
    //    // 设置子控件对应tabBarItem的模型属性
    //    vc.tabBarItem.title = title;
    vc.title = title;
    vc.tabBarItem.image = image;
    
    
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    
    
    [self addChildViewController:vc];
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
