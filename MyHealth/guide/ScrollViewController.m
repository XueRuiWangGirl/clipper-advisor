//
//  ScrollViewController.m
//  MyHealth
//
//  Created by imac on 15/10/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ScrollViewController.h"
#import "OneView.h"
#import "TwoView.h"
#import "ThreeView.h"
#import "FourView.h"
@interface ScrollViewController ()<UIScrollViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSString *yearStr;
    NSString *sexStr;
    NSString *bloodStr;
    NSString *xinStr;
    NSString *heghtStr;
    NSString *expStr;
    NSString *tallStr;
    int num;
}
@property (nonatomic, strong) OneView *ve1;
@property (nonatomic, strong) TwoView *ve2;
@property (nonatomic, strong) ThreeView *ve3;
@property (nonatomic, strong) FourView *ve4;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) UILabel *lableOne;
@property (nonatomic, strong) UILabel *lableOneo;

@property (nonatomic, strong) UIPickerView *tpickerView;
@property (nonatomic, strong) NSArray *tarray;
@property (nonatomic, strong) NSArray *ariesArray;
@property (nonatomic, strong) UILabel *lableTwo;
@property (nonatomic, strong) UILabel *lableTwoo;

@property (nonatomic, strong) UIPickerView *thpickerView;
@property (nonatomic, strong) NSMutableArray *tharray;
@property (nonatomic, strong) NSMutableArray *exArray;
@property (nonatomic, strong) NSMutableArray *tallArray;
@property (nonatomic, strong) UILabel *lableThree;
@property (nonatomic, strong) UILabel *lableThreeo;
@property (nonatomic, strong) UILabel *lableThreeoo;

@property (nonatomic, strong) NSMutableArray *arrayAll;

@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)UIPageControl *page;


@property (nonatomic, strong) UIButton *btn;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrayAll = [NSMutableArray array];
    num = 0;
    [self Build];
}
- (void)Build
{
    [self.view addSubview:self.scroll];
    [self.scroll addSubview:self.pickerView];
    [self.scroll addSubview:self.tpickerView];
    [self.scroll addSubview:self.thpickerView];
    [self.scroll addSubview:self.lableOne];
    [self.scroll addSubview:self.lableOneo];
    [self.scroll addSubview:self.lableTwo];
    [self.scroll addSubview:self.lableTwoo];
    [self.scroll addSubview:self.lableThree];
    [self.scroll addSubview:self.lableThreeo];
    [self.scroll addSubview:self.lableThreeoo];
    [self.scroll addSubview:self.btn];
    [self.view addSubview:self.page];
    
}

-(UIScrollView *)scroll
{
    if (!_scroll) {
        //        初始化scroll
        self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        
        self.scroll.pagingEnabled = YES;
        self.scroll.scrollEnabled = YES;
        
        self.scroll.contentSize = CGSizeMake(WI*4, HI);
        
        self.ve1 = [[OneView alloc]init];
        self.ve1.frame = CGRectMake(0, 0, WI, HI) ;
        [self.scroll addSubview:self.ve1];
        
        self.ve2 = [[TwoView alloc]init];
        self.ve2.frame = CGRectMake(WI, 0, WI, HI) ;
        [self.scroll addSubview:self.ve2];
        
        self.ve4 = [[FourView alloc]init];
        self.ve4.frame = CGRectMake(WI*3, 0, WI, HI) ;
        [self.scroll addSubview:self.ve4];
        
        self.ve3 = [[ThreeView alloc]init];
        self.ve3.frame = CGRectMake(WI*2, 0, WI, HI) ;
        [self.scroll addSubview:self.ve3];
        
        _scroll.delegate = self;
        _scroll.delegate = self;
    }
    return _scroll;
}

