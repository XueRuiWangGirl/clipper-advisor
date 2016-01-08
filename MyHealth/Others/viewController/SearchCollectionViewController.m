//
//  SearchCollectionViewController.m
//  MyHealth
//
//  Created by imac on 15/11/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SearchCollectionViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "HomeTopItem.h"
#import "OtherVIew.h"
#import "cityViewController.h"
#import "DPAPI.h"
#import "DealCell.h"
#import "DetailViewController.h"

@interface SearchCollectionViewController ()<UIAlertViewDelegate, DPRequestDelegate, UICollectionViewDelegate,CLLocationManagerDelegate>
@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)CLGeocoder *geoCoder;
//取得地名
@property (nonatomic,strong)CLPlacemark *placemark;
//取得坐标
@property (nonatomic,assign)CLLocationCoordinate2D coordinate;
@property (nonatomic,strong) HomeTopItem *districtItem;
@property (nonatomic,strong)UIBarButtonItem *disBtnItem;
/** 所有的团购数据 */
@property (nonatomic, strong) NSMutableArray *deals;
/** 记录当前页码 */
@property (nonatomic, assign) int  currentPage;
/** 最后一个请求 */
@property (nonatomic, weak) DPRequest *lastRequest;
/** 当前选中的城市名字 */
@property (nonatomic, copy) NSString *selectedCityName;
/** 总数 */
@property (nonatomic, assign) int  totalCount;
//无数据显示图
@property (nonatomic, weak) UIImageView *noDataView;
@property (nonatomic,strong)UIAlertView *alertView;
@end

@implementation SearchCollectionViewController
-(UIAlertView *)alertView
{
    if (!_alertView) {
        _alertView=[[UIAlertView alloc]initWithTitle:@"是否开启定位服务" message:@"请选择" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"开启", nil];
        _alertView.delegate=self;
        
    }return _alertView;
}
- (UIImageView *)noDataView
{
    if (!_noDataView) {
        // 添加一个"没有数据"的提醒
        UIImageView *noDataView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downLoad.png"]];
        [self.view addSubview:noDataView];
        //让这个imageview永远在父视图的正中间
        [noDataView autoCenterInSuperview];
        self.noDataView = noDataView;
    }
    return _noDataView;
}
- (NSMutableArray *)deals
{
    if (!_deals) {
        self.deals = [[NSMutableArray alloc] init];
    }
    return _deals;
}
static NSString * const reuseIdentifier = @"DealCell";

//-(instancetype)init
//{
//    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
//    // cell的大小
//    layOut.itemSize = CGSizeMake(305, 305);
//    return [self initWithCollectionViewLayout:layOut];

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNavigationTitle" object:nil userInfo:@{@"myNavigationTitle":@"周边健身",@"rightBarBtn":self.disBtnItem}];
    
}
#pragma mark-viewDidAppear
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //定位管理器
    // 监听城市改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityDidChange:) name:@"CityDidChangeNotification" object:nil];
    self.geoCoder=[[CLGeocoder alloc]init];
    [self getAddressByLatitude:39.54 longitude:116.28];
    self.locationManager=[[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]) {
        [self.alertView show];
        return;
    }
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    }else if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率，每隔多少米
        CLLocationDistance distance=100.0;
        _locationManager.distanceFilter=distance;
        //启动跟踪走位
        [_locationManager startUpdatingLocation];
        
    }
    //添加下拉刷新
    [self.collectionView addHeaderWithTarget:self action:@selector(loadRegionDeals)];
    //        [self loadRegionDeals];
    
    //    self.currentPage=1;
    //    [self loadNewDeals];
    [self.collectionView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"周边";
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //向上拉有弹簧效果
    self.collectionView.alwaysBounceVertical = YES;
    
    // 监听城市改变
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityDidChange:) name:@"CityDidChangeNotification" object:nil];
    //设置背景
   [self.collectionView setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"search.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]];
    [self setUpLeft];
    self.currentPage = 1;
    // 添加上拉刷新
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    //添加下拉刷新
    [self.collectionView addHeaderWithTarget:self action:@selector(loadRegionDeals)];
    
    //传入当前坐标
    self.geoCoder=[[CLGeocoder alloc]init];
     [self getAddressByLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
 
    // Do any additional setup after loading the view.
}
#pragma mark-loadMoreDeals
-(void)loadMoreDeals
{
    self.currentPage++;
    [self loadNewDeals];
    
}
#pragma mark-loadNewDeals
-(void)loadRegionDeals
{
    self.currentPage=1;
    [self loadNewDeals];
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //当同时进行多次网络请求，无法确定哪一条请求先返回，而实际上我们需要的是最近一次操作的请求结果，那么我们就定义一个变量用来保存最近一次操作的请求，当有返回结果的时候，把返回结果的请求跟自定义的变量里面的请求作比对。
    if (request != self.lastRequest) return;
    self.totalCount = [result[@"total_count"] intValue];
    
    // 1.取出团购的字典数组
    NSArray *newDeals = [Deal objectArrayWithKeyValuesArray:result[@"deals"]];
    if (self.currentPage == 1) { // 清除之前的旧数据
        [self.deals removeAllObjects];
    }
    [self.deals addObjectsFromArray:newDeals];
    
    // 2.刷新表格
    [self.collectionView reloadData];
    
    // 3.结束上拉加载
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    if (request != self.lastRequest) return;
    
    // 1.提醒失败
    [MBProgressHUD showError:@"网络繁忙,请稍后再试" toView:self.view];
    
    // 2.结束刷新
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
    
    // 3.如果是上拉加载失败了
    if (self.currentPage > 1) {
        self.currentPage--;
    }
}


#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        self.placemark=[placemarks firstObject];
        NSLog(@"详细信息:%@",self.placemark.addressDictionary);
    }];

}
#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    self.coordinate=location.coordinate;//位置坐标
//    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",self.coordinate.longitude,self.coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
    
    
}


