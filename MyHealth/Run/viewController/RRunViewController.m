//
//  RRunViewController.m
//  MyHealth
//
//  Created by imac on 15/10/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RRunViewController.h"
#import "RRunView.h"
#import "RMapViewController.h"
#define KScreenWidth [UIScreen mainScreen].bounds.size.width  //屏幕宽
#define KScreenHeight [UIScreen mainScreen].bounds.size.height //屏幕高
@interface RRunViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) RRunView *today;
@property (nonatomic, strong) RRunView *yesterday;


@end

@implementation RRunViewController

#pragma mark - View Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController setToolbarHidden:YES animated:YES];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshStatistics) name:UIApplicationDidBecomeActiveNotification object:nil];
}
//-(void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Run";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMap) name:@"distanceClick" object:nil];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.segmentControl];
    self.healthStore = [[HKHealthStore alloc]init];
    //判断HealthKit是否可用
    BOOL avialable = [HKHealthStore isHealthDataAvailable];
    NSLog(@"avialable : %d",avialable);
    [self requestToReadType];
    NSLog(@"Height----%f",KScreenHeight);
    
}
//向HealthKit请求数据
- (void)requestToReadType{
    NSSet *set = [self dataTypesToRead];
    
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:set completion:^(BOOL success, NSError *error) {
        if (success) {
            [self readStepCountData];
            [self readDisranceData];
//            [self readEnergyCalorie];
            
        }else{
            NSLog(@"Faile");
        }
    }];
}
- (NSSet*)dataTypesToRead
{
    //步数
    HKQuantityType *stepCount = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //路程
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    //运动燃烧的能量
    HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    return [NSSet setWithObjects:stepCount, distanceType, activeEnergyBurnType, nil];
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.today = [[RRunView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_scrollView addSubview:self.today];
        self.yesterday = [[RRunView alloc] initWithFrame:CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight)];
        [_scrollView addSubview:self.yesterday];
        RRunView *beforYes = [[RRunView alloc] initWithFrame:CGRectMake(KScreenWidth*2, 0, KScreenWidth, KScreenHeight)];
        [_scrollView addSubview:beforYes];
        _scrollView.contentSize = CGSizeMake(3*KScreenWidth, 0);
        _scrollView.directionalLockEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        
    }
    return _scrollView;
}

