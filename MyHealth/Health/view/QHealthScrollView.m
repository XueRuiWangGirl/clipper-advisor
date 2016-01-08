//
//  QHealthScrollView.m
//  MyHealth
//
//  Created by 秦森 on 15/10/24.
//  Copyright © 2015年 imac. All rights reserved.
//

#import "QHealthScrollView.h"
#import "QHealthView.h"
#import "UIImageView+WebCache.h"

#define WIDTH ([UIScreen mainScreen].bounds.size.width-4)
#define HEIGHT (([UIScreen mainScreen].bounds.size.height-66)/3-4)

@interface QHealthScrollView ()

@property (nonatomic, strong) NSDictionary *healths;

@property (nonatomic, strong) QHealthView *data1;
@property (nonatomic, strong) QHealthView *data2;
@property (nonatomic, strong) QHealthView *data3;

@end

@implementation QHealthScrollView

#pragma mark - myself init

- (instancetype)initForMyself
{
    self = [super init];
    if (self) {
        CGRect frame = CGRectMake(2, 70+HEIGHT*2, WIDTH, HEIGHT);
        NSLog(@"%@",NSStringFromCGRect(frame));
        self.frame = frame;
        self.backgroundColor = [UIColor yellowColor];
        self.contentSize = CGSizeMake(WIDTH*3, 0);
        self.pagingEnabled = YES;
        self.directionalLockEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

//- (NSDictionary *)healths
//{
//    if (!_healths) {
//        _healths = [NSMutableDictionary dictionary];
//    }
//    return _healths;
//}

#pragma mark - add view

- (void)addView
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHealth:) name:@"loadingHealth" object:nil];
    NSString *httpUrl = @"http://apis.baidu.com/txapi/health/health";
    NSString *httpArg = @"num=10&page=1";
    [self request: httpUrl withHttpArg: httpArg];
    CGRect frame1 = CGRectMake(0, 0, WIDTH, HEIGHT);
    CGRect frame2 = CGRectMake(WIDTH, 0, WIDTH, HEIGHT);
    CGRect frame3 = CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT);
    self.data1 = [QHealthView loadWithNib];
    self.data1.frame = frame1;
    self.data1.backgroundColor = [UIColor lightGrayColor];
    self.data2 = [QHealthView loadWithNib];
    self.data2.frame = frame2;
    self.data2.backgroundColor = [UIColor lightGrayColor];
    self.data3 = [QHealthView loadWithNib];
    self.data3.frame = frame3;
    self.data3.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.data1];
    [self addSubview:self.data2];
    [self addSubview:self.data3];
}

#pragma mark - web download

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"9910c68835da7b9479c1e1c05ddd3bae" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
                                   dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                       NSLog(@"%@",[NSThread currentThread]);
                                       self.healths = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"loadingHealth" object:nil userInfo:self.healths];
                                       [self changeHealthWithDictionary:self.healths];
                                       NSLog(@"54321\n%@",self.healths);
                                   });
                                  
                               }
                           }];
}

- (void)changeHealth:(NSNotification *)notification
{
    [self setHealthViewWith:self.data1 withDictionaryOne:notification.userInfo[@"0"] andDictionaryTwo:notification.userInfo[@"1"]];
    [self setHealthViewWith:self.data2 withDictionaryOne:notification.userInfo[@"2"] andDictionaryTwo:notification.userInfo[@"3"]];
    [self setHealthViewWith:self.data3 withDictionaryOne:notification.userInfo[@"4"] andDictionaryTwo:notification.userInfo[@"5"]];
    
}
- (void)changeHealthWithDictionary:(NSDictionary *)dictionary
{
    [self setHealthViewWith:self.data1 withDictionaryOne:dictionary[@"0"] andDictionaryTwo:dictionary[@"1"]];
    [self setHealthViewWith:self.data2 withDictionaryOne:dictionary[@"2"] andDictionaryTwo:dictionary[@"3"]];
    [self setHealthViewWith:self.data3 withDictionaryOne:dictionary[@"4"] andDictionaryTwo:dictionary[@"5"]];
    
}


- (void)setHealthViewWith:(QHealthView *)dataView withDictionaryOne:(NSDictionary *)dictionaryOne andDictionaryTwo:(NSDictionary *)dictionaryTwo
{
    [dataView.imageOne sd_setImageWithURL:[NSURL URLWithString:dictionaryOne[@"picUrl"]]];
    [dataView.imageTwo sd_setImageWithURL:[NSURL URLWithString:dictionaryTwo[@"picUrl"]]];
    
    dataView.timeLabelOne.text = dictionaryOne[@"time"];
    dataView.timeLabelTwo.text = dictionaryTwo[@"time"];
    
    dataView.titleLabelOne.text = dictionaryOne[@"title"];
    dataView.titleLabelTwo.text = dictionaryTwo[@"title"];
    
    dataView.descLabelOne.text = dictionaryOne[@"description"];
    dataView.descLabelTwo.text = dictionaryTwo[@"description"];
    
    dataView.URLStringOne = dictionaryOne[@"url"];
    dataView.URLStringTwo = dictionaryTwo[@"url"];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
