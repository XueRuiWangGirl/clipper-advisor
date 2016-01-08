//
//  OneDayView.m
//  MyHealth
//
//  Created by imac on 15/10/27.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "OneDayView.h"

@implementation OneDayView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
    self.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"foodmenuback1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self addSubview:self.breakfast_text];
        [self addSubview:self.lunch_text];
        [self addSubview:self.dinner_text];
        [self.breakfast_text addSubview:self.breakfastBtn];
        [self.lunch_text addSubview:self.lunchBtn];
        [self.dinner_text addSubview:self.dinnerBtn];
        [self reloadTableView];

    }
    return self;
}
#pragma mark - view

#pragma mark - 懒加载
- (UIButton *)breakfastBtn
{
    if (!_breakfastBtn) {
        _breakfastBtn = [[UIButton alloc]initWithFrame:CGRectMake(230, 0, 80, 30)];
        [_breakfastBtn setTitle:@"删除早餐" forState:UIControlStateNormal];
        _breakfastBtn.layer.cornerRadius = 10;
        _breakfastBtn.backgroundColor = [UIColor orangeColor];
        [_breakfastBtn addTarget:self action:@selector(deleteBreakfast) forControlEvents:UIControlEventTouchUpInside];
    }
    return _breakfastBtn;
}
- (UIButton *)lunchBtn
{
    if (!_lunchBtn) {
        _lunchBtn = [[UIButton alloc]initWithFrame:CGRectMake(230, 0, 80, 30)];
        [_lunchBtn setTitle:@"删除午餐" forState:UIControlStateNormal];
        _lunchBtn.layer.cornerRadius = 10;
        _lunchBtn.backgroundColor = [UIColor orangeColor];
        [_lunchBtn addTarget:self action:@selector(deleteLunch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lunchBtn;
}
- (UIButton *)dinnerBtn
{
    if (!_dinnerBtn) {
        _dinnerBtn = [[UIButton alloc]initWithFrame:CGRectMake(230, 0, 80, 30)];
        [_dinnerBtn setTitle:@"删除晚餐" forState:UIControlStateNormal];
        _dinnerBtn.layer.cornerRadius = 10;
        _dinnerBtn.backgroundColor = [UIColor orangeColor];
        [_dinnerBtn addTarget:self action:@selector(deleteDinner) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dinnerBtn;
}
- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
        [_array removeAllObjects];
    }
    return _array;
}
- (NSMutableArray *)passBreakfastArr
{
    if (!_passBreakfastArr) {
        _passBreakfastArr = [NSMutableArray array];
    }
    return _passBreakfastArr;
}
- (NSMutableArray *)passLunchArr
{
    if (!_passLunchArr) {
        _passLunchArr = [NSMutableArray array];
    }
    return _passLunchArr;
}
- (NSMutableArray *)passDinnerArr
{
    if (!_passDinnerArr) {
        _passDinnerArr = [NSMutableArray array];
    }
    return _passDinnerArr;
}
- (NSMutableArray *)getBreakfastArr
{
    if (!_getBreakfastArr) {
        
        _getBreakfastArr = [NSMutableArray array];
    }
    return _getBreakfastArr;
}
- (NSMutableArray *)getLunchArr
{
    if (!_getLunchArr) {
        
        _getLunchArr = [NSMutableArray array];
    }
    return _getLunchArr;
}
- (NSMutableArray *)getDinnerArr
{
    if (!_getDinnerArr) {
        
        _getDinnerArr = [NSMutableArray array];
    }
    return _getDinnerArr;
}
- (NSMutableArray *)breakFastArr
{
    if (!_breakFastArr) {
        _breakFastArr = [[NSMutableArray alloc]initWithObjects:@"您的早餐", nil];
    }
    return _breakFastArr;
}
- (NSMutableArray *)lunchArr
{
    if (!_lunchArr) {
        _lunchArr = [[NSMutableArray alloc]initWithObjects:@"您的午餐", nil];
    }
    return _lunchArr;
}
- (NSMutableArray *)dinnerArr
{
    if (!_dinnerArr) {
        _dinnerArr = [[NSMutableArray alloc]initWithObjects:@"您的晚餐", nil];
    }
    return _dinnerArr;
}
#pragma mark - buttonClickMethods
- (void)deleteBreakfast
{
    //1.将状态赋值给tag
    self.breakfast_text.tag = UITableViewCellEditingStyleDelete;
    //2.获取当前状态
    BOOL edit = self.breakfast_text.editing;
    //3.设置当前状态
    [self.breakfast_text setEditing:!edit animated:YES];
}
- (void)deleteLunch
{
    self.lunch_text.tag = UITableViewCellEditingStyleDelete;
    BOOL edit = self.lunch_text.editing;
    [self.lunch_text setEditing:!edit animated:YES];
}
- (void)deleteDinner
{
    self.dinner_text.tag = UITableViewCellEditingStyleDelete;
    BOOL edit = self.dinner_text.editing;
    [self.dinner_text setEditing:!edit animated:YES];
}
#pragma mark - buildTableView
- (UITableView *)breakfast_text
{
    if (!_breakfast_text) {
        _breakfast_text = [[UITableView alloc]initWithFrame:CGRectMake(40, 60, 330, 130) style:UITableViewStylePlain];
        _breakfast_text.backgroundColor = [UIColor clearColor];
        _breakfast_text.delegate = self;
        _breakfast_text.dataSource = self;
        //监听早餐
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passBreakFast:) name:@"breakfast" object:nil];
    }
    return _breakfast_text;
}
- (UITableView *)lunch_text
{
    if (!_lunch_text) {
        _lunch_text = [[UITableView alloc]initWithFrame:CGRectMake(40, 260, 330, 140) style:UITableViewStylePlain];
        _lunch_text.backgroundColor = [UIColor clearColor];
        _lunch_text.delegate = self;
        _lunch_text.dataSource = self;
        //监听午餐
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passLunch:) name:@"lunch" object:nil];
    }
    return _lunch_text;
}
- (UITableView *)dinner_text
{
    if (!_dinner_text) {
        _dinner_text = [[UITableView alloc]initWithFrame:CGRectMake(40, 480, 330, 120) style:UITableViewStylePlain];
        _dinner_text.backgroundColor = [UIColor clearColor];
        _dinner_text.delegate = self;
        _dinner_text.dataSource = self;
        //监听晚餐
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passDinner:) name:@"dinner" object:nil];
    }
    return _dinner_text;
}
#pragma mark - NSNotification
- (void)passBreakFast:(NSNotification *)noti
{
    //name
    [self.breakFastArr addObject:noti.userInfo[@"breakfastName"]];
    //hot
    [self.passBreakfastArr addObject:noti.userInfo[@"breakfastHot"]];
    [self writeBreakfastHotToCache];
    [self writeBreakfastNameToCache];
    self.array = self.breakFastArr;
    [self.breakfast_text reloadData];
}