-(void)cityDidChange:(NSNotification *)notification
{
    //接收选择的城市的名字
    self.selectedCityName = notification.userInfo[@"SelectCityName"];
    HomeTopItem *topItem = (HomeTopItem *)self.disBtnItem.customView;
    [topItem setTitle:[NSString stringWithFormat:@"%@", self.selectedCityName]];
    
    
    // 2.刷新表格数据
//    [self loadNewDeals];
    [self.collectionView headerBeginRefreshing];
}
#pragma mark-loadNewDeal网络请求，加载最新团购信息
-(void)loadNewDeals
{
    DPAPI *api=[[DPAPI alloc]init];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    if (self.selectedCityName) {
        params[@"city"]=self.selectedCityName;
    }else
    {

        NSLog(@"cityname-----%@",[self.placemark.addressDictionary[@"City"] class]);
        NSString *str=self.placemark.addressDictionary[@"City"];
        NSLog(@"str===%@",str);
        NSString *strcity=[str substringToIndex:str.length-1];
      
        
//        [self.placemark.addressDictionary[@"City"] substringToIndex:self.placemark.addressDictionary[@"City"].length];
    params[@"city"]=strcity;
    }
 
    
    // 每页的条数
    params[@"limit"] = @6;
    // 页码
    params[@"page"] = @(self.currentPage);
    params[@"category"] = @"运动健身";

    self.lastRequest = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

-(void)setUpLeft
{
    self.districtItem=[HomeTopItem item];
    [self.districtItem.TopButton addTarget:self action:@selector(districtItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.disBtnItem=[[UIBarButtonItem alloc]initWithCustomView:self.districtItem];
    
    self.navigationItem.rightBarButtonItem=self.disBtnItem;
  

}
#pragma mark-districtItemClick
-(void)districtItemClick
{
    cityViewController *cityVc=[[cityViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:cityVc];
    nav.modalPresentationStyle=UIModalPresentationFormSheet;
//    [self presentViewController:nav animated:YES completion:nil];
      [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
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
#pragma mark- <UICollectionViewDelegate>
//定义每个collectionview的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width-20)/2,(self.view.frame.size.width-20)/2+115);
}
//定义每个uicollectionview的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  UIEdgeInsetsMake(3, 5, 3, 5);
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 控制尾部刷新控件的显示和隐藏
    self.collectionView.footerHidden = (self.totalCount == self.deals.count);
    
    // 控制"没有数据"的提醒
    self.noDataView.hidden = (self.deals.count != 0);
    return self.deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    UINib *nib = [UINib nibWithNibName:@"DealCell" bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
        DealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.deal = self.deals[indexPath.item];
        

    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVc = [[DetailViewController alloc] init];
     UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:detailVc];
    detailVc.deal = self.deals[indexPath.item];
    [self presentViewController:nav animated:YES completion:nil];
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
