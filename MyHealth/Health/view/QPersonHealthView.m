//
//  PersonHealthView.m
//  MyHealth
//
//  Created by imac on 15/10/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "QPersonHealthView.h"
#import "QSPerson.h"
#import "LTInfiniteScrollView.h"

#define COLOR [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]

#define NUMBER_OF_VISIBLE_VIEWS 3

#define WIDTH [UIScreen mainScreen].bounds.size.width-4
#define HEIGHT ([UIScreen mainScreen].bounds.size.height-66)/3-4
#define WIDTH_1 (self.frame.size.width-8)/8
#define WIDTH_2 (self.frame.size.width-8)/6
#define WIDTH_3 (self.frame.size.width-8)/4
#define HEIGHT_LABEL 50


@interface QPersonHealthView ()<LTInfiniteScrollViewDelegate,LTInfiniteScrollViewDataSource>

@property (nonatomic,strong) LTInfiniteScrollView *scrollView;
@property (nonatomic) CGFloat viewSize;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSArray *arrayBack;

@end

@implementation QPersonHealthView


- (instancetype)initWithNavigationHeiht:(CGFloat)navHeight
{
    CGRect frame = CGRectMake(2, navHeight+22, WIDTH, HEIGHT);
    if (self = [super init]) {
        NSLog(@"%@",NSStringFromCGRect(frame));
        self.frame = frame;
        self.backgroundColor = [UIColor orangeColor];
    }
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"health_background"]];
//    self.backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"health_background"]];
    self.backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.backgroundImageView.image = [UIImage imageNamed:@"health_background"];
    [self addSubview:self.backgroundImageView];
    self.scrollView = [[LTInfiniteScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), HEIGHT)];
    [self addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.dataSource = self;
    self.scrollView.pagingEnabled= NO;
    
    self.viewSize = CGRectGetWidth(self.bounds) / NUMBER_OF_VISIBLE_VIEWS;
    [self.scrollView reloadData];
    return self;
}



- (NSArray *)array
{
    if (! _array) {
        _array = @[@"***",@"***",@"年龄",@"性别",@"血型",@"星座",@"身高",@"体重",@"期望体重",@"BMI",@"体型评价",@"***",@"***"];
    }
    return _array;
}

- (NSArray *)arrayBack
{
    if (! _arrayBack) {
        _arrayBack = @[@"***",@"***",@"22",@"Male",@"B",@"Aries",@"180",@"100",@"100",@"21",@"正常",@"***",@"***"];
    }
    return _arrayBack;
}


# pragma mark - LTInfiniteScrollView dataSource
- (NSInteger)numberOfViews
{
    return 11;
}

- (NSInteger)numberOfVisibleViews
{
    return NUMBER_OF_VISIBLE_VIEWS;
}

# pragma mark - LTInfiniteScrollView delegate
- (UIView *)viewAtIndex:(NSInteger)index reusingView:(UIView *)view;
{
    NSLog(@"%ld",(long)index);
    if (view) {
        if (index >= -6 && index <= 6) {
            ((UILabel*)view).text = [NSString stringWithFormat:@"%@", self.array[index + 6]];
        }
        return view;
    }
    
    UILabel *aView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.viewSize, self.viewSize)];
    aView.backgroundColor = [UIColor blackColor];
    aView.layer.cornerRadius = self.viewSize/2.0f;
    aView.layer.masksToBounds = YES;
    //    aView.backgroundColor = COLOR;
    aView.backgroundColor = [UIColor orangeColor];
    aView.textColor = [UIColor whiteColor];
    aView.textAlignment = NSTextAlignmentCenter;
    //    aView.text = [NSString stringWithFormat:@"%ld", (long)index];
    if (index >= -6 && index <= 6) {
        aView.text = [NSString stringWithFormat:@"%@", self.array[index + 6]];
    }
    return aView;
}

- (void)updateView:(UIView *)view withDistanceToCenter:(CGFloat)distance scrollDirection:(ScrollDirection)direction
{
    // you can appy animations duration scrolling here
    
    CGFloat percent = distance / CGRectGetWidth(self.bounds) * NUMBER_OF_VISIBLE_VIEWS;
    
    CATransform3D transform = CATransform3DIdentity;
    
    // scale
    CGFloat size = self.viewSize;
    CGPoint center = view.center;
    view.center = center;
    size = size * (1.4 - 0.3 * (fabs(percent)));
    view.frame = CGRectMake(0, 0, size, size);
    view.layer.cornerRadius = size / 2;
    view.center = center;
    
    // translate
    CGFloat translate = self.viewSize / 3 * percent;
    if (percent > 1) {
        translate = self.viewSize / 3;
    } else if (percent < -1) {
        translate = -self.viewSize / 3;
    }
    transform = CATransform3DTranslate(transform,translate, 0, 0);
    
    // rotate
    if (fabs(percent) < 1) {
        CGFloat angle = 0;
        if( percent > 0) {
            angle = - M_PI * (1-fabs(percent));
        } else {
            angle =  M_PI * (1-fabs(percent));
        }
        transform.m34 = 1.0/-600;
        if (fabs(percent) <= 0.5) {
            angle =  M_PI * percent;
            UILabel *label = (UILabel*) view;
            //            label.text = @"back";
            if (view.tag >= -6 && view.tag <= 6) {
                label.numberOfLines = 2;
                label.font = [UIFont systemFontOfSize:30];
                [label setAlpha:1];
                label.text = [NSString stringWithFormat:@"%@\n%@", self.array[view.tag+6], self.arrayBack[view.tag + 6]];
            }
            label.backgroundColor = [UIColor darkGrayColor];
        } else {
            UILabel *label = (UILabel*) view;
            if (view.tag >= -6 && view.tag <= 6) {
                label.font = [UIFont systemFontOfSize:18];
                [label setAlpha:0.6];
                label.text = [NSString stringWithFormat:@"%@", self.array[view.tag + 6]];
            }
            //            label.text = [NSString stringWithFormat:@"%d",(int)view.tag];
            label.backgroundColor = COLOR;
        }
        transform = CATransform3DRotate(transform, angle , 0.0f, 1.0f, 0.0f);
    } else {
        UILabel *label = (UILabel *)view;
        //        label.text = [NSString stringWithFormat:@"%d",(int)view.tag];
        if (view.tag >= -6 && view.tag <= 6) {
            label.font = [UIFont systemFontOfSize:18];
            [label setAlpha:0.6];
            label.text = [NSString stringWithFormat:@"%@", self.array[view.tag + 6]];
        }
        label.backgroundColor = COLOR;
    }
    
    view.layer.transform = transform;
    
}

# pragma mark - config views
- (void)configureForegroundOfLabel:(UILabel *)label
{
    NSString *text = [NSString stringWithFormat:@"%d",(int)label.tag];
    if ([label.text isEqualToString:text]) {
        return;
    }
    label.text = text;
    label.backgroundColor = COLOR;
}

- (void)configureBackgroundOfLabel:(UILabel *)label
{
    NSString* text = @"back";
    if ([label.text isEqualToString:text]) {
        return;
    }
    label.text = text;
    label.backgroundColor = [UIColor blackColor];
}
@end