#pragma mark - 第二页的输入
-(UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(WI, 100, WI, HI-200)];
        _pickerView.tag = 99;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
    }
    return _pickerView;
}
- (UILabel *)lableOne
{
    if (!_lableOne) {
        _lableOne = [[UILabel alloc] initWithFrame:CGRectMake(WI+50, 120, 120, 60)];
        _lableOne.textAlignment = NSTextAlignmentCenter;
        _lableOne.text = @"何时出生";
        _lableOne.font = [UIFont systemFontOfSize:21];
    }
    return _lableOne;
}
- (UILabel *)lableOneo
{
    if (!_lableOneo) {
        _lableOneo = [[UILabel alloc] initWithFrame:CGRectMake(WI+250, 120, 120, 60)];
        _lableOneo.textAlignment = NSTextAlignmentCenter;
        _lableOneo.text = @"性别";
        _lableOneo.font = [UIFont systemFontOfSize:21];
    }
    return _lableOneo;
}
- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
        for (int i = 0; i<58; i++) {
            if (i==0) {
                [_array addObject:@"请选择"];
            }else
            {
           num = 1960+i;
            NSString *year = [NSString stringWithFormat:@"%d年",num];
                [_array addObject:year];
            }
        }
    }
    
    return _array;
}
- (NSArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = @[@"请选择",@"Male",@"Female"];
    }
    return _nameArray;
}
#pragma mark - 第三页的输入
-(UIPickerView *)tpickerView
{
    if (!_tpickerView) {
        _tpickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(WI*2, 100, WI, HI-200)];
        _tpickerView.tag = 100;
        _tpickerView.delegate = self;
        _tpickerView.dataSource = self;
        
    }
    return _tpickerView;
}

- (NSArray *)tarray
{
    if (!_tarray) {
        _tarray = @[@"请选择",@"A型",@"B型",@"AB型",@"O型",@"Other"];
    }
    return _tarray;
}
- (NSArray *)ariesArray
{
    if (!_ariesArray) {
        _ariesArray = @[@"请选择",@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座"];
    }
    return _ariesArray;
}
- (UILabel *)lableTwo
{
    if (!_lableTwo) {
        _lableTwo = [[UILabel alloc] initWithFrame:CGRectMake(WI*2+50, 120, 120, 60)];
        _lableTwo.textAlignment = NSTextAlignmentCenter;
        _lableTwo.text = @"血型";
        _lableTwo.font = [UIFont systemFontOfSize:21];
    }
    return _lableTwo;
}
- (UILabel *)lableTwoo
{
    if (!_lableTwoo) {
        _lableTwoo = [[UILabel alloc] initWithFrame:CGRectMake(WI*2+250, 120, 120, 60)];
        _lableTwoo.textAlignment = NSTextAlignmentCenter;
        _lableTwoo.text = @"星座";
        _lableTwoo.font = [UIFont systemFontOfSize:21];
    }
    return _lableTwoo;
}
#pragma mark - 第四页的输入
-(UIPickerView *)thpickerView
{
    if (!_thpickerView) {
        _thpickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(WI*3, 100, WI, HI-200)];
        _thpickerView.tag = 101;
        _thpickerView.delegate = self;
        _thpickerView.dataSource = self;
        
    }
    return _thpickerView;
}
- (UILabel *)lableThree
{
    if (!_lableThree) {
        _lableThree = [[UILabel alloc] initWithFrame:CGRectMake(WI*3+10, 120, 120, 60)];
        _lableThree.textAlignment = NSTextAlignmentCenter;
        _lableThree.text = @"体重";
        _lableThree.font = [UIFont systemFontOfSize:21];
    }
    return _lableThree;
}
- (UILabel *)lableThreeo
{
    if (!_lableThreeo) {
        _lableThreeo = [[UILabel alloc] initWithFrame:CGRectMake(WI*3+150, 120, 120, 60)];
        _lableThreeo.textAlignment = NSTextAlignmentCenter;
        _lableThreeo.text = @"期望体重";
        _lableThreeo.font = [UIFont systemFontOfSize:21];
    }
    return _lableThreeo;
}
- (UILabel *)lableThreeoo
{
    if (!_lableThreeoo) {
        _lableThreeoo = [[UILabel alloc] initWithFrame:CGRectMake(WI*3+280, 120, 120, 60)];
        _lableThreeoo.textAlignment = NSTextAlignmentCenter;
        _lableThreeoo.text = @"身高";
        _lableThreeoo.font = [UIFont systemFontOfSize:21];
    }
    return _lableThreeoo;
}
- (NSMutableArray *)tharray
{
    if (!_tharray) {
        _tharray = [NSMutableArray array];
        int a= 0;
        for (int i = 0; i<80; i++) {
            if (i==0) {
                [_tharray addObject:@"请选择"];
            }else{
            a = 40+i;
            NSString *year = [NSString stringWithFormat:@"%dKg",a];
                [_tharray addObject:year];
            }
        }
    }
    return _tharray;
}
- (NSMutableArray *)exArray
{
    if (!_exArray) {
        _exArray = [NSMutableArray array];
        int a= 0;
        for (int i = 0; i<80; i++) {
            if (i==0) {
                [_exArray addObject:@"请选择"];
            }else{
            a = 40+i;
            NSString *year = [NSString stringWithFormat:@"%dKg",a];
                [_exArray addObject:year];
            }
        }
    }
    return _exArray;
}
- (NSMutableArray *)tallArray
{
    if (!_tallArray) {
        _tallArray = [NSMutableArray array];
        int a= 0;
        for (int i = 0; i<100; i++) {
            if (i==0) {
                [_tallArray addObject:@"请选择"];
            }else{
            a = 121+i;
            NSString *year = [NSString stringWithFormat:@"%dcm",a];
            [_tallArray addObject:year];
            }
        }
    }
    return _tallArray;
}

