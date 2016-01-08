//
//  OneFoodTableView.m
//  MyHealth
//
//  Created by imac on 15/11/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "OneFoodTableView.h"

@interface OneFoodTableView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation OneFoodTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
#pragma mark - 懒加载
- (NSArray *)array
{
    if (!_array) {
        _array = [NSArray array];
    }
    return _array;
}
#pragma mark - tableViewDatasource,delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    OneFoodModel *model = self.array[indexPath.row];
    cell.textLabel.text = model.foodName;
    cell.detailTextLabel.text = model.description;
    cell.imageView.image = [UIImage imageNamed:model.foodImage];
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