- (UISegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        NSArray *array = [NSArray arrayWithObjects:@"今天",@"昨天",@"前天", nil];
        _segmentControl = [[UISegmentedControl alloc] initWithItems:array];
        _segmentControl.frame = CGRectMake((KScreenWidth-300)/2, 64+(KScreenHeight/17), 300, 40);
        _segmentControl.tintColor = [UIColor brownColor];
        _segmentControl.selectedSegmentIndex = 0;
        [_segmentControl addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

#pragma mark - Click事件
- (void)segmentClick:(UISegmentedControl *)sender
{
    CGPoint scrPoint = CGPointMake(10, -64);
    scrPoint.x = sender.selectedSegmentIndex *self.scrollView.frame.size.width;
    NSLog(@"sctpoint = %@",NSStringFromCGPoint(scrPoint));
    [self.scrollView setContentOffset:scrPoint animated:YES] ;
//    [self requestToReadType];
}
#pragma mark - 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/self.view.frame.size.width;
    NSLog(@"index=%d",index);
    NSLog(@"point ===== %@",NSStringFromCGPoint(scrollView.contentOffset));
    self.segmentControl.selectedSegmentIndex = index;
    if(index==0||index == 1)
    {
        [self requestToReadType];
    }
}
#pragma mark - showMap
- (void)showMap
{
    RMapViewController *mapVC = [[RMapViewController alloc] initWithNibName:@"RMapViewController" bundle:nil];
    [self.navigationController pushViewController:mapVC animated:YES];
}
#pragma mark - Reading HealthKit Data
- (void)readStepCountData{
    int index = self.scrollView.contentOffset.x/self.view.frame.size.width;
    NSPredicate *predicate = nil;
    if (index == 0) {
        predicate = [self predicateForToday];
    }else if (index == 1){
        predicate = [self predicateForYesterday];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        HKSampleType *quantityType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
            HKQuantity *sumStep = [result sumQuantity];
            
            NSInteger stepCount = [sumStep doubleValueForUnit:[HKUnit countUnit]];
            NSLog(@"stepCount = %ld",(long)stepCount);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (index == 0) {
                [self.today.stepsBtn setTitle:[NSString stringWithFormat:@"%ld步",stepCount] forState:UIControlStateNormal] ;
                float calorie = stepCount*0.5/1000*157;
                [self.today.calorieBtn setTitle:[NSString stringWithFormat:@"%.1f",calorie] forState:UIControlStateNormal] ;
                [self writeToCacheWith:stepCount];
               
                }else if(index == 1){
                    [self.yesterday.stepsBtn setTitle:[NSString stringWithFormat:@"%ld步",stepCount] forState:UIControlStateNormal];
                    float calorie = stepCount*0.5/1000*157;
                    [self.yesterday.calorieBtn setTitle:[NSString stringWithFormat:@"%.1f",calorie] forState:UIControlStateNormal] ;
                }
                
            });
            
        }];
        [self.healthStore executeQuery:query];
        
    });
    
}
//读取距离数据
- (void)readDisranceData
{
    int index = self.scrollView.contentOffset.x/self.view.frame.size.width;
    NSPredicate *predicate = nil;
    if (index == 0) {
        predicate = [self predicateForToday];
    }else if (index == 1){
        predicate = [self predicateForYesterday];
    }
//    NSPredicate *predicate = [self predicateForToday];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        HKSampleType *quantityType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
        HKStatisticsQuery *distanceQuary = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
            HKQuantity *sumDistance = [result sumQuantity];
            float distance = [sumDistance doubleValueForUnit:[HKUnit meterUnit]];
            NSLog(@"distance===%f",distance);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (index == 0) {
                    [self.today.distanceBtn setTitle:[NSString stringWithFormat:@"%.2f",distance/1000.0] forState:UIControlStateNormal];
                }else if (index == 1){
                    [self.yesterday.distanceBtn setTitle:[NSString stringWithFormat:@"%.2f",distance/1000.0 ] forState:UIControlStateNormal];
                }
            });
        }];
        [self.healthStore executeQuery:distanceQuary];
    });
}
//读取运动消耗能量
- (void)readEnergyCalorie
{
    NSPredicate *predicate = [self predicateForToday];
    HKSampleType *quantityType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        HKStatisticsQuery *calorieQuary = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
            HKQuantity *sumDistance = [result sumQuantity];
            float calorie = [sumDistance doubleValueForUnit:[HKUnit kilocalorieUnit]];
            NSLog(@"calorie===%f",calorie);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.today.calorieBtn setTitle:[NSString stringWithFormat:@"%.2f",calorie] forState:UIControlStateNormal] ;
            });
        }];
        [self.healthStore executeQuery:calorieQuary];
    });
}
#pragma mark - Convenience
- (NSPredicate *)predicateForToday
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calender dateFromComponents:components];
    NSDate *endDate = [calender dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}
- (NSPredicate *)predicateForYesterday
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date ];
    NSDateComponents *components = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *todayDate = [calender dateFromComponents:components];
    NSDate *yesterdayDate = [NSDate dateWithTimeInterval:-(24*60*60) sinceDate:todayDate];
    return [HKQuery predicateForSamplesWithStartDate:yesterdayDate endDate:todayDate options:HKQueryOptionStrictStartDate];
}
#pragma mark - writeToCache
- (void)writeToCacheWith:(NSInteger)count
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"steps.plist"];
    NSLog(@"path----%@",path);
    NSArray *steps = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld",count], nil];
    [steps writeToFile:path atomically:YES];
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