#pragma mark - 数据源方法
//根据列号返货的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 99) {
        return component == 0?59:3;
    }else if(pickerView.tag == 100)
    {
        return component == 0?6:13;
    }else
    {
        if (component<2) {
            return 81;
        }
        else
            return 101;
    }
}

//有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView.tag == 101) {
        return 3;
    }
    else{
    return 2;
    }
}

#pragma mark - 代理方法
//某一行某一列的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 99) {
    if (component == 0) {
        
        return self.array[row];
    }
    else{
        return self.nameArray[row];
    }
    }else if (pickerView.tag == 100){
        if (component == 0) {
            
            return self.tarray[row];
        }
        else{
            return self.ariesArray[row];
        }
    }else
    {
        if (component == 0) {
            
            return self.tharray[row];
        }
        else if(component == 1){
            return self.exArray[row];
        }else
        {
            return self.tallArray[row];
        }
    }
}

//当选中某一行时调用
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView.tag == 99) {
        switch (component) {
            case 0:
                yearStr = self.array[row];
                break;
            case 1:
                sexStr = self.nameArray[row];
                break;
            default:
                break;
        }
    }else if (pickerView.tag == 100) {
        switch (component) {
            case 0:
                bloodStr = self.tarray[row];
                break;
            case 1:
                xinStr = self.ariesArray[row];
                break;
            default:
                break;
        }
    }else if (pickerView.tag == 101) {
        switch (component) {
            case 0:
                heghtStr = self.tharray[row];
                break;
            case 1:
                expStr = self.exArray[row];
                break;
            case 2:
                tallStr = self.tallArray[row];
                break;
            default:
                break;
        }
    }
    
    NSLog(@"111");
    
}

#pragma mark -- 更换控制器
-(UIButton *)btn
{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(WI*3+112,550, WI/2, 50)];
        _btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"star"]];
        [self.btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}


-(UIPageControl *)page
{
    if (!_page) {
        self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, HI-100 , WI, 40)];
        self.page.numberOfPages = 4;
        self.page.enabled = NO;
        self.page.currentPageIndicatorTintColor = [UIColor whiteColor];
        
    }
    return _page;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int i = (self.scroll.contentOffset.x)/self.scroll.frame.size.width;
    self.page.currentPage = i;
}
- (void)click
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app passValue];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [arrayPath[0] stringByAppendingPathComponent:@"myData.plist"];
    NSArray *array = [NSArray arrayWithObjects:yearStr,sexStr,bloodStr,xinStr,heghtStr,expStr,tallStr, nil];
    [array writeToFile:path atomically:YES];
    NSLog(@"%@",path);
    NSLog(@"%@",array);
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