- (void)passLunch:(NSNotification *)noti
{   //name
    [self.lunchArr addObject:noti.userInfo[@"lunchName"]];
    //hot
    [self.passLunchArr addObject:noti.userInfo[@"lunchHot"]];
    self.array = self.lunchArr;
    [self writeLunchHotToCache];
    [self writeLunchNameToCache];
    [self.lunch_text reloadData];
}

- (void)passDinner:(NSNotification *)noti
{   //name
    [self.dinnerArr addObject:noti.userInfo[@"dinnerName"]];
    //hot
    [self.passDinnerArr addObject:noti.userInfo[@"dinnerHot"]];
    self.array = self.dinnerArr;
    [self writeDinnerHotToCache];
    [self writeDinnerNameToCache];
    [self.dinner_text reloadData];
}
#pragma mark - tableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.breakfast_text) {
        return self.breakFastArr.count;
    }
    else if(tableView == self.lunch_text){
        return self.lunchArr.count;
    }else if(tableView == self.dinner_text){
        return self.dinnerArr.count;
    }
    else{
        return 10;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }else{
    }
    
    cell.backgroundColor = [UIColor clearColor];
    if (self.array.count == 0)
    {
         if (tableView == self.breakfast_text&&[self.getBreakfastArr count]) {
             //NSLog(@"22getbreak = %@",self.getBreakfastArr);
             self.breakFastArr = self.getBreakfastArr;
            cell.textLabel.text = self.breakFastArr[indexPath.row];
             //NSLog(@"33getbreak = %@",self.getBreakfastArr);
        }
        else if (tableView == self.lunch_text&&[self.getLunchArr count]){
            self.lunchArr = self.getLunchArr;
            cell.textLabel.text = self.lunchArr[indexPath.row];
        }
        else if (tableView == self.dinner_text&&[self.getDinnerArr count]){
            self.dinnerArr = self.getDinnerArr;
            cell.textLabel.text = self.dinnerArr[indexPath.row];
        }
        else
        {
            cell.textLabel.text = @"快去添加美味吧！";
        }
    }
    else if (tableView == self.breakfast_text) {
        cell.textLabel.text = self.breakFastArr[indexPath.row];
        
    }else if (tableView == self.lunch_text){
        cell.textLabel.text = self.lunchArr[indexPath.row];
        
    }else if (tableView == self.dinner_text){
        cell.textLabel.text = self.dinnerArr[indexPath.row];
    }

    return cell;
}
#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self reloadTableView];
}
//设置tableview的tag
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.breakfast_text) {
        return self.breakfast_text.tag;
        
    }else if (tableView == self.lunch_text){
        return self.lunch_text.tag;
        
    }else if (tableView == self.dinner_text){
        return self.dinner_text.tag;
    }else
    {
        return tableView.tag;
    }
}
//删除数据
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == nil) {
        
    }else if (tableView == self.breakfast_text&&editingStyle == UITableViewCellEditingStyleDelete) {
        //从数组中删除
        [self.breakFastArr removeObjectAtIndex:indexPath.row];
        [self.breakfast_text deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }else if (tableView == self.lunch_text&&editingStyle == UITableViewCellEditingStyleDelete){
        //从数组中删除
        [self.lunchArr removeObjectAtIndex:indexPath.row];
        [self.lunch_text deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }else if (tableView == self.dinner_text&&editingStyle == UITableViewCellEditingStyleDelete){
        //从数组中删除
        [self.dinnerArr removeObjectAtIndex:indexPath.row];
        [self.dinner_text deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
    }
}

#pragma mark - cacheMethod
- (void)reloadTableView
{
    [self readBreakfastNameFromCache];
    [self readLunchNameFromCache];
    [self readDinnerNameFromCache];
    [self.breakfast_text reloadData];
    [self.lunch_text reloadData];
    [self.dinner_text reloadData];
}
- (void)writeBreakfastHotToCache
{
    NSArray *caches_arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches_str = caches_arr[0];
    NSString *path = [caches_str stringByAppendingPathComponent:@"breakfastHot.plist"];
    [self.passBreakfastArr writeToFile:path atomically:YES];
    //NSLog(@"passarr = %@",caches_str);
}
- (void)writeLunchHotToCache
{
    NSArray *caches_arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches_str = caches_arr[0];
    NSString *path = [caches_str stringByAppendingPathComponent:@"lunchHot.plist"];
    [self.passLunchArr writeToFile:path atomically:YES];
    //NSLog(@"passarr = %@",caches_str);

}
- (void)writeDinnerHotToCache
{
    NSArray *caches_arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches_str = caches_arr[0];
    NSString *path = [caches_str stringByAppendingPathComponent:@"dinnerHot.plist"];
    [self.passDinnerArr writeToFile:path atomically:YES];
    NSLog(@"passarr = %@",caches_str);
}
- (void)writeDinnerNameToCache
{
    NSArray *caches_arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches_str = caches_arr[0];
    NSString *path = [caches_str stringByAppendingPathComponent:@"dinnerName.plist"];
    [self.dinnerArr writeToFile:path atomically:YES];
    NSLog(@"passarr = %@",caches_str);

}
- (void)writeBreakfastNameToCache
{
    NSArray *caches_arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches_str = caches_arr[0];
    NSString *path = [caches_str stringByAppendingPathComponent:@"breakfastName.plist"];
    [self.breakFastArr writeToFile:path atomically:YES];
    //self.array = self.breakFastArr;
    NSLog(@"passarr = %@",caches_str);

}
- (void)writeLunchNameToCache
{
    NSArray *caches_arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches_str = caches_arr[0];
    NSString *path = [caches_str stringByAppendingPathComponent:@"lunchName.plist"];
    [self.lunchArr writeToFile:path atomically:YES];
   
}
//从缓存中读取
- (void)readBreakfastNameFromCache
{
    NSArray *caches_arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches_str = caches_arr[0];
    NSString *path = [caches_str stringByAppendingPathComponent:@"breakfastName.plist"];
    self.getBreakfastArr = [NSMutableArray arrayWithContentsOfFile:path];
    NSLog(@"getbreak = %@",self.getBreakfastArr);

}
- (void)readDinnerNameFromCache
{
    NSArray *caches_arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches_str = caches_arr[0];
    NSString *path = [caches_str stringByAppendingPathComponent:@"dinnerName.plist"];
    self.getDinnerArr = [NSMutableArray arrayWithContentsOfFile:path];
    //NSLog(@"get == %@",self.getDinnerArr);
    
}
- (void)readLunchNameFromCache
{
    NSArray *caches_arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches_str = caches_arr[0];
    NSString *path = [caches_str stringByAppendingPathComponent:@"lunchName.plist"];
    self.getLunchArr = [NSMutableArray arrayWithContentsOfFile:path];
    NSLog(@"getlunch == %@",self.getLunchArr);
}

@end
